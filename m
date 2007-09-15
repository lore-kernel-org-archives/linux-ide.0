From: Philip Langdale <philipl@overt.org>
Subject: Add Hitachi HTS722020K9A300 to ncq blacklist
Date: Sat, 15 Sep 2007 11:12:24 -0700
Message-ID: <46EC2088.2000407@overt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from usul.saidi.cx ([204.11.33.34]:35194 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751919AbXIOSxz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Sep 2007 14:53:55 -0400
Received: from c-76-21-109-3.hsd1.ca.comcast.net ([76.21.109.3] helo=[192.168.0.2])
	by usul.overt.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <philipl@overt.org>)
	id 1IWc5U-0008Gp-Bn
	for linux-ide@vger.kernel.org; Sat, 15 Sep 2007 14:09:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

My new Dell XPS m1330 comes with this Hitachi drive. You'd think they'd have
sorted things out by now but it produces tons of spurious completion errors
when NCQ is on.

Signed-off-by: Philip Langdale <philipl@overt.org>

--- linux-2.6.22/drivers/ata/libata-core.c	2007-08-24 16:13:37.000000000 -0700
+++ linux-new/drivers/ata/libata-core.c	2007-08-26 16:03:15.215383641 -0700
@@ -3801,6 +3801,7 @@
 	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
 	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
+	{ "Hitachi HTS722020K9A300", "DC4OC54P", ATA_HORKAGE_NONCQ, },

 	/* Devices with NCQ limits */

