From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem: 2.6.20-rc7 sata_via: SATA-DVD-Writer doesn't work
 properly
Date: Thu, 1 Feb 2007 20:28:12 +0000
Message-ID: <20070201202812.10cba0d2@localhost.localdomain>
References: <20070201192231.xhwd8k5t4wg8w4sk@webmail.citykom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46020 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422928AbXBAUQN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Feb 2007 15:16:13 -0500
In-Reply-To: <20070201192231.xhwd8k5t4wg8w4sk@webmail.citykom.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: juergen.metzdorf@telelev-dsl.de
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Thu, 01 Feb 2007 19:22:31 +0100
juergen.metzdorf@telelev-dsl.de wrote:

> Hello,
> 
> I'm experiencing problems with an SATA-DVD-Writer (Samsung SH-S183a) connected
> to a VIA8237 motherboard chipset. As you can see in the attached boot.log, the
> system is reducing the DMA-Mode from DMA33 to DMA25 then to DMA16 to end up as
> PIO4. As a result the dvds that are written are corrupt. During the writing
> process the messages log shows repeating entries like this:

Please try the patch I posted to the kernel list and ide list yesterday
which allows settle time on DMA changes.
