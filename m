From: Tobias Oetiker <tobi@oetiker.ch>
Subject: [PATCH] add Hitachi Travelstar 7k200 to the NCQ blacklist
Date: Sun, 16 Sep 2007 16:16:49 +0200 (CEST)
Message-ID: <alpine.DEB.0.999.0709161558090.18435@wbuna.brgvxre.pu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from james.oetiker.ch ([213.144.138.195]:53662 "EHLO
	james.oetiker.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbXIPOqi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Sep 2007 10:46:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by james.oetiker.ch (Postfix) with ESMTP id 8B08E88CFC
	for <linux-ide@vger.kernel.org>; Sun, 16 Sep 2007 16:16:50 +0200 (MEST)
Received: from james.oetiker.ch ([127.0.0.1])
	by localhost (james.oetiker.ch [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6Ciu6fBDSKVr for <linux-ide@vger.kernel.org>;
	Sun, 16 Sep 2007 16:16:50 +0200 (CEST)
Received: from johan.oetiker.ch (johan.oetiker.ch [213.144.133.194])
	by james.oetiker.ch (Postfix) with ESMTP id 252BE889E3
	for <linux-ide@vger.kernel.org>; Sun, 16 Sep 2007 16:16:50 +0200 (MEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The Hitachi Travelstar 7k200 does not play along nicely with the
way linux uses its NCQ feature. It should be on the blacklist.

see http://bugzilla.kernel.org/show_bug.cgi?id=9022 for details

Signed-off-by: Tobi Oetiker <tobi@oetiker.ch>

--- linux-2.6.22.6.orig/drivers/ata/libata-core.c	2007-08-23 01:23:54.000000000 +0200
+++ linux-2.6.22.6/drivers/ata/libata-core.c	2007-09-15 01:41:53.000000000 +0200
@@ -3798,6 +3798,7 @@
 	/* Drives which do spurious command completion */
 	{ "HTS541680J9SA00",	"SB2IC7EP",	ATA_HORKAGE_NONCQ, },
 	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
+	{ "Hitachi HTS722016K9SA00", "DCDOC54P", ATA_HORKAGE_NONCQ, },
 	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
 	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },


-- 
Tobi Oetiker, OETIKER+PARTNER AG, Aarweg 15 CH-4600 Olten
http://it.oetiker.ch tobi@oetiker.ch ++41 62 213 9902
