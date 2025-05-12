import requests
from typing import Dict, Any
import logging

# Configure logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class ApiHelper:

    def __init__(self, options: Dict[str, Any] = None):
        self.options = {
            'base_url': '',
            'headers': {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            'timeout': 30,
            **(options or {})
        }

        self.session = requests.Session()
        self.session.headers.update(self.options['headers'])

        self.base_url = self.options['base_url']
        self.timeout = self.options['timeout']


    def set_auth_token(self, token: str) -> None:
        self.session.headers['Authorization'] = f'Bearer {token}'
        logger.debug('Auth token set for API requests')

    def clear_auth_token(self) -> None:
        """Remove authentication token from headers"""
        self.session.headers.pop('Authorization', None)
        logger.debug('Auth token cleared from API requests')

    def _log_request(self, method: str, url: str, **kwargs) -> None:
        """Log request details"""
        logger.debug(f'API Request: {method.upper()} {url}', {
            'headers': kwargs.get('headers'),
            'data': kwargs.get('json')
        })

    def _log_response(self, response: requests.Response) -> None:
        """Log response details"""
        logger.debug(f'API Response: {response.status_code} {response.reason}', {
            'data': response.json() if response.headers.get('content-type') == 'application/json' else response.text,
            'headers': dict(response.headers)
        })

    def _handle_error(self, error: Exception, url: str) -> None:
        """Handle and log request errors"""
        if isinstance(error, requests.exceptions.RequestException):
            if error.response is not None:
                logger.error(f'API Error Response: {error.response.status_code}', {
                    'data': error.response.json() if error.response.headers.get('content-type') == 'application/json' else error.response.text,
                    'headers': dict(error.response.headers)
                })
            else:
                logger.error(f'API Request Error: {url}', str(error))
        else:
            logger.error(f'API Error: {url}', str(error))
        raise error

    async def get(self, url: str, params: Dict = None, **kwargs) -> Any:
        """
        Perform GET request
        
        Args:
            url (str): Endpoint URL
            params (Dict, optional): Query parameters
            **kwargs: Additional request parameters
            
        Returns:
            Any: Response data
        """
        try:
            self._log_request('GET', url, params=params, **kwargs)
            response = self.session.get(url, params=params, **kwargs)
            self._log_response(response)
            return response.json() if response.headers.get('content-type') == 'application/json' else response.text
        except Exception as e:
            self._handle_error(e, url)
            return None

    async def post(self, url: str, data: Dict = None, **kwargs) -> Any:
        """
        Perform POST request
        
        Args:
            url (str): Endpoint URL
            data (Dict, optional): Request body
            **kwargs: Additional request parameters
            
        Returns:
            Any: Response data
        """
        try:
            self._log_request('POST', url, json=data, **kwargs)
            response = self.session.post(url, json=data, **kwargs)
            self._log_response(response)
            return response.json() if response.headers.get('content-type') == 'application/json' else response.text
        except Exception as e:
            self._handle_error(e, url)
            return None

    async def put(self, url: str, data: Dict = None, **kwargs) -> Any:
        """
        Perform PUT request
        
        Args:
            url (str): Endpoint URL
            data (Dict, optional): Request body
            **kwargs: Additional request parameters
            
        Returns:
            Any: Response data
        """
        try:
            self._log_request('PUT', url, json=data, **kwargs)
            response = self.session.put(url, json=data, **kwargs)
            self._log_response(response)
            return response.json() if response.headers.get('content-type') == 'application/json' else response.text
        except Exception as e:
            self._handle_error(e, url)
            return None

    async def patch(self, url: str, data: Dict = None, **kwargs) -> Any:
        try:
            self._log_request('PATCH', url, json=data, **kwargs)
            response = self.session.patch(url, json=data, **kwargs)
            self._log_response(response)
            return response.json() if response.headers.get('content-type') == 'application/json' else response.text
        except Exception as e:
            self._handle_error(e, url)
            return None

    async def delete(self, url: str, **kwargs) -> Any:
        try:
            self._log_request('DELETE', url, **kwargs)
            response = self.session.delete(url, **kwargs)
            self._log_response(response)
            return response.json() if response.headers.get('content-type') == 'application/json' else response.text
        except Exception as e:
            self._handle_error(e, url)
            return None

    @classmethod
    def create_with_base_url(cls, base_url: str) -> 'ApiHelper':
        return cls({'base_url': base_url})
