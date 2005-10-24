From: Andrew Lynch <lynchaj@yahoo.com>
Subject: toshiba satellite 335CDT DMA not working
Date: Mon, 24 Oct 2005 04:36:48 -0700 (PDT)
Message-ID: <20051024113648.51667.qmail@web31005.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web31005.mail.mud.yahoo.com ([68.142.200.168]:49302 "HELO
	web31005.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750897AbVJXLgt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Oct 2005 07:36:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,
I have a Toshiba Satellite 335CDT laptop. I cannot get
the hda DMA to work with the ide controller. hdparm
-d1 /dev/hda reports no IDE DMA and gives error
message. The drive is capable of DMA according to
hdparm -i.

My problem appears closely related to this persons
problem last February:

http://marc.theaimsgroup.com/?t=110789166000004&r=1&w=2

In short, the IDE controller does not appear in the
PCI devices list (lspci) but it does appear in the PNP
BIOS table of devices (lspnp). I believe the problem
is that the IDE chipset is not recognized. I believe
the default linux behavior is to not enable IDE DMA
unless it recognizes the IDE chipset. I have tried all
the IDE kernel modules including ide_generic with the
same result.

I am running Debian Testing with the default linux
2.6.12 kernel.

Any suggestions on how to get this IDE chipset
recognized by the linux kernel?

I will post any additional information you request to
help with this but it is all very similar to the prior
posts.

Thank you in advance for your help.

Andrew Lynch
