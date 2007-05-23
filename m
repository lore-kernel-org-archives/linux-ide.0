From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: -ENODEV during prereset isn't an error
Date: Wed, 23 May 2007 11:58:52 +0200
Message-ID: <4654105C.5030908@gmail.com>
References: <20070523064408.GA29593@linux-sh.org> <4653F62C.4070700@gmail.com> <20070523083026.GA29851@linux-sh.org> <46540981.9080603@gmail.com> <20070523094858.GA30352@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:52749 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758049AbXEWJ7V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 05:59:21 -0400
Received: by nz-out-0506.google.com with SMTP id o37so164143nzf
        for <linux-ide@vger.kernel.org>; Wed, 23 May 2007 02:59:20 -0700 (PDT)
In-Reply-To: <20070523094858.GA30352@linux-sh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

During prereset, -ENODEV return from ata_wait_ready() is not an error.
This causes unnecessary bug message on controllers which uses 0xff to
indicate empty port.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>
---

This one is for 2.6.22 too.  Thanks.

 libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a6de57e..79f2175 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3368,7 +3368,7 @@ int ata_std_prereset(struct ata_port *ap
 	 */
 	if (!(ap->flags & ATA_FLAG_SKIP_D2H_BSY) && !ata_port_offline(ap)) {
 		rc = ata_wait_ready(ap, deadline);
-		if (rc) {
+		if (rc && rc != -ENODEV) {
 			ata_port_printk(ap, KERN_WARNING, "device not ready "
 					"(errno=%d), forcing hardreset\n", rc);
 			ehc->i.action |= ATA_EH_HARDRESET;
