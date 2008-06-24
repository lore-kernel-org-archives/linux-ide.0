From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Tue, 24 Jun 2008 15:21:17 +0200
Message-ID: <58cb370e0806240621g61370f56j660e31790dad89c3@mail.gmail.com>
References: <87k5gmz596.fsf@denkblock.local>
	 <200806240041.42796.bzolnier@gmail.com>
	 <87skv3s3d9.fsf@denkblock.local>
	 <200806241306.42054.bzolnier@gmail.com>
	 <20080624133218.6bccab75@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758209AbYFXNVa@vger.kernel.org>
In-Reply-To: <20080624133218.6bccab75@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>
List-Id: linux-ide@vger.kernel.org

On Tue, Jun 24, 2008 at 2:32 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> I don't see a reliable way to fix ide_abort() - once the request/command
>> is started hardware can be already in a state that makes aborting hard if
>> not impossible.
>
> It depends on the ATA version what you do but you end up doing a reset
> sequence without waiting for the existing command to finish if your drive
> is too new to have IDLE IMMEDIATE. What you can't do is wait for the
> command to finish before issuing a reset because it may never finish.
>
> I don't see why you think it's "hard". We have timeout handlers for many
> commands and those reset/abort just fine.

They are different beasts from user-space initiated abort operation
which can happen in any moment (timeout handlers explicetely know
what state software/hardware is supposed to be currently in) and is
in no way synchronized with the current request/command processing.

It may be possible to fix it but it will be really hard to get it
right and I don't think it is worth the pain for broken-by-design
hack in an odd ioctl workarounding shortcomings in core code error
recovery (which should be fixed instead, if is not fixed already).

Thanks,
Bart
