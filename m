From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: 31244 & sata_vsc & PPC
Date: Fri, 18 Feb 2005 22:01:49 -0800
Message-ID: <20050219060149.GB720678@sgi.com>
References: <4213996C.4060301@motorola.com> <20050216190821.GA19150@havoc.gtf.org> <4213B24C.4030302@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from omx2-ext.sgi.com ([192.48.171.19]:39565 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261641AbVBSGDZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Feb 2005 01:03:25 -0500
Content-Disposition: inline
In-Reply-To: <4213B24C.4030302@motorola.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ajit Prem <Ajit.Prem@motorola.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Wed, Feb 16, 2005 at 01:51:24PM -0700, Ajit Prem wrote:
> 
> Thanks for the help.
> 
> I printed the int_status register on interrupt
> entry into vsc_sata_interrupt and got 0x8300.
> According to the 31244 spec, this means (I have
> only 1 disk connected to port 1) :
> 
> -- SATA Port 1 IDE Interrupt (0x8000)
> -- SATA Port 1 PHY Ready Interrupt (0x0200)
> -- SATA Port 1 Phy Change State Interrupt (0x0100)
> 
> Any patch I can try?
> 
> Thanks,
> 
> AP

Interesting that I haven't seen this, but then I only have
the Vitesse part.

Jeff, I don't see where libata-core writes to the SCR_ERROR
register to clear the PHY Ready and Phy Change State interrupts.
Is this something that sata_vsc is supposed to do in its
interrupt handler?  The core would miss such info if sata_vsc
did this . . . .

jeremy
