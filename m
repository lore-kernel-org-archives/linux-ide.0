From: Xiang Xu <xuxiang_ins@yahoo.com>
Subject: Re: AHCI: using bios after linux
Date: Fri, 12 Oct 2007 14:55:54 -0700 (PDT)
Message-ID: <482039.11674.qm@web32910.mail.mud.yahoo.com>
References: <20071012215734.4b5b4bce@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web32910.mail.mud.yahoo.com ([209.191.69.110]:36537 "HELO
	web32910.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756985AbXJLVzz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Oct 2007 17:55:55 -0400
In-Reply-To: <20071012215734.4b5b4bce@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, msundius@u1.netgate.com
Cc: msundius@sundius.com, xuxiang_ins@yahoo.com, linux-ide@vger.kernel.org

> > 3) related to #1 above, we want to be invisable.
> so we're not looking to
> > switch from AHCI (to legacy), we are looking to
> continue in whatever mode
> > the BIOS started in. Thus we just want BIOS to be
> able to handle int13 calls
> > after the Linux AHCI driver has run (this works
> when BIOS is setup in 
> > legacy mode initially).
> 
> So load the ata_piix driver and not the AHCI one and
> I think it'll work
> out ?
> 

Just want to add some background info here, our
product will be deployed on thousands of boxes, so
it's not advisable for our product to require the
users to change the default setting of BIOS from AHCI
to Normal mode. I am just thinking wild here so please
bear with me, but I am wandering if there is a way to
load the ata_piix driver with BIOS setting to AHCI
mode? Any pointer will be greatly appreciated.

Xiang
