From: Jeff Garzik <jeff@garzik.org>
Subject: Re: multiple irqs per card on the sata_sil24
Date: Tue, 26 Sep 2006 20:46:04 -0400
Message-ID: <4519C9CC.6060701@garzik.org>
References: <KMS--2046545466-1840@mail.norwalkdist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:27038 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932086AbWI0AqI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Sep 2006 20:46:08 -0400
In-Reply-To: <KMS--2046545466-1840@mail.norwalkdist.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Trent George <trent@norwalkdist.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Trent George wrote:
> While reading the specs, I noticed that the pci-x cards support splitting each port to a unique irq pin.
> If you have 6 cards with 4 ports, can you spread the load over 24 irqs ?
> I dont know if the motherboard can support this, or the driver could be modified to do this.
> It would be nice when there is a lot of of disk traffic on lots of drives.... adding port multiplier drives to each channel.
> I am trying to build a VERY large duplication system using LOTS of bandwidth. the irq can really put stress on the system.
> 
> the final system would be 100+ drives all going over 22mb/s.
> It should give a nice supermicro board with 3 buses a real workout.

You're still going to max out PCI bus bandwidth first.  Best solution is 
PCI Express with MSI...

	Jeff



