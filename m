From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 10/11] ahci: Export generic AHCI symbols, turn libahci
 into a separate module
Date: Wed, 3 Mar 2010 21:08:34 +0300
Message-ID: <20100303180834.GA11184@oksana.dev.rtsoft.ru>
References: <20100303171713.GA6322@oksana.dev.rtsoft.ru>
 <20100303171749.GJ12362@oksana.dev.rtsoft.ru>
 <4B8EA21A.2040601@ru.mvista.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:45798 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755416Ab0CCSIg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2010 13:08:36 -0500
Content-Disposition: inline
In-Reply-To: <4B8EA21A.2040601@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 03, 2010 at 08:53:30PM +0300, Sergei Shtylyov wrote:
[...]
> >diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> >index 01c52c4..365a9da 100644
> >--- a/drivers/ata/Kconfig
> >+++ b/drivers/ata/Kconfig
> >@@ -59,12 +59,18 @@ config SATA_PMP
> > config SATA_AHCI
> > 	tristate "AHCI SATA support"
> >-	depends on PCI
> > 	help
> > 	  This option enables support for AHCI Serial ATA.
> > 	  If unsure, say N.
> >+config SATA_AHCI_PCI
> >+	tristate "PCI AHCI SATA support"
> >+	depends on SATA_AHCI && PCI
> 
>   Perhaps it's worth to turn that into select SATA_AHCI and make
> SATA_AHCI invisible to users instead, so that each particular AHCI
> implementation could select it.

No, we must maintain old .config's semantics. SATA_AHCI is already
visible to the users, and if we remove it, we'll break
'make oldconfig'.

> >+	default y
> 
>   Why force the default "y" if the predecessor option SATA_AHCI
> didn't do it?

For the same reason, to keep old .configs working.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
