From: "Mark Nelson" <mdnelson8@gmail.com>
Subject: Re: Driver for Promise PDC42819 SATA/SAS controller
Date: Mon, 1 Sep 2008 22:04:23 +1000
Message-ID: <65a6ef750809010504q6c4e112cse9163733366bfca0@mail.gmail.com>
References: <65a6ef750808141846h1104bc1cj9a9c0bb721b62f58@mail.gmail.com>
	 <18606.60604.356878.363677@harpo.it.uu.se>
	 <48AF282B.4090904@garzik.org>
	 <18607.14142.979717.852078@harpo.it.uu.se>
	 <65a6ef750808230223t6da2560fx1799dbf271e95959@mail.gmail.com>
	 <18607.58441.367432.715909@harpo.it.uu.se>
	 <65a6ef750808230340s1d44cb0ajfba8092d9f62f8e@mail.gmail.com>
	 <18607.64440.810334.137910@harpo.it.uu.se>
	 <65a6ef750809010410v503ba217u13dc5a55490ef07c@mail.gmail.com>
	 <18619.54275.742794.192883@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:44578 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbYIAMEZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Sep 2008 08:04:25 -0400
Received: by yw-out-2324.google.com with SMTP id 9so274338ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Sep 2008 05:04:23 -0700 (PDT)
In-Reply-To: <18619.54275.742794.192883@harpo.it.uu.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Mon, Sep 1, 2008 at 9:37 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
> Mark Nelson writes:
>  > On Sat, Aug 23, 2008 at 9:59 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
>  > > Mark Nelson writes:
>  > >  > >  > Forgive my ignorance, but does the fact that the T3 controller can also
>  > >  > >  > use SAS disks mean we should be looking for a SCSI driver?
>  > >  > >
>  > >  > > Promise lists only this one partial-source driver for the tx4650,
>  > >  > > and it /is/ a Linux scsi driver.
>  > >  > >
>  > >  >
>  > >  > Oh sorry, I meant to ask should we be looking at an in-kernel
>  > >  > (or fully open source driver) that is a SCSI driver that we could make
>  > >  > work with the T3? So maybe my question is actually: does the
>  > >  > fact that this controller supports SAS disks mean that the
>  > >  > driver for it should be a scsi driver (rather than an ATA driver)?
>  > >
>  > > The candidate Linux drivers would be ata/sata_promise, ata/sata_sx4,
>  > > block/sx8, and scsi/stex. You tried sata_promise, and from looking
>  > > at the PCI IDs I doubt the others are likely to drive the T3.
>  > >
>  > > If you can find an open-source T3 driver in some other operating
>  > > system, like OpenSolaris, Darwin, or some *BSD, then that would be
>  > > great.
>  > >
>  >
>  > Okay, so after trying all of the above drivers you suggested (as
>  > well as a few other SAS drivers I found) I figured I'd try AHCI.
>  >
>  > And it actually works!
>  >
>  > After making the following simple change:
>  >
>  > --- linux/drivers/ata/ahci.c_orig    2008-09-01 18:42:26.000000000 +1000
>  > +++ linux/drivers/ata/ahci.c 2008-09-01 19:41:29.000000000 +1000
>  > @@ -542,6 +542,9 @@ static const struct pci_device_id ahci_p
>  >      { PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },        /* 6145 */
>  >      { PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },        /* 6121 */
>  >
>  > +    /* Promise */
>  > +    { PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },           /* T3 */
>  > +
>  >      /* Generic, PCI class code for AHCI */
>  >      { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>  >        PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
>
> Nice detective work. At least now the chip is usable.
>
> /Mikael
>

Thanks! It still might need a bit of tweaking and input from
the ahci guys but I'm really happy now that I can use those
extra ports.

Mark
