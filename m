From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/6] rz1000: apply chipset quirks early
Date: Sun, 9 Nov 2008 15:03:48 +0100
Message-ID: <200811091503.48842.bzolnier@gmail.com>
References: <20081103200244.5098.29817.sendpatchset@localhost.localdomain> <491083E9.60305@ru.mvista.com> <49109AC9.5090406@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:35481 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbYKIQXJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 11:23:09 -0500
In-Reply-To: <49109AC9.5090406@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 04 November 2008, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >> Index: b/drivers/ide/rz1000.c
> >> ===================================================================
> >> --- a/drivers/ide/rz1000.c
> >> +++ b/drivers/ide/rz1000.c
> >> @@ -22,34 +22,48 @@
> >>  
> >>  #define DRV_NAME "rz1000"
> >>  
> >> -static void __devinit init_hwif_rz1000 (ide_hwif_t *hwif)
> >> +static unsigned int __devinit rz1000_init_chipset(struct pci_dev *dev)
> 
> >    Hm, this is not a real init_chipset() method and it does just one 
> > thing -- disables readahead, so rz1000_disable_readahead() or something 
> > of that sort seems like a better name...
> 
>     Hm, 'unsigned' result type wasn't terribly helpful here as well. :-)

Agreed, v1->v2 interdiff:

...
v2:
* unsigned int rz1000_init_chipset() -> int rz1000_disable_readahead()
  per Sergei's suggestion.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
...
diff -u b/drivers/ide/rz1000.c b/drivers/ide/rz1000.c
--- b/drivers/ide/rz1000.c
+++ b/drivers/ide/rz1000.c
@@ -22,7 +22,7 @@
 
 #define DRV_NAME "rz1000"
 
-static unsigned int __devinit rz1000_init_chipset(struct pci_dev *dev)
+static int __devinit rz1000_disable_readahead(struct pci_dev *dev)
 {
 	u16 reg;
 
@@ -52,7 +52,7 @@
 	if (rc)
 		return rc;
 
-	if (rz1000_init_chipset(dev)) {
+	if (rz1000_disable_readahead(dev)) {
 		d.host_flags |= IDE_HFLAG_SERIALIZE;
 		d.host_flags |= IDE_HFLAG_NO_UNMASK_IRQS;
 	}
