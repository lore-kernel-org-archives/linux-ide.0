From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: disable ATAPI AN by default
Date: Wed, 19 May 2010 15:38:58 +0200
Message-ID: <4BF3E9F2.9050608@kernel.org>
References: <20100517225405.GA19825@cpu18.student.cs> <20100518132519.GA19658@elliptictech.com> 	<AANLkTimq8xS00gKHjjWh4OKQ2u01OutzCHqb_NgCLojx@mail.gmail.com> 	<20100518162350.GA29594@elliptictech.com> <AANLkTimgcvrTQWxwldVPfb0xGm2oa6vznJcZcDydIBBk@mail.gmail.com> 	<4BF2D8E8.1040602@kernel.org> <AANLkTikJhC3g6aOkKzSGNybNP7s8ODrWBsQ29Lgw9On1@mail.gmail.com> 	<4BF2DC55.5010209@kernel.org> <AANLkTimrKbTObcNwZmiYitAXqoqMERYHO9GTRP_FQCfr@mail.gmail.com> 	<20100518192300.GA30821@elliptictech.com> <AANLkTilvhCvaDWXMYbQF5vMLDIv58rY__i7nwclNyo2K@mail.gmail.com> <4BF3E64D.2040003@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39784 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684Ab0ESNjP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2010 09:39:15 -0400
In-Reply-To: <4BF3E64D.2040003@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Nick Bowler <nbowler@elliptictech.com>, David Zeuthen <david@fubar.dk>, linux-hotplug@vger.kernel.org, stable@kernel.org

There are ATAPI devices which raise AN when hit by commands issued by
open().  This leads to infinite loop of AN -> MEDIA_CHANGE uevent ->
udev open() to check media -> AN.

Both ACS and SerialATA standards don't define in which case ATAPI
devices are supposed to raise or not raise AN.  They both list media
insertion event as a possible use case for ATAPI ANs but there is no
clear description of what constitutes such events.  As such, it seems
a bit too naive to export ANs directly to userland as MEDIA_CHANGE
events without further verification (which should behave similarly to
windows as it apparently is the only thing that some hardware vendors
are testing against).

This patch adds libata.atapi_an module parameter and disables ATAPI AN
by default for now.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Kay Sievers <kay.sievers@vrfy.org>
Cc: Nick Bowler <nbowler@elliptictech.com>
Cc: David Zeuthen <david@fubar.dk>
Cc: stable@kernel.org
---
 drivers/ata/libata-core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 49cffb6..5abab5d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -160,6 +160,10 @@ int libata_allow_tpm = 0;
 module_param_named(allow_tpm, libata_allow_tpm, int, 0444);
 MODULE_PARM_DESC(allow_tpm, "Permit the use of TPM commands (0=off [default], 1=on)");

+static int atapi_an;
+module_param(atapi_an, int, 0444);
+MODULE_PARM_DESC(atapi_an, "Enable ATAPI AN media presence notification (0=0ff [default], 1=on)");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -2572,7 +2576,8 @@ int ata_dev_configure(struct ata_device *dev)
 		 * to enable ATAPI AN to discern between PHY status
 		 * changed notifications and ATAPI ANs.
 		 */
-		if ((ap->flags & ATA_FLAG_AN) && ata_id_has_atapi_AN(id) &&
+		if (atapi_an &&
+		    (ap->flags & ATA_FLAG_AN) && ata_id_has_atapi_AN(id) &&
 		    (!sata_pmp_attached(ap) ||
 		     sata_scr_read(&ap->link, SCR_NOTIFICATION, &sntf) == 0)) {
 			unsigned int err_mask;
