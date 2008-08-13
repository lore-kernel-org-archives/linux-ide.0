From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv (NOT!)
Date: Wed, 13 Aug 2008 12:12:03 -0400
Message-ID: <48A307D3.2000905@rtr.ca>
References: <48A0C170.2000803@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:54550 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbYHMQMC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 12:12:02 -0400
In-Reply-To: <48A0C170.2000803@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Gill <smgill75@verizon.net>
Cc: linux-ide@vger.kernel.org

Steven Gill wrote:
> Hi List,
> 
> I am having some issues getting my Marvell 6145 working on my Asus P5E 
> ws pro motherboard working.  I am using a 3rd party patch to get the 
> pata port working, but have not had success with my e-sata ports (on the 
> board the 6145 drives 2 sata and 2 e-sata ports.  There are another 6 
> sata ports driven by the onboard intel ich9).  When checking dmesg 
> output, I see this:
> 
> ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:02:00.0 to 64
> Marvell (S)ATA Controller is found, using IRQ 16.
> Interrupt Error: 0x40000000 orgIntStatus: 0x40000001 completeSlot=0x1.
> 
> I am willing to help debug any issues, test patches, etc, but most 
> importantly wanted to report the issue.  I know this is labelled as 
> "highly experimental", but again, wanted to offer assistance in testing.
..

Wrong driver.  sata_mv does *NOT* drive the 6145 chip.
Rather, that particular chip emulates AHCI, and uses the ahci driver.

-ml
