From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ahci: compile out msi/msix infrastructure
Date: Sat, 05 Dec 2015 23:25:48 +0100
Message-ID: <1693285.M8jQWtVTWx@wuerfel>
References: <20151204195830.2300.48789.stgit@dwillia2-desk3.jf.intel.com> <1540836.svMP4lTcYC@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:61060 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbbLEW01 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Dec 2015 17:26:27 -0500
In-Reply-To: <1540836.svMP4lTcYC@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: tj@kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org

On Saturday 05 December 2015 23:22:49 Arnd Bergmann wrote:
> On Friday 04 December 2015 11:58:30 Dan Williams wrote:
> > +#ifdef CONFIG_PCI_MSI
> > +static inline int ahci_irq_vector(struct ahci_host_priv *hpriv, int port)
> > +{
> > +       if (hpriv->flags & AHCI_HFLAG_MULTI_MSIX)
> > +               return hpriv->msix[i].vector;
> > +       else
> > +               return hpriv->irq + i;
> > +}
> > 
> 
> My randconfig tests now noticed that 'i' is undeclared here. I suppose it
> should be 'port' instead of 'i'?
> 

and one more:

In file included from /git/arm-soc/drivers/ata/ahci_platform.c:25:0:
/git/arm-soc/drivers/ata/ahci.h: In function 'ahci_irq_vector':
/git/arm-soc/drivers/ata/ahci.h:368:3: error: invalid use of undefined type 'struct msix_entry'
   return hpriv->msix[port].vector;
   ^
/git/arm-soc/drivers/ata/ahci.h:368:21: error: dereferencing pointer to incomplete type 'struct msix_entry'
   return hpriv->msix[port].vector;


diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index c450b8a914eb..dfbd033706bb 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -37,6 +37,7 @@
 
 #include <linux/clk.h>
 #include <linux/libata.h>
+#include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
 

