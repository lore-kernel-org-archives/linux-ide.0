From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: PATA failure with piix, works with libata
Date: Mon, 6 Mar 2006 01:03:33 +0000
Message-ID: <20060306010333.GA8951@srcf.ucam.org>
References: <20060303183937.GA30840@srcf.ucam.org> <20060305225733.GA8578@srcf.ucam.org> <440B770A.8090707@garzik.org> <20060306003221.GA8805@srcf.ucam.org> <440B8921.9030602@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:31376 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751223AbWCFBDl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 5 Mar 2006 20:03:41 -0500
Content-Disposition: inline
In-Reply-To: <440B8921.9030602@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 07:58:09PM -0500, Jeff Garzik wrote:
> Matthew Garrett wrote:
> >Yeah, this is an ICH7. I can't find anything in drivers/ide that would 
> >result in it being done, which is why I'm kind of confused. ide_ack_intr 
> >seems to be defined to do nothing on x86 since IDE_ARCH_ACK_INTR isn't 
> >defined there?
> 
> This is more a piix-specific behavior than an arch-specific behavior.

Joy. So it works by accident in legacy mode? Does anything need to be 
done other than just writing the DMA status register back? I'm not 
finding anything terribly helpful in the ICH7 docs, but I may just be 
being blind.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
