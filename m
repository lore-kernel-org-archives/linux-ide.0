From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Fri, 17 Mar 2006 04:57:35 -0500
Message-ID: <441A880F.7010204@pobox.com>
References: <1142344212.4416ca14a26b4@webmail.aon.at> <44182CD7.9070401@rtr.ca> <20060316100838.GF3595@suse.de> <441A4873.3030102@rtr.ca> <441A80CA.6080407@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:36803 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751201AbWCQJ6J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Mar 2006 04:58:09 -0500
In-Reply-To: <441A80CA.6080407@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Mark Lord <lkml@rtr.ca>, Jens Axboe <axboe@suse.de>, me_trash1@aon.at, linux-ide@vger.kernel.org

Albert Lee wrote:
> How about the attached renaming patch?
> It could make the command names more consistent to what's in the ATA/ATAPI spec.
> 
> ---
> Albert
> 
> 
> Changes:
> 
> ATA_CMD_READ        => ATA_CMD_READ_DMA
> ATA_CMD_WRITE       => ATA_CMD_WRITE_DMA
> ...
> ATA_CMD_PIO_READ    => ATA_CMD_READ_PIO
> ATA_CMD_PIO_WRITE   => ATA_CMD_WRITE_PIO
> ...
> ATA_CMD_FPDMA_READ  => ATA_CMD_READ_FPDMA_QUEUED
> ATA_CMD_FPDMA_WRITE => ATA_CMD_WRITE_FPDMA_QUEUED


Even given the current thread's confusion, I rather like the existing 
names.  Everybody does DMA these days, so ATA_CMD_WRITE being of DMA 
protocol seems the most natural to me.

	Jeff


