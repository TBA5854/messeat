package com.example.messeat

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import io.flutter.Log

/**
 * Implementation of App Widget functionality.
 */
class Today_Manu : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

internal fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
    val widgetText = HomeWidgetPlugin.getData(context)
    // Construct the RemoteViews object
    val views = RemoteViews(context.packageName, R.layout.today__manu).apply {
        val menu = widgetText.getString("menu","not");
        val mealType = widgetText.getString("meal_type","not");
        val time = widgetText.getString("time","not");
        setTextViewText(R.id.menu, menu);
        setTextViewText(R.id.meal_type, "$mealType");
        setTextViewText(R.id.time, time);
Log.d("heellllooooo there...","$widgetText");
Log.d("$time","$menu");
    }

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}