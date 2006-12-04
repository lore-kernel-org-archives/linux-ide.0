From: "Thinus Viljoen" <thinus.viljoen@gmail.com>
Subject: Re: Disabling SATA hardware interrupts
Date: Mon, 4 Dec 2006 15:34:09 +0200
Message-ID: <c70dbe410612040534y6a357064m7a0d28d3d40fa4ab@mail.gmail.com>
References: <c70dbe410612040308o5cbe878cue4ce98c088776afc@mail.gmail.com>
	 <20061204120350.3bbd520d@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:48021 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S936843AbWLDNeO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 08:34:14 -0500
Received: by wx-out-0506.google.com with SMTP id h27so3793416wxd
        for <linux-ide@vger.kernel.org>; Mon, 04 Dec 2006 05:34:10 -0800 (PST)
In-Reply-To: <20061204120350.3bbd520d@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On 12/4/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
>
> The nIEN bit in the device registers control interrupt generation on ATA
> devices. However ATA devices don't generate interrupts except on command
> completion or during command processing so if you have no I/O outstanding
> you won't have any interrupts anyway.
>
> With funky new stuff like AHCI and NCQ this isn't so simple but for
> simple ATA as with the ata_piix driver it is.
>

How do I go about setting/clearing this nIEN bit from my own module?
Open a handle to /dev/sda and calling some or other IOCTL, perhaps? (
I haven't accessed the HDD on this low level before, so I would
appreciate some details, or perhaps a small example).

Thanks
Thinus
