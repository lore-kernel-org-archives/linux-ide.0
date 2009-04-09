From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 32-bit IO to-do item...
Date: Thu, 9 Apr 2009 09:54:15 +0100
Message-ID: <20090409095415.585cc759@lxorguk.ukuu.org.uk>
References: <49DD86D4.3090304@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55754 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751349AbZDIIyI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2009 04:54:08 -0400
In-Reply-To: <49DD86D4.3090304@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>

On Thu, 09 Apr 2009 01:25:40 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan,
> 
> I keep meaning to mention this (and get it into the mail archive)... 
> The 32-bit IO patch was incomplete, because it rendered 
> ATA_IOC_[GS]ET_IO32 handling in ata_sas_scsi_ioctl() -- our base ioctl 
> handler -- incorrect.
> 
> Previously, it simply ensured the ioctls reflected hardcoded 16-bit I/O. 
>   Now, behavior no longer matches what the ioctls report.
> 
> At a minimum, drivers probably need to set an "I'm using 32bit I/O" 
> flag, that the ioctl then reads, replacing ata_sas_scsi_ioctl()'s 
> assumption that val==0.

Put onto my TODO list. I missed the fact you were even faking that
rather bogus ioctl (what for example does a PIO over DMA device claim ??)
