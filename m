From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ata:Remove no longer valid FIXME comment in pata_ninja32.c
 for the function,ninja32_init_one
Date: Thu, 05 Feb 2015 14:15:42 +0100
Message-ID: <711574455.M170TblBab@amdc1032>
References: <1423093661-32188-1-git-send-email-xerofoify@gmail.com>
 <3201438.osoPqSWP4R@amdc1032>
 <CAPDOMVgVdbDUkTLP2bKDrPr1XrzW550Hovtar3xNoESjo0x39A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:10125 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757511AbbBENPy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Feb 2015 08:15:54 -0500
In-reply-to: <CAPDOMVgVdbDUkTLP2bKDrPr1XrzW550Hovtar3xNoESjo0x39A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nick Krause <xerofoify@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

On Thursday, February 05, 2015 08:00:24 AM Nick Krause wrote:
> On Thu, Feb 5, 2015 at 6:02 AM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > Hi,
> >
> > On Wednesday, February 04, 2015 06:47:41 PM Nicholas Krause wrote:
> >> Removes the no longer valid fix me comment in the function, ninja32_init_one for
> >> questioning if we are required to remove the activated device at the end of this
> >> function by calling the function, ata_host_activate to activate the device passed
> >> by the caller of the function ninja_init_one. This comment is no longer needed as
> >> we need to deallocate the memory used to store this device's information when the
> >> device is no longer in use by the system in order to avoid leaking memory. Due to
> >> this the driver in the file,ninja32_init_one has the function,ata_pci_remove_one
> >> to release the memory allocated in it's init function and therefore this comment
> >> can now be removed due to use correctly freeing the memory allocated  from the
> >> driver's init function,ninja32_init_one.
> >>
> >> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> >> ---
> >>  drivers/ata/pata_ninja32.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
> >> index efb272d..47b30d3 100644
> >> --- a/drivers/ata/pata_ninja32.c
> >> +++ b/drivers/ata/pata_ninja32.c
> >> @@ -147,7 +147,6 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
> >>       ap->pflags = ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE;
> >>
> >>       ninja32_program(base);
> >> -     /* FIXME: Should we disable them at remove ? */
> >
> > After looking at the driver history I think that the comment is about
> > ninja32_program() enabling interrupt lines (which don't get disabled when
> > the host controller is detached from the driver) not about the cleanup
> > done during ata_pci_remove_one().  Alan, is this correct?
> >
> >>       return ata_host_activate(host, dev->irq, ata_bmdma_interrupt,
> >>                                IRQF_SHARED, &ninja32_sht);
> >>  }
> >
> > Best regards,
> > --
> > Bartlomiej Zolnierkiewicz
> > Samsung R&D Institute Poland
> > Samsung Electronics
> >
> If that is the case then I will disable the interrupt lines for the
> host in this driver's
> remove function.

Unless you have hardware to test such change (to check that there are no
side-effects) just moving FIXME to ninja32_program() seems to be a better
approach for now..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

