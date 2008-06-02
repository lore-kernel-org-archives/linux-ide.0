From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/9] delkin_cb: add missing __init/__exit tags
Date: Mon, 02 Jun 2008 22:23:34 +0200
Message-ID: <20080602202334.7265.5379.sendpatchset@localhost.localdomain>
References: <20080602202253.7265.23590.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:17008 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbYFBUWL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2008 16:22:11 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1229319mue.1
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2008 13:22:10 -0700 (PDT)
In-Reply-To: <20080602202253.7265.23590.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/delkin_cb.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: b/drivers/ide/pci/delkin_cb.c
===================================================================
--- a/drivers/ide/pci/delkin_cb.c
+++ b/drivers/ide/pci/delkin_cb.c
@@ -134,14 +134,12 @@ static struct pci_driver driver = {
 	.remove		= delkin_cb_remove,
 };
 
-static int
-delkin_cb_init (void)
+static int __init delkin_cb_init(void)
 {
 	return pci_register_driver(&driver);
 }
 
-static void
-delkin_cb_exit (void)
+static void __exit delkin_cb_exit(void)
 {
 	pci_unregister_driver(&driver);
 }
