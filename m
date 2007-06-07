From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Correct abuse of language
Date: Thu, 7 Jun 2007 16:13:55 +0100
Message-ID: <20070607161355.3d3bc35c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34298 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757454AbXFGPJ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jun 2007 11:09:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

The controller is not reporting an unlawful type, it is reporting an
invalid type. Illegal specifically means "prohibited by law" [1]

Signed-off-by: Alan Cox <alan@redhat.com>
[1] Microsoft BSOD excepted - and that has another mistake too - it says
"your software" meaning "our software" according to their licence.


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/drivers/ata/libata-core.c linux-2.6.22-rc4-mm2/drivers/ata/libata-core.c
--- linux.vanilla-2.6.22-rc4-mm2/drivers/ata/libata-core.c	2007-06-07 14:26:08.000000000 +0100
+++ linux-2.6.22-rc4-mm2/drivers/ata/libata-core.c	2007-06-07 14:45:37.000000000 +0100
@@ -1698,7 +1702,7 @@
 
 	/* sanity check */
 	rc = -EINVAL;
-	reason = "device reports illegal type";
+	reason = "device reports invalid type";
 
 	if (class == ATA_DEV_ATA) {
 		if (!ata_id_is_ata(id) && !ata_id_is_cfa(id))
