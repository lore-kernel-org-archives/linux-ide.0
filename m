From: Daniel Drake <dsd@gentoo.org>
Subject: Re: SATA causing hard freeze on 2.6.6
Date: Tue, 18 May 2004 11:56:22 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A9EBD6.8010309@gentoo.org>
References: <40A75BF3.7040403@gentoo.org> <40A75C10.1030402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpc5-hitc2-5-0-cust152.lutn.cable.ntl.com ([82.0.115.152]:52383
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S262175AbUERJpx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 May 2004 05:45:53 -0400
In-Reply-To: <40A75C10.1030402@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> What is the behavior of libata?
> 
> CONFIG_SCSI_SATA, CONFIG_SCSI_SATA_SIL

Ah, I had not made the link that those siimage_mmio_ide_dma_test_irq were 
being caused by a different driver. But I had been trying libata with the 
2.6.6 kernel that I originally mentioned, and was getting the lockups.

Strangely, I started getting those lockups this morning while on IDE. I 
investigated the problem a bit further, and it turned out that a problematic 
SB Live was messing up the system (I had my suspicions on this card already). 
After removing that, I was able to boot up into IDE again. Just now, I plugged 
the SATA converter back in, and I'm now booted up on SATA with no problems at all.

Sorry for the noise :)

Daniel
