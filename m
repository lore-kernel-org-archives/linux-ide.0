From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Resurrect IT8172 IDE controller driver
Date: Thu, 4 Dec 2008 20:37:21 +0100
Message-ID: <200812042037.21323.bzolnier@gmail.com>
References: <E1L4UpB-0007ro-1g@localhost> <b2b2f2320812040601k55ab69a6n5da4d321151f94f@mail.gmail.com> <20081204140742.1d0d8046@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:22996 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892AbYLDTjf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2008 14:39:35 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1795933ywe.1
        for <linux-ide@vger.kernel.org>; Thu, 04 Dec 2008 11:39:33 -0800 (PST)
In-Reply-To: <20081204140742.1d0d8046@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Shane McDonald <mcdonald.shane@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 04 December 2008, Alan Cox wrote:
> On Thu, 4 Dec 2008 08:01:49 -0600
> "Shane McDonald" <mcdonald.shane@gmail.com> wrote:
> 
> > Would it be acceptable to claim that these changes are outside the
> > scope of this patch, and code the IT8172 driver to behave in the same
> > manner as the other wrong drivers, with a suitable comment indicating
> > this fact?
> 
> I think so..  and if its moved over to libata it can just be fixed then

It shouldn't be necessary...

Shane, you can use helpers from <linux/ata.h> just fine in IDE host drivers
so looking at what libata-core helper used by ata_piix.c:

        if (ata_pio_need_iordy(adev))
                control |= 2;   /* IE enable */

is actually doing:

unsigned int ata_pio_need_iordy(const struct ata_device *adev)
{
        /* Controller doesn't support  IORDY. Probably a pointless check
           as the caller should know this */
        if (adev->link->ap->flags & ATA_FLAG_NO_IORDY)
                return 0;
        /* PIO3 and higher it is mandatory */
        if (adev->pio_mode > XFER_PIO_2)
                return 1;
        /* We turn it on when possible */
        if (ata_id_has_iordy(adev->id))
                return 1;
        return 0;
}

we see that all you need to add in your driver is an additional checking
for ata_id_has_iordy().

Thanks,
Bart

PS when it comes to actually setting the transfer mode on the device
(done in ide_config_drive_speed() core function) IORDY is also handled
just fine (thanks to Sergei).
