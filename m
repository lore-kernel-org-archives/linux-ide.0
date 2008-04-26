From: Alek Du <alek.du@intel.com>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support
Date: Sun, 27 Apr 2008 07:32:37 +0800
Message-ID: <20080427073237.45f799a2@dxy.sh.intel.com>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<48135C56.507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1343 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742AbYDZXj0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Apr 2008 19:39:26 -0400
In-Reply-To: <48135C56.507@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Sergei,

On Sun, 27 Apr 2008 00:46:14 +0800
"Sergei Shtylyov" <sshtylyov@ru.mvista.com> wrote:

> Re: [PATCH] ata: Add Intel SCH PATA support
> 
> Hello.
> 
> Alek Du wrote:
> 
> > Seems I need to post the patch here instead of LKML
> 
>     Your patch is whitespace damaged -- all tabs converted to spaces.
> 

I forward the patch from LKML and seems my clawsmail client eat all tabs ....

> > [PATCH] ata: Add Intel SCH PATA support
> 
> > This patch adds Intel SCH chipsets (US15W, US15L, UL11L) PATA controller
> > support.
> 
> > Signed-off-by: Alek Du <alek.du@intel.com>
> 
> > diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> > index b7c38ee..7f95a9a 100644
> > --- a/drivers/ata/ata_piix.c
> > +++ b/drivers/ata/ata_piix.c
> > @@ -214,6 +214,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
> >         /* ICH7/7-R (i945, i975) UDMA 100*/
> >         { 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
> >         { 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
> > +       /* INTEL SCH UDMA 100 */
> > +       { 0x8086, 0x811A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
> >         /* ICH8 Mobile PATA Controller */
> >         { 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
> >
> > @@ -561,6 +563,10 @@ struct ich_laptop {
> >         u16 subdevice;
> >  };
> >
> > +struct sch_80 {
> > +       u16 device;
> > +};
> > +
> 
>     Why create a structure which has only single field?
> 
Currently, it only use device ID to decide if force to go SCH way (force
to PATA_80 and skip port enabling bit check), but it would be easier for expanding
if I define a structure here. (looks like ich_laptop)

> MBR, Sergei
