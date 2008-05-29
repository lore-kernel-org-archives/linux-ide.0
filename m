From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC PATCH] libata-sff: Fix oops reported in kerneloops.org for
 pnp devices with no ctl
Date: Thu, 29 May 2008 17:57:04 -0400
Message-ID: <483F26B0.8010006@garzik.org>
References: <20080529161453.24735.805.stgit@core>	<alpine.LFD.1.10.0805290950230.2958@woody.linux-foundation.org>	<20080529190235.258d304e@core>	<483EF536.90801@garzik.org>	<20080529194238.36458a46@core>	<483F049E.2090809@garzik.org>	<20080529221058.1169e140@core> <20080529223755.12610b87@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54690 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbYE2V5G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 May 2008 17:57:06 -0400
In-Reply-To: <20080529223755.12610b87@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> The Linusified version:
> 
> - Make ata_sff_altstatus private so nobody uses it by mistake
> - Drop the 400nS delay from it
> 
> Add
> 
> ata_sff_irq_status	-	encapsulates the IRQ check logic
> 
> This function keeps the existing behaviour for altstatus using devices. I
> actually suspect the logic was wrong before the changes but -rc isn't the
> time to play with that
> 
> ata_sff_sync		-	ensure writes hit the device
> 
> Really we want an io* operation for 'is posted' eg ioisposted(ioaddr) so
> that we can fix the nasty delay this causes on most systems.
> 
> - ata_sff_pause		-	400nS delay
> 
> Ensure the command hit the device and delay 400nS
> 
> - ata_sff_dma_pause
>  
> Ensure the I/O hit the device and enforce an HDMA1:0 transition delay.
> Requires altstatus register exists, BUG if not so we don't risk
> corruption in MWDMA modes. (UDMA the checksum will save your backside in
> theory)
> 
> The only other complication then is devices with their own handlers.
> rb532 can use dma_pause but scc needs to access its own altstatus
> register for internal errata workarounds so directly call the drivers own
> altstatus function.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Honestly I think your first RFC PATCH (dated Thu, 29 May 2008 22:10:58 
+0100) turned out better than this.

NO_ALTSTATUS is a bit ugly, don't you think?

In any case, based on a quick review I would certainly ack the first RFC 
PATCH.

	Jeff




