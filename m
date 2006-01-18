From: Helmut Toplitzer <pvrusb2@toplitzer.net>
Subject: Re: BUG?: VIA IDE transfer-rate problem
Date: Wed, 18 Jan 2006 15:36:16 +0100
Message-ID: <200601181536.16868.pvrusb2@toplitzer.net>
References: <200601131909.07981.pvrusb2@toplitzer.net> <200601171703.42509.pvrusb2@toplitzer.net> <58cb370e0601180227q4807c531pc2319ff569d9e449@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from toplitzer.net ([83.151.30.110]:29153 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S1030327AbWAROgC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2006 09:36:02 -0500
In-Reply-To: <58cb370e0601180227q4807c531pc2319ff569d9e449@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net

> Just wild guesses but please try:
> * booting with "cpu=poll" parameter
> * kernel with ACPI and Power Management disabled
>

Ok. Here it goes.
Did your tests which doesn't change anything. But
I couldn't find the cpu= parameter in kernel-parameters.txt
so I tried something else too:


both kernels (with/out acpi):
   Parameter              NO EHCI     USED EHCI
   irqpoll                52MB/s       30MB/s
   idle=poll              58MB/s       58MB/s

However idle=poll is not very power-saving (cpu
fans at top-speed)

I also tried other combinations so it were about 30
or so restarts.
(BTW: Is it normal that you see

    Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
    Memory: 256468k/262080k available (1583k kernel code, 5060k reserved, 667k     
    data, 136k init, 0k highmem)

when you close your eyes?)

IRQ thing? Hmm.. Looked at the Page of MSI for a new BIOS.
It's an old board so I didn't expected a new one. Was wrong.
So I did an update. (Someone shouts "Don't do it" in the background)

Ok. Now with irqpoll I get 53/34 MB/s.

Ideas? (I'm going to test all other problems I had with the prior BIOS).

Bye. Back in a few days :-)
Helmut

-- 
My GNUpg fingerprint http://www.gnupg.org
4563 F4FB 0B7E 8698 53CD  00E9 E319 35BD 6A91 1656
