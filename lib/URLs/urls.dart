class NetworkResponse {
  int? statusCode;
  bool success;
  dynamic jsonResponse;
  String? errorMessage;

  // Default constructor
  NetworkResponse({
    this.statusCode,
    required this.success,
    this.jsonResponse,
    required this.errorMessage,
  }) {
    // Fill in default values if necessary
    statusCode ??= 200; // Assuming 200 is the default status code for success
    jsonResponse ??= {}; // Assuming an empty map as default JSON response
  }

  // Named constructor for successful response
  NetworkResponse.success(int statusCode, this.jsonResponse)
      : success = true,
        statusCode = statusCode ?? 200, // Fill in default status code if null
        errorMessage = null;

  // Named constructor for failed response
  NetworkResponse.failure(int statusCode, String errorMessage)
      : success = false,
        statusCode = statusCode,
        errorMessage = errorMessage;
}




class Urls {
  static String url = 'http://testflutter.felixeladi.co.ke/TaskManager/';
  static String registration = '$url/signup.php';
  static String login = '$url/signin.php';
  static String createNewTask = '$url/createTask.php';
  static String getNewTasks = '$url/getNewTask.php';
  static String getProgressTasks = '$url/getInProgressTask.php';
  static String getCompletedTasks = '$url/getCompletedTask.php';
  static String getCancelledTasks = '$url/getCancelledask.php';

}

