From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: YuLin: Where can I get the newest source of sata_sis?
Date: Thu, 31 May 2007 21:22:19 +0200
Message-ID: <465F206B.1080908@gmx.net>
References: <465E92EA.2050608@starsoftcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:32982 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757219AbXEaTWW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 May 2007 15:22:22 -0400
In-Reply-To: <465E92EA.2050608@starsoftcomm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?GB2312?B?0+HB1Q==?= <yulin@starsoftcomm.com>
Cc: linux-ide@vger.kernel.org


> hi,
>
> When we used 2.6.18 and 2.6.20 on ASUS sis-671 motherboard, We have some
> problem: cannot find the harddisk controller.
> In BIOS, the SATA mode is 2P+2IDE.
>
> The official kernel 2.6.18, 2.6.20 and new 2.6.21 does not work, i get
> some information about sata_sis 0.7.1 from you, may I get it ?
>
> We are so urgent, please help me.
>
> Thank you very much!!!!
Asus is selling a P5X-MX SE motherboard with a SiS968
southbridge. The SiS671 Northbridge is not intresting for the SATA-support.
Currently it is only planned to support this chipset in
AHCI-mode. You should select the AHCI mode for the SATA-ports in the
BIOS. The ahci driver should support your board.
kernel 2.6.20 should be sufficient.
If this does not work, please provide the output of
lspci -vvxxx and the selected mode for the SATA-port.

regards
Uwe Koziolek



