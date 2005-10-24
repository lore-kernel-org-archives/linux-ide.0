From: Andrew Lynch <lynchaj@yahoo.com>
Subject: Re: toshiba satellite 335CDT DMA not working
Date: Mon, 24 Oct 2005 08:51:34 -0700 (PDT)
Message-ID: <20051024155134.64644.qmail@web31015.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web31015.mail.mud.yahoo.com ([68.142.201.73]:23960 "HELO
	web31015.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751118AbVJXPvf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Oct 2005 11:51:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Bartlomiej, Thanks for the reply. 

As a starting point, are there any existing similar
Linux ISA IDE with DMA drivers which could be modified
to add support for the Toshiba ISA IDE chipset? Is a
clean sheet development of a Linux ISA IDE DMA driver
necessary? I recall that many old ISA sound cards
required DMA to work properly so maybe that could be a
starting point as well.

Is there some way to force the chipset to become
present on the PCI bus for better visibility and/or
support?

Lack of IDE DMA seems to be a common problem for older
laptops on the Toshiba Linux mailing list.

http://linux.toshiba-dme.co.jp/cgi-bin/namazu.cgi?lang=en&key=DMA&whence=0&dbname=tlinux-users&max=20&format=long&sort=score

Thanks in advance!

Andrew Lynch


>This email explains a lot:
>http://linux.toshiba-dme.co.jp/ML/tlinux-users/7000/7096.html

>now somebody only needs to take a look at NetBSD
driver,
>write Linux driver, test it and submit. :)
>
>Bartlomiej

--- lynchaj@yahoo.com <lynchaj@yahoo.com> wrote:
> Hi,
> I have a Toshiba Satellite 335CDT laptop. I cannot
get
> the hda DMA to work with the ide controller. hdparm
> -d1 /dev/hda reports no IDE DMA and gives error
> message. The drive is capable of DMA according to
> hdparm -i.
> 
> My problem appears closely related to this persons
> problem last February:
> 
>
http://marc.theaimsgroup.com/?t=110789166000004&r=1&w=2
> 
> In short, the IDE controller does not appear in the
> PCI devices list (lspci) but it does appear in the
PNP
> BIOS table of devices (lspnp). I believe the problem
> is that the IDE chipset is not recognized. I believe
> the default linux behavior is to not enable IDE DMA
> unless it recognizes the IDE chipset. I have tried
all
> the IDE kernel modules including ide_generic with
the
> same result.
> 
> I am running Debian Testing with the default linux
> 2.6.12 kernel.
> 
> Any suggestions on how to get this IDE chipset
> recognized by the linux kernel?
> 
> I will post any additional information you request
to
> help with this but it is all very similar to the
prior
> posts.
> 
> Thank you in advance for your help.
> 
> Andrew Lynch

