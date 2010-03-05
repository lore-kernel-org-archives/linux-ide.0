From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] libata updates for 2.6.34
Date: Fri, 5 Mar 2010 21:12:58 +0100
Message-ID: <201003052112.58271.bzolnier@gmail.com>
References: <20100301202330.GA14977@havoc.gtf.org> <201003051958.24987.bzolnier@gmail.com> <4B915EEF.1040307@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:34124 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708Ab0CEUOf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Mar 2010 15:14:35 -0500
In-Reply-To: <4B915EEF.1040307@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@linux.intel.com>

On Friday 05 March 2010 08:43:43 pm Jeff Garzik wrote:
> On 03/05/2010 01:58 PM, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 01 March 2010 09:23:30 pm Jeff Garzik wrote:
> >
> >>        libata: Pass host flags into the pci helper
> >
> > It introduces a subtle bug:
> >
> > struct ata_host {
> > ...
> > 	unsigned long		flags;
> >
> >> @@ -1642,8 +1643,8 @@ extern int ata_pci_sff_activate_host(struct ata_host *host,
> >>   				     irq_handler_t irq_handler,
> >>   				     struct scsi_host_template *sht);
> >>   extern int ata_pci_sff_init_one(struct pci_dev *pdev,
> >> -				const struct ata_port_info * const * ppi,
> >> -				struct scsi_host_template *sht, void *host_priv);
> >> +		const struct ata_port_info * const * ppi,
> >> +		struct scsi_host_template *sht, void *host_priv, int hflags);
> >
> > 'int' type is not equal 'unsigned long' one on 64-bit architectures.
> 
> True but largely irrelevant as we will never use more than 32 bits worth 
> of host flags.
> 
> 
> > Besides doing it this way is clearly suboptimal as the same effect
> > could have been achieved by doing:
> >
> > extern int __ata_pci_sff_init_one(struct pci_dev *pdev,
> > 				const struct ata_port_info * const *ppi,
> > 				struct scsi_host_template *sht, void *host_priv,
> > 				int hflag);
> > static inline int ata_pci_sff_init_one(struct pci_dev *pdev,
> > 				const struct ata_port_info * const *ppi,
> > 				struct scsi_host_template *sht, void *host_priv)
> > {
> > 	return __ata_pci_sff_init_one(pdev, ppi, sht, host_priv, 0);
> > }
> 
> This is far uglier than simply changing the API.
> 
> > without the need to update all drivers and without breaking pending
> > out-of-tree driver patches (yeah, it breaks my pata_ep93xx patches)..
> 
> Every post you include a disclaimer about "my patches are not intended 
> for upstream" yet you still complain?

You've interpreted the disclaimer wrong -- "if you want my patches
upstream do it yourself or pay for it cause I have neither time nor
interest in an added bureaucracy and clean-yet-buggy mentality"..

Lets put things in the right perspective, look at your pull request:

 48 files changed, 663 insertions(+), 417 deletions(-)

then at Dave's IDE pull request:

 52 files changed, 617 insertions(+), 678 deletions(-)

and finally at my atang tree (I'm just testing 2.6.33 rebase):

 328 files changed, 11528 insertions(+), 14491 deletions(-)

This is a whole different scale of changes and you shouldn't be
surprised that it requires a bit different set of strategies to
handle it effectively..

> Some people are never satisfied...

When did it become a bad thing? :)

--
Bartlomiej Zolnierkiewicz
