From: =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>
Subject: Re: 2.6.26, sata_nv.c, NCQ's support disappeared (broken?)
Date: Mon, 14 Jul 2008 16:32:36 -0300
Message-ID: <k7msk5-945.ln1@tux.abusar.org.br>
References: <43d009740807141031g612c56b7h52f6c3c6cbfab6b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:46493 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118AbYGNTdL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jul 2008 15:33:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KITnG-0000PT-1Z
	for linux-ide@vger.kernel.org; Mon, 14 Jul 2008 19:33:06 +0000
Received: from c934d6e6.virtua.com.br ([201.52.214.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 14 Jul 2008 19:33:06 +0000
Received: from fragabr by c934d6e6.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 14 Jul 2008 19:33:06 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Tue, 15 Jul 2008 01:31:12 +0800
"Igor Podlesny" <for.poige+linux@gmail.com> wrote:

> 	Hi! Here goes the dmesg output:
> 
> ---X8------X8------X8------X8------X8------X8------X8------X8------X8------X8------X8------X8------X8---
> [    0.658727] scsi0 : sata_nv
> [    0.658727] scsi1 : sata_nv
	
	Something happened with ncq's sata_nv support. When I halt my
system (Athlon64, Asus M2N-E), I get the following (I had to copy by
hand, since the system is halted, so it's just an excerpt):

IRQ 21: nobody cared (try booting with the "irqpool" option)
Pid 0, comm: swapper not tainted 2.6.26 #2

Call trace:
........... nv_swncq_interrupt
........... __report_bad_irq
........... note_interrupt
........... handle_fasteoi_irq
........... do_irq
........... ret_from_intr

Handles:

[<f88888888803a5b90>] (nv_swncq_interrupt+0x0/0xd0)

Disabling IRQ #21

	This just happens after a halt.

	If I use irqpool, this error doesn't happen.

	Thanks.

-- 
Linux 2.6.26: Rotary Wombat
http://u-br.net
Marilyn Manson - "Cryptorchid" (Antichrist Superstar - 1996)


