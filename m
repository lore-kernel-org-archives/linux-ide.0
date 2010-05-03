From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Using PATA Platform Driver to access Memory Mapped CF Card
Date: Mon, 3 May 2010 11:57:19 +0100
Message-ID: <20100503115719.50566cef@lxorguk.ukuu.org.uk>
References: <4BDAE529.20903@gmail.com>
	<201005010524.40949.marek.vasut@gmail.com>
	<4BDBD4AB.8020200@gmail.com>
	<20100501113346.29225519@lxorguk.ukuu.org.uk>
	<4BDD6897.7000002@gmail.com>
	<20100502132913.1e531bfd@lxorguk.ukuu.org.uk>
	<4BDE2949.6030301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39718 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757439Ab0ECKva (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 May 2010 06:51:30 -0400
In-Reply-To: <4BDE2949.6030301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Graeme Russ <graeme.russ@gmail.com>
Cc: linux-ide@vger.kernel.org

> and implemented an 8-bit version of ata_sff_data_xfer() in my board
> specific code. Should I submit a patch (or is this considered too esoteric
> for mainline?)

Please submit a patch.

> 
> I now have another problem - My board has two CF slots (one at base address
> 0x20000000 and one at base address 0x20001000. I would like to be able to
> access them both, but if I try to init two pata_platform devices I get:
> 
> sysfs: cannot create duplicate filename '/devices/platform/pata_platform'
> 
> and
> 
> kobject_add_internal failed for pata_platform with -EEXIST, don't try to
> register things with the same name in the same directory
> 
> Is it possible to register two devices using the pata platform driver?

Yes but you cannot have two devices with the same name/id so make sure
you are setting the id etc. See

 arch/arm/mach-s3c2440/mach-anubis.c
