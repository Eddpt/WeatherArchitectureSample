//
//  WeatherTableViewCell.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 08/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import UIKit

final class WeatherTableViewCell : UITableViewCell {
  @IBOutlet private var dateLabel: UILabel!
  @IBOutlet private var minTemperatureLabel: UILabel!
  @IBOutlet private var maxTemperatureLabel: UILabel!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    dateLabel.text = nil
    minTemperatureLabel.text = nil
    maxTemperatureLabel.text = nil
  }
}

extension WeatherTableViewCell : ConfigurableCell {
  func configure(forObject weatherRecord: WeatherRecord) {
    dateLabel.text = self.dynamicType.dateFormatter.stringFromDate(weatherRecord.recordDate)
    minTemperatureLabel.text = String(format: "%.0f", weatherRecord.minTemperature)
    maxTemperatureLabel.text = String(format: "%.0f", weatherRecord.maxTemperature)
  }
    
  private static var dateFormatter: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    return dateFormatter
  }()
}