From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: (For review) Teach libata to tune master/slave
	seperately
Date: Wed, 18 Jan 2006 12:04:25 +0000
Message-ID: <1137585865.25819.27.camel@localhost.localdomain>
References: <1137531678.14135.105.camel@localhost.localdomain>
	 <58cb370e0601180340v529c04fdq5dc962285a6fc1c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:25765 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030245AbWARMEx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2006 07:04:53 -0500
In-Reply-To: <58cb370e0601180340v529c04fdq5dc962285a6fc1c0@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com

On Mer, 2006-01-18 at 12:40 +0100, Bartlomiej Zolnierkiewicz wrote:
> The core logic is changed (in the positive way): ata_pio_modes()
> is finally used for obtaining PIO mask to be used.

Ah yes, Jeff hadn't previously merged the small version of that change.
Indeed description is a little incorrect.

> Please update the patch description or make it a separate change.
> 
> The other functional change is the ordering of programming host/devices:
> 
> previously:
> * program PIO for device 0 [host]
> * program PIO for device 1 [host]
> * program DMA for device 0 [host]
> * program DMA for device 1 [host]
> * program xfer mode for device 0 [device]
> * program xfer mode for device 1 [device]
> 
> now:
> * program PIO for device 0 [host]
> * program DMA for device 0 [host]
> * program xfer mode for device 0 [device]
> * program PIO for device 1 [host]
> * program DMA for device 1 [host]
> * program xfer mode for device 0 [device]
> 
> This change is OK but I wonder what is the reason for it?

It simply how suffling the code re-ordered it. I don't think its a
problem but if anyone has a problem I can go and re-re-order it.

libata also really should do adev->pio_mode = XFER_PIO_0; ->set_piomode
before doing its initial identify etc because there is no guarantee the
BIOS didn't leave the hardware in a bogus state.

> > I have. Introduces no new bugs I've found but obviously piix secondary
> > slave doesn't reliably work with or without this change because of the
> > current piix driver bug.
> 
> I thought it was merged already (it is obviously correct)?

Apparently not.

