package ir.mlggrand.mysql_app

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

//    private val CHANNEL = "https://mlggrand2.ir/"
//    private var startString: String? = null
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine)
//
//        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
//            if (call.method == "initialLink") {
//                if (startString != null) {
//                    result.success(startString)
//                }
//            }
//        }
//    }
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//
//        val intent = getIntent()
//        startString = intent.data?.toString()
//    }
//    override fun onNewIntent(intent: Intent) {
//        super.onNewIntent(intent)
//        if (intent.action === Intent.ACTION_VIEW) {
//            linksReceiver?.onReceive(this.applicationContext, intent)
//        }
//    }
//    fun createChangeReceiver(events: EventSink): BroadcastReceiver? {
//        return object : BroadcastReceiver() {
//            override fun onReceive(context: Context, intent: Intent) { // NOTE: assuming intent.getAction() is Intent.ACTION_VIEW
//                val dataString = intent.dataString ?:
//                events.error("UNAVAILABLE", "Link unavailable", null)
//                events.success(dataString)
//            }
//        }
//    }

}
