From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: add PCI ID for new VIA chip
Date: Wed, 11 Apr 2007 17:27:14 +0900
Message-ID: <20070411082714.GC10619@htj.dyndns.org>
References: <6f61137b0704021327r29739526g359a94567f123a4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:22363 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbXDKI1U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 04:27:20 -0400
Received: by an-out-0708.google.com with SMTP id b33so112608ana
        for <linux-ide@vger.kernel.org>; Wed, 11 Apr 2007 01:27:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6f61137b0704021327r29739526g359a94567f123a4d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maarten Vanraes <maarten.vanraes@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Add PCI ID for new VIA chip.  Original patch is from Maarten Vanraes.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Maarten Vanraes <maarten.vanraes@gmail.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index faa7588..3675964 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -413,6 +413,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 
 	/* VIA */
 	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
+	{ PCI_VDEVICE(VIA, 0x6287), board_ahci_vt8251 }, /* VIA VT8251 */
 
 	/* NVIDIA */
 	{ PCI_VDEVICE(NVIDIA, 0x044c), board_ahci },		/* MCP65 */
