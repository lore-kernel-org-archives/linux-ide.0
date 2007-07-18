From: "Yasha Okshtein" <flyashi@gmail.com>
Subject: Re: Recommendations on user-space soft/hardreset
Date: Tue, 17 Jul 2007 18:00:07 -0700
Message-ID: <6b01c6170707171800t39f2aac5x80a6d33b892fbda8@mail.gmail.com>
References: <6b01c6170707171723p4fdae403hf5b605fce4595b7@mail.gmail.com>
	 <6b01c6170707171734l12af7fbdt43c28edd32776858@mail.gmail.com>
	 <20070718014534.6a0adffe@the-village.bc.nu>
Reply-To: flyashi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:24147 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760660AbXGRBAJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jul 2007 21:00:09 -0400
Received: by fk-out-0910.google.com with SMTP id z23so2703fkz
        for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 18:00:08 -0700 (PDT)
In-Reply-To: <20070718014534.6a0adffe@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

As an example, I'll use the sata_sil24 driver, as that's what I'll be
using on my machine (until sata_mv comes around)

On 7/17/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > - each driver, in ata_port_operations, specifies a soft_reset and
> > hard_reset functions, which take ata_port* as a parameter
>
> They already have them via the EH code.

You mean:

static const struct ata_port_operations sil24_ops = {
...
	.error_handler		= sil24_error_handler,
...
which then calls
	ata_do_eh(ap, ata_std_prereset, sil24_softreset, sil24_hardreset,
		  ata_std_postreset);

How to then specify if you just need a softreset? My understanding is
all those functions get called.

>
> > - in ata_scsi_pass_through, check for HARDRESET and SRST, and call
> > respective driver's soft/hard reset function
>
> Old IDE has an ioctl for it - it would be good to provide this for
> compatibility as we have with some other needed ioctls.

Well, the SAT way of specifying soft/hardresets I found at [1] on page
104, and the basis for this is already in libata, just not
implemented: see ata_scsi_map_proto. Implementing it there seems more
compatible with the standard.

> > So the question is: should the driver simply call prereset, optionally
> > hardreset, softreset, and postreset, or set up the error handler
> > context to do it?
>
> I think you have to do the latter. I see no other way to get the locking
> right, and the old IDE was horrible (and broken) because it tried to do
> it in the user context. drivers/ide is a worked example of why *NOT* to
> simply call the methods. The EH just needs triggering and can do the rest
> sanely in a sensible context without adding new methods to the drivers.
>

Ugh.. I figured, I was just hoping I wouldn't have to deal with that.
Any idea on what happens to the user process (blocking, etc.) during
error handling? Surely if a disk needs to be hardreset during a normal
error, the user process doesn't hang for up to 30 seconds?

 - Yasha
