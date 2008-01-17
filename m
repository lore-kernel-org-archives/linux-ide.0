From: Peter Schwenke <peter@bluetoad.com.au>
Subject: Re: [PATCH #upstream-fixes] ata_piix: Add Toshiba Satellite R20 and
 Tecra M6 to broken suspend list.
Date: Thu, 17 Jan 2008 23:08:55 +1000
Message-ID: <478F5367.8070102@bluetoad.com.au>
References: <478EC3C1.8070007@bluetoad.com.au> <478ECFA5.3040009@gmail.com> <478EFF30.20701@bluetoad.com.au> <478F0726.60303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1-6.pacific.net.au ([61.8.2.213]:42652 "EHLO
	mailout1.pacific.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751262AbYAQNI7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jan 2008 08:08:59 -0500
In-Reply-To: <478F0726.60303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, mattpiermarini@yahoo.com

From: Peter Schwenke <peter@bluetoad.com.au>

Add Toshiba Satellite R20 and Tecra M6 to broken suspend list.  Matt
Piermarini reported and provided the M6 patch.  This is from OSDL bug 7780.

Signed-off-by: Peter Schwenke <peter@bluetoad.com.au>
Cc: Matt Piermarini <mattpiermarini@yahoo.com>
---
 drivers/ata/ata_piix.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index bb62a58..867a263 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -988,6 +988,13 @@ static int piix_broken_suspend(void)
 			},
 		},
 		{
+			.ident = "TECRA M6",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "TECRA M6"),
+			},
+		},
+		{
 			.ident = "TECRA M7",
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
@@ -1002,6 +1009,13 @@ static int piix_broken_suspend(void)
 			},
 		},
 		{
+			.ident = "Satellite R20",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Satellite R20"),
+			},
+		},
+		{
 			.ident = "Satellite R25",
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-- 
1.5.2.5
