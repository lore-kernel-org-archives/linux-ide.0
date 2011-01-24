From: Francesco Antonacci <fraanto@gmail.com>
Subject: patch for "failed to set xfermode (err_mask=0x4)" with PIONEER DVD-RW
 DVR-212D
Date: Mon, 24 Jan 2011 16:53:40 +0100
Message-ID: <4D3DA084.9070609@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050504020308020309020507"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58113 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab1AXPyE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 10:54:04 -0500
Received: by wyb28 with SMTP id 28so4206683wyb.19
        for <linux-ide@vger.kernel.org>; Mon, 24 Jan 2011 07:54:02 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, tj@kernel.org

This is a multi-part message in MIME format.
--------------050504020308020309020507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Signed-off-by https://bugzilla.kernel.org/show_bug.cgi?id=27502

--------------050504020308020309020507
Content-Type: text/plain;
 name="libata-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libata-fix.patch"

--- linux-2.6.36/drivers/ata/libata-core.c	2010-10-20 16:30:22.000000000 -0400
+++ linux-2.6.36/drivers/ata/libata-core.c.modified	2010-11-04 15:08:35.845000045 -0400
@@ -4258,6 +4258,8 @@
 	 * device and controller are SATA.
 	 */
 	{ "PIONEER DVD-RW  DVRTD08",	"1.00",	ATA_HORKAGE_NOSETXFER },
+	{ "PIONEER DVD-RW  DVR-212D",	"1.28",	ATA_HORKAGE_NOSETXFER },
+	
 
 	/* End Marker */
 	{ }

--------------050504020308020309020507--
