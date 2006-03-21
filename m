From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/4] libata: add per-dev pio/mwdma/udma_mask
Date: Tue, 21 Mar 2006 10:25:37 +0000
Message-ID: <1142936737.21455.31.camel@localhost.localdomain>
References: <11421469551000-git-send-email-htejun@gmail.com>
	 <44152D64.6000903@pobox.com> <20060313093052.GB2091@htj.dyndns.org>
	 <441540DC.2050001@pobox.com> <20060313100927.GE2091@htj.dyndns.org>
	 <441545D0.4010100@pobox.com> <20060313102412.GA25706@htj.dyndns.org>
	 <441F5D57.4050906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49065 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932389AbWCUKTo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 05:19:44 -0500
In-Reply-To: <441F5D57.4050906@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Llu, 2006-03-20 at 20:56 -0500, Jeff Garzik wrote:
> > So, ata_port_info uses pio/mwdma/udma_mask and ata_port and ata_device
> > use single xfer_mask and all the masking constants are converted to
> > mask single xfer_mask.  Sounds good to you?
> 
> Well, if I read him correctly, Alan seems to have weighted in on the 
> side of pio/mwdma/udma_mask.
> 
> Maybe we could go with your original patches' direction for now, and 
> then move to a consolidated xfer_mask internally later.


What I've done for the filter side of things is kept the combined mask
as what is filtered by the driver, and that looks tidy. What came out
ugly that I objected to was the horribly mess you got when declaring all
the driver modes available.


