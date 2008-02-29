From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: PATA Sil680 Disabling IRQ
Date: Thu, 28 Feb 2008 18:07:41 -0700
Message-ID: <8202f4270802281707g6fb80dc4i6a8015cdd13035ec@mail.gmail.com>
References: <8202f4270802261647t505cccf7ra3c81e5fccc9366a@mail.gmail.com>
	 <47C4B5BE.7010709@garzik.org>
	 <8202f4270802271620u6cea6176p2bea5ff8e0b9bbef@mail.gmail.com>
	 <20080228202255.5e3f0c43@core>
	 <8202f4270802281411j747bf96dx34ff81c4d192d417@mail.gmail.com>
	 <20080228231002.325c9e1d@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:14760 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757147AbYB2BHn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Feb 2008 20:07:43 -0500
Received: by wx-out-0506.google.com with SMTP id h31so3909333wxd.4
        for <linux-ide@vger.kernel.org>; Thu, 28 Feb 2008 17:07:41 -0800 (PST)
In-Reply-To: <20080228231002.325c9e1d@core>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>

On 2/28/08, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > For most of unsupported commands, it will be aborted by drive.
>  > However, for some unsupported commands, it may not.  I suspect these
>  > bad commands are the new ones in ATA8 issued to some drives with old
>  > firmware. For instance, can you try command 0x5E (Trusted Send PIO
>  > data out) with sector count set to 1 and see what happens?
>
>
> Well the kernel as of 2.6.24 defaults to blocking treacherous computing
>  commands 8)
>
Whether a command is "treacherous" really depends.  For instance,
command 0x5E is treacherous for PATA drives not supporting it but is
good on security drives supporting it.

In a perfect world, host would know what exact command to issue. But
in reality, Identify Device may not show every feature set supported,
which is the scenario I run into.  I have to use the "try and see"
approach on some drives where I tripped on the IRQ disabling problem.

>
>  > The blame is probably on drives which should have aborted these
>  > commands. But the reality is that libata will handle variety of drives
>  > including the ones with old firmware.  So the question here is whether
>  > libata PATA code can be more fault tolerate. It seems the weakest link
>  > is on PATA PIO since I have not been able to reproduce the IRQ
>  > disabling problem on DMA operations.
>
>
> If you send crap to a drive you will get junk as a result. Only the
>  superuser can do this so that behaviour is fine. The superuser can also
>  crash the machine a million other ways. End users cannot send arbitary
>  commands to the drive.
>
>  Ditto they may know that an "unsupported" command for their ATA version
>  is actually a vendor private command for the specific drive they have.
>
I agree with you and Jeff that we can not prevent superuser from
corrupting the system.  What I want to understand more is if there's
room to harden PATA PIO code in libata.  For instance, when I set
wrong data transfer direction in DMA read, I got command timeout,
which to me is a more graceful failure than IRQ disabling.  I'm not
sure if the difference of failure mode between PIO and DMA is caused
by controller or software.  If the cause is software,  it would be
nice to close the gap.

Thanks,
Fajun
