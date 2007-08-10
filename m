From: akpm@linux-foundation.org
Subject: [patch 25/25] ata_piix: disallow UDMA 133 on ICH5 & ICH7
Date: Fri, 10 Aug 2007 13:59:51 -0700
Message-ID: <200708102059.l7AKxpv1008645@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36281 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762539AbXHJVQY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:16:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, chunkeey@web.de, alan@lxorguk.ukuu.org.uk, htejun@gmail.com

From: Christian Lamparter <chunkeey@web.de>

There is another outstanding issue with ata_piix.c.  Intel has never
officially supported anything faster than PATA 100MB/s.

But, the ata_piix.c driver "define" the ICH5 & ICH7 as UDMA6 (aka 133MB/s)
capable.  [ Well, no one has probably noticed it before, because there is bug
in do_pata_set_dmamode...  Just look at
libata_atapiix_enable_real_udma133.patch and you'll see what wrong with it.  ]


Here are Intel's datasheets for the affected chipsets: ICH5 Datasheet:
http://www.intel.com/design/chipsets/datashts/252516.htm (See note on page
183: "...  the ICH5 supports reads at the maximum rate of 100MB/s.")

ICH7 Datasheet: http://www.intel.com/design/chipsets/datashts/307013.htm (See
first note on page 190: "...  the ICH7 supports reads at the maximum rate of
100MB/s.")

They are two different ways to deal with it:

- Either -

1. replace all ich_pata_133 with ich_pata_100. 
   (libata_atapiix_disable_udma6.diff - diff from 2.6.22 )

- Or -

2. keep all ich_pata_133 and fix the bug in "do_pata_set_dmamode". 
   (libata_atapiix_enable_real_udma133.patch - diff from 2.6.22) If there are
   any concerns about the safety of the patch patch:
   http://lkml.org/lkml/2007/7/6/292 (It was already tested by an Intel
   employee, but I guess a bit more user input is necessary here...  )

This patch implements 1.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Christian Lamparter <chunkeey@web.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/ata_piix.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/ata/ata_piix.c~ata_piix-disallow-udma-133-on-ich5-ich7 drivers/ata/ata_piix.c
--- a/drivers/ata/ata_piix.c~ata_piix-disallow-udma-133-on-ich5-ich7
+++ a/drivers/ata/ata_piix.c
@@ -123,7 +123,7 @@ enum {
 	ich_pata_33		= 1,	/* ICH up to UDMA 33 only */
 	ich_pata_66		= 2,	/* ICH up to 66 Mhz */
 	ich_pata_100		= 3,	/* ICH up to UDMA 100 */
-	ich_pata_133		= 4,	/* ICH up to UDMA 133 */
+	/* ICH up to UDMA 133 is not supported */
 	ich5_sata		= 5,
 	ich6_sata		= 6,
 	ich6_sata_ahci		= 7,
@@ -198,7 +198,7 @@ static const struct pci_device_id piix_p
 	{ 0x8086, 0x24CA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	{ 0x8086, 0x24CB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	/* Intel ICH5 */
-	{ 0x8086, 0x24DB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
+	{ 0x8086, 0x24DB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	/* C-ICH (i810E2) */
 	{ 0x8086, 0x245B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	/* ESB (855GME/875P + 6300ESB) UDMA 100  */
@@ -206,7 +206,7 @@ static const struct pci_device_id piix_p
 	/* ICH6 (and 6) (i915) UDMA 100 */
 	{ 0x8086, 0x266F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	/* ICH7/7-R (i945, i975) UDMA 100*/
-	{ 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
+	{ 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	/* ICH8 Mobile PATA Controller */
 	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
@@ -489,7 +489,7 @@ static struct ata_port_info piix_port_in
 		.port_ops	= &ich_pata_ops,
 	},
 
-	/* ich_pata_133: 4 	ICH with full UDMA6 */
+	/* ich_pata_133: 4 - Not supported - */
 	{
 		.sht		= &piix_sht,
 		.flags		= PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
_
