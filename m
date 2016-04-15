From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: libata: check zero power ready status for ZPODD
Date: Fri, 15 Apr 2016 10:34:08 +0800
Message-ID: <57105320.20208@intel.com>
References: <20160414093022.GA16431@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36405 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779AbcDOCeL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Apr 2016 22:34:11 -0400
In-Reply-To: <20160414093022.GA16431@mwanda>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-ide@vger.kernel.org

On 04/14/2016 05:30 PM, Dan Carpenter wrote:
> Hello Aaron Lu,
> 
> The patch 3dc67440d99b: "libata: check zero power ready status for
> ZPODD" from Jan 15, 2013, leads to the following static checker
> warning:
> 
> 	drivers/ata/libata-zpodd.c:97 zpready()
> 	error: uninitialized symbol 'sense_key'.
> 
> drivers/ata/libata-zpodd.c
>     88  /* Test if ODD is zero power ready by sense code */
>     89  static bool zpready(struct ata_device *dev)

This function returns true if ODD is zero power ready, false otherwise.

>     90  {
>     91          u8 sense_key, *sense_buf;
>     92          unsigned int ret, asc, ascq, add_len;
>     93          struct zpodd *zpodd = dev->zpodd;
>     94  
>     95          ret = atapi_eh_tur(dev, &sense_key);
>     96  
>     97          if (!ret || sense_key != NOT_READY)
>     98                  return false;

The pre-condition that the ODD can be considered zero power ready is:
there is no medium inside(hence, atapi_eh_tur should return a failure)
and the sense_key is set to NOT_READY. If the pre-condition is not
met as is checked by the above if, we return false.

> 
> It's not clear what is going on here.  atapi_eh_tur() returns 0 on
> success or a bit mask on error.  If the AC_ERR_DEV (which is BIT(0)) bit
> is set and no other bits then we set "&sense_key" otherwise it is
> uninitialized.

Good point, thanks for the catch.

> 
> So maybe the test should be:
> 
> 	if (ret != AC_ERR_DEV || sense_key != NOT_READY)
> 		return false;

I think I will simply set sense_key to zero beforehand instead of
changing the condition logic here, and it follows the other usage of the
atapi_eh_tur in atapi_eh_clear_ua where the sense_key is also set to 0
beforehand.


>From dda5c9306920ef973c9bf42db7723b86ab8b2930 Mon Sep 17 00:00:00 2001
From: Aaron Lu <aaron.lu@intel.com>
Date: Fri, 15 Apr 2016 10:30:32 +0800
Subject: [PATCH] libata: zpodd: initialize sense_key

The sense_key could be uninitialized after the call to atapi_eh_tur so
initialize it beforehand.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-zpodd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index f3a65a3140d3..b0d3ea5f4769 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -88,7 +88,7 @@ static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
 /* Test if ODD is zero power ready by sense code */
 static bool zpready(struct ata_device *dev)
 {
-	u8 sense_key, *sense_buf;
+	u8 sense_key = 0, *sense_buf;
 	unsigned int ret, asc, ascq, add_len;
 	struct zpodd *zpodd = dev->zpodd;
 
-- 
2.5.5

