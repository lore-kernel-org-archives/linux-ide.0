From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] libata: pass host flags into __ata_pci_sff_init_one() helper
Date: Thu, 18 Feb 2010 23:41:02 +0100
Message-ID: <201002182341.02203.bzolnier@gmail.com>
References: <20100218185914.16594.61415.sendpatchset@localhost> <20100218185922.16594.98925.sendpatchset@localhost> <20100218214448.692552fd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:16876 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab0BRWmJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Feb 2010 17:42:09 -0500
In-Reply-To: <20100218214448.692552fd@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 18 February 2010 10:44:48 pm Alan Cox wrote:
> On Thu, 18 Feb 2010 19:59:22 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] libata: pass host flags into __ata_pci_sff_init_one() helper
> > 
> > This was orginally proposed by Alan Cox but as a change
> > for ata_pci_sff_init_one() helper function instead of
> > __ata_pci_sff_init_one() one which casues needless churn
> > to all host drivers and accidentally breakes few host
> > drivers which are still on their way upstream.
> > 
> > Allows parallel scan and the like to be set without
> > having to stop using the existing full helper functions.
> 
> NAK - __ is for internal symbol names.

A NAK for an atang specific patch?  :)

- Please read DISCLAIMER in the first mail (it is there for a valid reasons).

- The patch is for atang tree and said __ change happened _months_ ago as
   a part of (very much related) ->init_host work which is not 'upstream'.

- __ has been also used for exactly such purpose in the kernel, i.e.:

$ grep EXPORT_SYMBOL drivers/pci/*c|grep __
drivers/pci/htirq.c:EXPORT_SYMBOL(__ht_create_irq);
drivers/pci/pci.c:EXPORT_SYMBOL_GPL(__pci_complete_power_transition);
drivers/pci/pci.c:EXPORT_SYMBOL_GPL(__pci_reset_function);
drivers/pci/pci-driver.c:EXPORT_SYMBOL(__pci_register_driver);

Just see commit 863b18f introducing __pci_register_driver
(please notice that the change was suggested by Al Viro!)..

--
Bartlomiej Zolnierkiewicz
