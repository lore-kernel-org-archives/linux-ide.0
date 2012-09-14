From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: Re: linux-next: Tree for Sept 14 (sata_highhbank)
Date: Fri, 14 Sep 2012 17:02:59 -0500
Message-ID: <5053A993.8090408@calxeda.com>
References: <20120914173813.fa65528e5236bd0a20c29b92@canb.auug.org.au> <505363BA.1010604@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp191.dfw.emailsrvr.com ([67.192.241.191]:39996 "EHLO
	smtp191.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2INWCH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Sep 2012 18:02:07 -0400
In-Reply-To: <505363BA.1010604@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 09/14/2012 12:04 PM, Randy Dunlap wrote:
> On 09/14/2012 12:38 AM, Stephen Rothwell wrote:
> 
>> Hi all,
>>
>> Changes since 201209013:
>>
> 
> 
> 
> on i386:
> 
> CONFIG_SATA_HIGHBANK=m
> # CONFIG_SATA_AHCI_PLATFORM is not set
> 
> ERROR: "ahci_sdev_attrs" [drivers/ata/sata_highbank.ko] undefined!
> ERROR: "ahci_shost_attrs" [drivers/ata/sata_highbank.ko] undefined!
> ERROR: "ahci_ops" [drivers/ata/sata_highbank.ko] undefined!
> ERROR: "ahci_dev_classify" [drivers/ata/sata_highbank.ko] undefined!
> ERROR: "ahci_start_engine" [drivers/ata/sata_highbank.ko] undefined!
> ERROR: "ahci_stop_engine" [drivers/ata/sata_highbank.ko] undefined!
> ERROR: "ahci_interrupt" [drivers/ata/sata_highbank.ko] undefined!
> ERROR: "ahci_print_info" [drivers/ata/sata_highbank.ko] undefined!
> ERROR: "ahci_reset_em" [drivers/ata/sata_highbank.ko] undefined!
> ERROR: "ahci_ignore_sss" [drivers/ata/sata_highbank.ko] undefined!
> ERROR: "ahci_set_em_messages" [drivers/ata/sata_highbank.ko] undefined!
> ERROR: "ahci_save_initial_config" [drivers/ata/sata_highbank.ko] undefined!
> ERROR: "ahci_init_controller" [drivers/ata/sata_highbank.ko] undefined!
> ERROR: "ahci_reset_controller" [drivers/ata/sata_highbank.ko] undefined!
> 
Fix patch follows. Do I need to submit it as a separate patch or is this
sufficient?

--Mark Langsdorf
Calxeda, Inc.

[PATCH] ata: fix compile error for sata_highbank

sata_highbank depends on the libahci library.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
---
 drivers/ata/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 8b384f1..9329daf 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
 obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
-obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o
+obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o

 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
-- 
1.7.5.4
