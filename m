From: Tero Roponen <tero.roponen@gmail.com>
Subject: libata: init ata_print_id to 0
Date: Sun, 22 Apr 2012 11:38:00 +0300 (EEST)
Message-ID: <alpine.LFD.2.02.1204221136450.1947@terrop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48972 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab2DVIiF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2012 04:38:05 -0400
Received: by lbom4 with SMTP id m4so4920249lbo.19
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2012 01:38:04 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Jeff Garzik <jgarzik@redhat.com>


When comparing the dmesg between 3.4-rc3 and 3.4-rc4 I found the
following differences:

 -ata1: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff100 irq 47
 -ata2: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff180 irq 47
 -ata3: DUMMY
 +ata2: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff100 irq 47
 +ata3: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff180 irq 47
  ata4: DUMMY
  ata5: DUMMY
 -ata6: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff380 irq 47
 +ata6: DUMMY
 +ata7: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff380 irq 47

The change of numbering comes from commit 85d6725b7c0d7e3f ("libata:
make ata_print_id atomic") that changed lines like

	ap->print_id = ata_print_id++;
		to
	ap->print_id = atomic_inc_return(&ata_print_id);

As the latter behaves like ++ata_print_id, we must initialize
it to zero to start the numbering from one.

Signed-off-by: Tero Roponen <tero.roponen@gmail.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 28db50b..23763a1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -95,7 +95,7 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
 static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
 
-atomic_t ata_print_id = ATOMIC_INIT(1);
+atomic_t ata_print_id = ATOMIC_INIT(0);
 
 struct ata_force_param {
 	const char	*name;
