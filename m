From: Jim Ramsay <jim.ramsay@gmail.com>
Subject: Re: libata and sata_promise errors when using multiple disks on the same controller simultaneously
Date: Fri, 15 Jul 2005 13:33:13 -0600
Message-ID: <4789af9e0507151233235ee42@mail.gmail.com>
References: <4789af9e050705111263cc6f7b@mail.gmail.com>
Reply-To: Jim Ramsay <jim.ramsay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:45561 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261714AbVGOTdP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Jul 2005 15:33:15 -0400
Received: by zproxy.gmail.com with SMTP id r28so398856nza
        for <linux-ide@vger.kernel.org>; Fri, 15 Jul 2005 12:33:13 -0700 (PDT)
In-Reply-To: <4789af9e050705111263cc6f7b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-ide <linux-ide@vger.kernel.org>
Cc: Jarrod Johnson <jarrod.b.johnson@gmail.com>

I have further characterized the error.  It looks like, at least
during the softraid rebuild process, most DMA commands are sent to the
PCI card and then complete via an IRQ callback before the next command
is sent.  However, the problem I see here sometimes occurrs when:

- Command for drive 1 is sent to the PCI card via DMA
(sata_promise.c:pdc_packet_start)
- Command for drive 2 is sent to the PCI card via DMA before the
previous command completes
- Command for drive 1 completes (sata_promise.c:pdc_host_intr)

Often the command for drive 2 will now timeout.

Now, I have seen the case when this above scenario will actually
complete successfully, either with a second IRQ just for the drive2
command, or sometimes with a single IRQ which completes both commands.

I have a workaround using a semaphore which causes all commands to
strictly serialize, (lock it in pdc_packet_start, unlock in
pdc_host_intr) thereby not allowing any concurrent commands, but this
appears to have a large performance impact.  At least it allows me to
actually cause my softraid device to finish syncing to 100%.

I'm looking for other solutions, or a clue as to the actual cause of
the error.  My current theory is that if the second command is sent to
the PCI via DMA too soon, it may be overlooked, so some rate-limiting
may be useful, if I can figure out how to implement it.

Any comments or suggestions here would be greatly appreciated, thanks!

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
