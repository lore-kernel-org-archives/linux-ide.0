From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: BUG?: VIA IDE transfer-rate problem
Date: Wed, 18 Jan 2006 17:13:42 +0100
Message-ID: <58cb370e0601180813pfb6baffr953e5be26223ea1@mail.gmail.com>
References: <200601131909.07981.pvrusb2@toplitzer.net>
	 <200601171703.42509.pvrusb2@toplitzer.net>
	 <58cb370e0601180227q4807c531pc2319ff569d9e449@mail.gmail.com>
	 <200601181536.16868.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.203]:15584 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030365AbWARQNp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jan 2006 11:13:45 -0500
Received: by uproxy.gmail.com with SMTP id s2so386587uge
        for <linux-ide@vger.kernel.org>; Wed, 18 Jan 2006 08:13:43 -0800 (PST)
In-Reply-To: <200601181536.16868.pvrusb2@toplitzer.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Helmut Toplitzer <pvrusb2@toplitzer.net>
Cc: linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net

On 1/18/06, Helmut Toplitzer <pvrusb2@toplitzer.net> wrote:
> > Just wild guesses but please try:
> > * booting with "cpu=poll" parameter
> > * kernel with ACPI and Power Management disabled
> >
>
> Ok. Here it goes.
> Did your tests which doesn't change anything. But
> I couldn't find the cpu= parameter in kernel-parameters.txt
> so I tried something else too:

Yep, I meant "idle=poll", sorry for that.

> both kernels (with/out acpi):
>    Parameter              NO EHCI     USED EHCI
>    irqpoll                52MB/s       30MB/s
>    idle=poll              58MB/s       58MB/s
>
> However idle=poll is not very power-saving (cpu
> fans at top-speed)

but look at the results ;-)

> I also tried other combinations so it were about 30
> or so restarts.
> (BTW: Is it normal that you see
>
>     Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>     Memory: 256468k/262080k available (1583k kernel code, 5060k reserved, 667k
>     data, 136k init, 0k highmem)
>
> when you close your eyes?)

Thanks for doing these tests.

Did disabling ACPI change something?

> IRQ thing? Hmm.. Looked at the Page of MSI for a new BIOS.
> It's an old board so I didn't expected a new one. Was wrong.
> So I did an update. (Someone shouts "Don't do it" in the background)
>
> Ok. Now with irqpoll I get 53/34 MB/s.
>
> Ideas? (I'm going to test all other problems I had with the prior BIOS).

[ this explanation is just a guess ]

When CPU is idle HLT instruction is used by default (for power saving).
Probably chipset detects when CPU is entering low power mode and
also enters low power mode.  Switching between low and normal power
modes is slow and results in degraded performance.

The question is whether/how we can program chipset to not enter
low power mode.

Bartlomiej
