From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: question about SATA and IDE DVD/CD drives.
Date: Fri, 02 Jul 2004 11:38:37 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40E5817D.4000408@pobox.com>
References: <Pine.LNX.4.44.0407021403120.2190-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30425 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263085AbUGBPiu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2004 11:38:50 -0400
In-Reply-To: <Pine.LNX.4.44.0407021403120.2190-100000@einstein.homenet>
List-Id: linux-ide@vger.kernel.org
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-ide@vger.kernel.org

Tigran Aivazian wrote:
> Hi Jeff,
> 
> I was a bit confused with the "SATA vs IDE" thing recently, namely the 
> fact that if I compile _both_ IDE and SATA support into the kernel 
> then IDE takes over and SATA gets a "busy" error, and as a result I get 
> 3M/sec performance instead of 56M/sec.
> 
> Now, realizing this error I have reconfigured the kernel to NOT include 
> ide and ONLY include SATA plus chipset-specific ata_piix.c (I have ICH6 
> device 2652). However, now the new problem is that I can't see the IDE 
> DVD-ROM drive anymore. Here is dmesg:
[...]
> As you see, sda is there, but where is my DVD drive gone?

I am guessing that your DVD drive is connected to a PATA bus, but you 
disabled the PATA driver (CONFIG_IDE) completely.

Enable CONFIG_IDE, and disable CONFIG_BLK_DEV_IDE_SATA, and that will 
fix things I bet.

	Jeff


