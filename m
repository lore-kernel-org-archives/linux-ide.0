From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 48/86] pata_legacy: add pointers to QDI65x0 documentation
Date: Wed, 25 Nov 2009 18:08:02 +0100
Message-ID: <20091125170802.5446.46013.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932705AbZKYRIq@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_legacy: add pointers to QDI65x0 documentation

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_legacy.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: b/drivers/ata/pata_legacy.c
===================================================================
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -25,6 +25,13 @@
  *		http://www.ryston.cz/petr/vlb/pdc20230b.html
  *		http://www.ryston.cz/petr/vlb/pdc20230c.html
  *		http://www.ryston.cz/petr/vlb/pdc20630.html
+ *	QDI65x0:
+ *		http://www.ryston.cz/petr/vlb/qd6500.html
+ *		http://www.ryston.cz/petr/vlb/qd6580.html
+ *
+ *	QDI65x0 probe code based on drivers/ide/legacy/qd65xx.c
+ *	Rewritten from the work of Colten Edwards <pje120@cs.usask.ca> by
+ *	Samuel Thibault <samuel.thibault@ens-lyon.org>
  *
  *  Unsupported but docs exist:
  *	Appian/Adaptec AIC25VL01/Cirrus Logic PD7220
@@ -35,7 +42,7 @@
  *  the MPIIX where the tuning is PCI side but the IDE is "ISA side".
  *
  *  Specific support is included for the ht6560a/ht6560b/opti82c611a/
- *  opti82c465mv/promise 20230c/20630/winbond83759A
+ *  opti82c465mv/promise 20230c/20630/qdi65x0/winbond83759A
  *
  *  Use the autospeed and pio_mask options with:
  *	Appian ADI/2 aka CLPD7220 or AIC25VL01.
