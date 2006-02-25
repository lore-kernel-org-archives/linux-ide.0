From: "kacer" <kacerxy@seznam.cz>
Subject: RE: Kernel driver for Sil 3112 (sata_sil.c) problems
Date: Sat, 25 Feb 2006 14:31:15 +0100
Message-ID: <20060225133317.A007B37B75@relay.netbox.cz>
References: <44005696.9040705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.netbox.cz ([83.240.0.201]:5600 "EHLO relay.netbox.cz")
	by vger.kernel.org with ESMTP id S1030247AbWBYNdY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Feb 2006 08:33:24 -0500
In-Reply-To: <44005696.9040705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>, 'Jeff Garzik' <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi,
the controller is Kouwell 571S-4 , it is based on 2 chips Sil 3112, each
chip provides 2 ports. I don't think it's matter of power or heat, server is
huge, but has good cooling and 550 W Enermax PSU. My friend has same
problems and he tested it, problem persists no matter how many HDDs (1-4) or
PCI cards in computer.

For Tejun: I will provide that list from lspci as soon as machine will be
up, unfortunately machine's OS is stucked in error and I can't reset it now.

For more info: there is Gentoo linux on box, most packages on latest builds,
kernel is from vanilla sources with custom configuration, but I tried also
several kernels from gentoo sources.

Jiri Bartosik


-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Saturday, February 25, 2006 2:08 PM
To: Jeff Garzik
Cc: kacer; linux-ide@vger.kernel.org
Subject: Re: Kernel driver for Sil 3112 (sata_sil.c) problems

Jeff Garzik wrote:
> kacer wrote:
> 
>> Dear Jeff,
>> sorry for disturbing you, but I tried nearly everything to get this SATA
>> controller (Silicon Image Sil 3112) working, but it always crashes while
>> writing data (few hundred MBs or few GBs). In dmesg I can see 
>> something like
>> that:
> 
> 
> hrm, sounds like heat or power...
> 

He said he was using 2 out of 4 ports. Gotta be 3114. It *might* be 
R_ERR on DMA activate FIS.

-- 
tejun

