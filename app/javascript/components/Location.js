import React from "react"
import PropTypes from "prop-types"

class Location extends React.Component {
  render () {
    return (
      <React.Fragment>
        <li>Location Name: {this.props.locationName}</li>
        <li>Country: {this.props.areaId}, {this.props.areaName}</li>
      </React.Fragment>
    );
  }
}

Location.propTypes = {
  locationName: PropTypes.string,
  areaId: PropTypes.string,
  areaName: PropTypes.string,
  locationKey: PropTypes.node
};
export default Location
