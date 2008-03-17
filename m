From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_sil24 stability and performance
Date: Sun, 16 Mar 2008 23:09:33 -0400
Message-ID: <47DDE0ED.6040304@rtr.ca>
References: <005d01c87c4c$0d01f550$4d0fa8c0@M2007> <47CC9197.9050609@gmail.com> <20080304002215.GA13317@denix.org> <47CCC1C6.5010600@gmail.com> <20080304062942.GA14335@denix.org> <47CE55B3.6070701@gmail.com> <20080306041454.GA7242@denix.org> <47CF7222.7060702@gmail.com> <20080306065513.GE7150@denix.org> <47CF9880.4080900@gmail.com> <20080315214347.GA1511@denix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3128 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864AbYCQDJe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Mar 2008 23:09:34 -0400
In-Reply-To: <20080315214347.GA1511@denix.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Dmytriyenko <denis@denix.org>
Cc: Tejun Heo <htejun@gmail.com>, Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>

Denys Dmytriyenko wrote:
>
> 1. Keep existing system, but utilize 2 PCI-X slots for SATA controllers. This 
> requires using 8-port adapters, like the one I already have Supermicro Marvell 
> based. The question is - how stable sata_mv these days? It still says HIGHLY 
> EXPERIMENTAL...
..

It will lose that status early in the 2.6.26 timeframe.

Currently it does seem to work reasonably, with NCQ even,
but there are still errata for me to get round to fixing,
and the IRQ/EH/Reset code needs some work to ensure it can
always recover when something weird happens.

Port multiplier support is working now, and will be pushed
for 2.6.26 along with other fixes and stuff.

ATAPI support may yet follow before the summer.

Cheers

-ml
