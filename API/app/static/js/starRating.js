
$("#rateBox").rate({

    // 0：svg  1：Font class  2：Unicode
    type: 0,
  
    // the number of stars
    length: 5,
  
    // initial value
    value: 3.5,
  
    // allows half star
    half: true,
  
    // supports decimal?
    decimal: true,
  
    // is readonly?
    readonly: true,
  
    // shows the current rating value on hover
    hover: false,
  
    // shows rating text
    text: true,
  
    // an array of rating text
    textList: ['Bad', 'Poor', 'Medium', 'Good', 'Perfect'],
  
    // color
    theme: '#FFB800',
  
    // text/star size
    size: '20px',
  
    // space between stars
    gutter: '3px',
  
    // default CSS classes
    selectClass: 'fxss_rate_select',
    incompleteClass: '', 
    customClass: ''
    
  });