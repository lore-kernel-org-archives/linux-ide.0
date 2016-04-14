From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: libata: check zero power ready status for ZPODD
Date: Thu, 14 Apr 2016 12:30:22 +0300
Message-ID: <20160414093022.GA16431@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42266 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbcDNJak (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Apr 2016 05:30:40 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: aaron.lu@intel.com
Cc: linux-ide@vger.kernel.org

Hello Aaron Lu,

The patch 3dc67440d99b: "libata: check zero power ready status for
ZPODD" from Jan 15, 2013, leads to the following static checker
warning:

	drivers/ata/libata-zpodd.c:97 zpready()
	error: uninitialized symbol 'sense_key'.

drivers/ata/libata-zpodd.c
    88  /* Test if ODD is zero power ready by sense code */
    89  static bool zpready(struct ata_device *dev)
    90  {
    91          u8 sense_key, *sense_buf;
    92          unsigned int ret, asc, ascq, add_len;
    93          struct zpodd *zpodd = dev->zpodd;
    94  
    95          ret = atapi_eh_tur(dev, &sense_key);
    96  
    97          if (!ret || sense_key != NOT_READY)
    98                  return false;

It's not clear what is going on here.  atapi_eh_tur() returns 0 on
success or a bit mask on error.  If the AC_ERR_DEV (which is BIT(0)) bit
is set and no other bits then we set "&sense_key" otherwise it is
uninitialized.

So maybe the test should be:

	if (ret != AC_ERR_DEV || sense_key != NOT_READY)
		return false;

That would silence the uninitialized variable warning but it's sort of
weird.  You would normall expect to return for errors and continue if
ret were zero.

	if (ret && !(ret == AC_ERR_DEV && ...

    99  
   100          sense_buf = dev->link->ap->sector_buf;
   101          ret = atapi_eh_request_sense(dev, sense_buf, sense_key);
   102          if (ret)
   103                  return false;

regards,
dan carpenter
