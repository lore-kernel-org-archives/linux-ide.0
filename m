From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_platform: set a cable type (which to set ?)
Date: Thu, 1 Mar 2007 18:18:56 +0000
Message-ID: <20070301181856.694deb7b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965446AbXCARO4@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2/drivers/ata/pata_platform.c linux-2.6.21-rc2/drivers/ata/pata_platform.c
--- linux.vanilla-2.6.21-rc2/drivers/ata/pata_platform.c	2007-03-01 13:36:03.000000000 +0000
+++ linux-2.6.21-rc2/drivers/ata/pata_platform.c	2007-03-01 15:04:47.368032464 +0000
@@ -80,6 +80,7 @@
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_unknown,
 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
