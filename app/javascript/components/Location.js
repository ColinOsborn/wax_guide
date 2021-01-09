import React from "react"
import PropTypes from "prop-types"

class Location extends React.Component {
  render () {
    return (
      <React.Fragment>
        Location Name: {this.props.locationName}
        Area: {this.props.areaId}
        Area Name: {this.props.areaName}
        Location Key: {this.props.locationKey}
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
