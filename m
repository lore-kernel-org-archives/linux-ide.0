From: Mark Lord <liml@rtr.ca>
Subject: Re: No DMA on a Dell Latitude D820 with >2.6.20
Date: Sun, 27 Jan 2008 11:59:06 -0500
Message-ID: <479CB85A.5080803@rtr.ca>
References: <1201450320.8386.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3972 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752763AbYA0Q7J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Jan 2008 11:59:09 -0500
In-Reply-To: <1201450320.8386.7.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikel Olasagasti <hey_neken@mundurat.net>
Cc: linux-ide@vger.kernel.org

Mikel Olasagasti wrote:
> Hi,
> 
> I'm having problems with my disk on a Latitude D820 after upgrading
> kernel to any >2.6.20 No DMA support can be activated, giving me a very
> poor I/O performance.
> 
> I'm using ata_piix driver on a ICH7 system with no AHCI support AFAIK
..

Actually, no.  You are really using the IDE driver ("hda") for your disk
on the 2.6.23 kernel.

You can fix this by just not including the IDE driver in your kernel build,
and by fixing your /boot/grub/menu.lst file to use root=/dev/sda6
instead of root=/dev/hda6.

Plus whatever special soup gentoo might require.

Cheers


> I opened a thread[1] on gentoo-forums (the distro I use) with all the
> output i think can be interesting.
> 
> Hope you can help me guys. Thanks for all :)
> 
> [1] http://forums.gentoo.org/viewtopic-p-4731161.html 

