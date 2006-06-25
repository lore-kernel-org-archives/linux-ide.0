From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: More information on ATI IXP failure in git9
Date: Sun, 25 Jun 2006 18:19:10 -0400
Message-ID: <449F0BDE.4000102@pobox.com>
References: <200606252359.27671.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48019 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932395AbWFYWTN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jun 2006 18:19:13 -0400
In-Reply-To: <200606252359.27671.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-ide@vger.kernel.org

Andi Kleen wrote:
> The system uses sata_sil with
> 
> 00:11.0 IDE interface: ATI Technologies Inc ATI 437A Serial ATA Controller
> 00:12.0 IDE interface: ATI Technologies Inc ATI 4379 Serial ATA Controller
> 
> I added some printks and it fails here:
> 
> 
> static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
> {
>         struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
>         u8 status;
> 
>         if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
>                 u32 serror;
> 
> 
>                  ...
>           
>                 <------ hits two times, 
>                goto freeze;

Kernel 2.6.17's sata_sil always masks the SATA phy interrupts, whereas 
2.6.17-git sata_sil does not.

Can you print the hex value of 'serror' variable for us?

	Jeff



