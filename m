From: Philip Langdale <philipl@overt.org>
Subject: [PATCH] Resend: Add Hitachi HTS722020K9A300 to ncq blacklist
Date: Fri, 28 Sep 2007 12:43:10 -0400
Message-ID: <3f13d76aa5dae34fededd9a7bf4d51b6@localhost>
References: <46EC2088.2000407@overt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from usul.saidi.cx ([204.11.33.34]:44701 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752219AbXI1Qqm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 12:46:42 -0400
Received: from www-data by usul.overt.org with local (Exim 4.63)
	(envelope-from <philipl@overt.org>)
	id 1IbIvm-0005GH-AJ
	for linux-ide@vger.kernel.org; Fri, 28 Sep 2007 12:43:10 -0400
In-Reply-To: <46EC2088.2000407@overt.org>
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


