From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-core: support wildcard matching in ata_blacklist_entry
Date: Thu, 20 Sep 2007 16:33:43 -0400
Message-ID: <46F2D927.5040002@garzik.org>
References: <20070809204929.GA24651@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000909010100010209060005"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48308 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754772AbXITUdr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Sep 2007 16:33:47 -0400
In-Reply-To: <20070809204929.GA24651@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

This is a multi-part message in MIME format.
--------------000909010100010209060005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Milburn wrote:
> Support the use of '*' in model_num and model_rev entries
> in ata_device_blacklist[].
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Signed-off-by: David Milburn <dmilburn@redhat.com>

applied a modified version (attached)


--------------000909010100010209060005
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

commit 6d7fdd50ff25e6997ab581a2eff0a53f9228829a
Author: Jeff Garzik <jeff@garzik.org>
Date:   Thu Sep 20 16:31:47 2007 -0400

    [libata] blacklist Maxtor*BANC* using new wildcard blacklist matching
    
    Support the use of '*' in model_num and model_rev entries
    in ata_device_blacklist[].
    
    Based largely on David Milburn's "libata-core: support wildcard matching
    in ata_blacklist_entry" patch.
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

 drivers/ata/libata-core.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

6d7fdd50ff25e6997ab581a2eff0a53f9228829a
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 84d81b2..2b22270 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3814,16 +3814,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* http://thread.gmane.org/gmane.linux.ide/14907 */
 	{ "FUJITSU MHT2060BH",	NULL,		ATA_HORKAGE_NONCQ },
 	/* NCQ is broken */
-	{ "Maxtor 6L250S0",     "BANC1G10",     ATA_HORKAGE_NONCQ },
-	{ "Maxtor 6B200M0",	"BANC1BM0",	ATA_HORKAGE_NONCQ },
-	{ "Maxtor 6B200M0",	"BANC1B10",	ATA_HORKAGE_NONCQ },
-	{ "Maxtor 7B250S0",	"BANC1B70",	ATA_HORKAGE_NONCQ, },
-	{ "Maxtor 7B300S0",	"BANC1B70",	ATA_HORKAGE_NONCQ },
+	{ "Maxtor *",		"BANC*",	ATA_HORKAGE_NONCQ },
 	{ "Maxtor 7V300F0",	"VA111630",	ATA_HORKAGE_NONCQ },
 	{ "HITACHI HDS7250SASUN500G 0621KTAWSD", "K2AOAJ0AHITACHI",
-	 ATA_HORKAGE_NONCQ },
-	/* NCQ hard hangs device under heavier load, needs hard power cycle */
-	{ "Maxtor 6B250S0",	"BANC1B70",	ATA_HORKAGE_NONCQ },
+	  ATA_HORKAGE_NONCQ },
+
 	/* Blacklist entries taken from Silicon Image 3124/3132
 	   Windows driver .inf file - also several Linux problem reports */
 	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
@@ -3849,6 +3844,23 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ }
 };
 
+int strn_pattern_cmp(const char *patt, const char *name, int wildchar)
+{
+	const char *p;
+	int len;
+
+	/*
+	 * check for trailing wildcard: *\0
+	 */
+	p = strchr(patt, wildchar);
+	if (p && ((*(p + 1)) == 0))
+		len = p - patt;
+	else
+		len = strlen(name);
+
+	return strncmp(patt, name, len);
+}
+
 static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
@@ -3859,10 +3871,10 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
 	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
 
 	while (ad->model_num) {
-		if (!strcmp(ad->model_num, model_num)) {
+		if (!strn_pattern_cmp(ad->model_num, model_num, '*')) {
 			if (ad->model_rev == NULL)
 				return ad->horkage;
-			if (!strcmp(ad->model_rev, model_rev))
+			if (!strn_pattern_cmp(ad->model_rev, model_rev, '*'))
 				return ad->horkage;
 		}
 		ad++;

--------------000909010100010209060005--
