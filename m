From: Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: sata_sil: freeze on modprobe
Date: Sat, 29 May 2010 08:45:02 +0200
Message-ID: <20100529084502.3abaee87@linux.lan.towertech.it>
References: <20100528203832.065a2469@linux.lan.towertech.it>
	<4C0057FF.7030501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elettra.colt-to.towertech.it ([213.215.222.70]:46285 "EHLO
	elettra.colt-to.towertech.it" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751243Ab0E2Gow (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 May 2010 02:44:52 -0400
In-Reply-To: <4C0057FF.7030501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On Fri, 28 May 2010 17:55:43 -0600
Robert Hancock <hancockrwd@gmail.com> wrote:

> >   how can I help debugging?
> 
> What does /proc/interrupts show after this? It seems like you might be 
> missing interrupts somehow.

 I think you've got it, IRQs are not flowing.  
 16:          6   IO-APIC-fasteoi   sata_sil

 I'll check the BIOS and twiggle around with
 the slots.

> > ata6.00: 488281250 sectors, multi 16: LBA48 NCQ (depth 0/32)
> > ata6.00: applying Seagate errata fix (mod15write workaround)
> 
> This drive isn't in the mod15write blacklist - did you use the slow_down 
> module parameter?

 yes, i tried both with and without.

 ty.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

