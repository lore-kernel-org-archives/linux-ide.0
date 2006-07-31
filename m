From: Deyan Chepishev <dchepishev@yahoo.com>
Subject: Re: raid1 sata_promise initialization order problem
Date: Mon, 31 Jul 2006 05:45:33 -0700 (PDT)
Message-ID: <20060731124533.93066.qmail@web34207.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web34207.mail.mud.yahoo.com ([66.163.178.122]:23191 "HELO
	web34207.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030181AbWGaMpd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Jul 2006 08:45:33 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi again,
Please forget my previous email. I think i found where
the problem is. Sorry my mistake.

Thank you for writing this driver.

Sorry once again.

--- Deyan Chepishev <dchepishev@yahoo.com> wrote:

> Hi,
> 
> Sorry if I am writing to the wrong people, but I
> took
> them from the sources.
> 
> Here Is the problem I experience:
> 
> I have server HP Proliant ML 150 G2 equipped with
> SATA
> Promise TX4 SATA300 controller.
> Linux root partition is on software raid1
> Linux is CentOS 4.3
> 
> I downloaded kernel 2.6.17.7
> When I compile in the kernel both drivers
> sata_promise
> and raid1, create appropriate initrd and reboot. The
> system is unable to boot and kernel panics with last
> messages something like:
> switching root
> unable to mount root 
> and so on.
> 
> If I compile raid1 as module and create the
> corresponding initrd the system is booting just
> fine.
> 
> This leads me to the conclusion that when compiled
> in
> raid1 driver is initialized before the sata_promise
> driver and is unable to see the mirror devices
> simply
> because they dont exist yet.
> 
> When I use kernel 2.6.14.6 the whole thing is
> working
> just fine with both drivers compiled in the kernel.
> 
> Do you think there is some way to tell the kernel
> which driver to initialize first ?
> 
> Thanks in advance and sorry for bugging you with my
> problems
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> http://mail.yahoo.com 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
