From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH/RFC] libata-dev: handle DRQ=1 ERR=1 (revised)
Date: Sat, 01 Apr 2006 14:29:43 -0500
Message-ID: <442ED4A7.1050509@garzik.org>
References: <442DC9E7.5000203@garzik.org> <442E4444.1050806@tw.ibm.com> <442E4A23.8000409@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55260 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751423AbWDAT3p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 14:29:45 -0500
In-Reply-To: <442E4A23.8000409@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Handle DRQ=1 ERR=1 situation. Revised according to what IDE try_to_flush_leftover_data() does.
> 
> Changes:
>  - For ATA PIO writes and ATAPI devices, just stop the HSM and let EH handle it.
>  - For ATA PIO reads, read only one block of junk data and then let EH handle it.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> Thanks for the IDE try_to_flush_leftover_data() pointer.
> The difference between IDE and irq-pio (before this patch):
>  1. IDE only does the data transfer for PIO reads.
>     For PIO writes and ATAPI, it just stops and abort/reset.
>  2. For PIO reads, only one block of data is transferred. EH then takes over if DRQ is still set after that.
>     The behavior of irq-pio before this patch is: let HSM go on, until the device set DRQ=0 or all data read.
> 
> Te IDE behavior looks safer. (When the device is in bad status, we really should not
> write any data to it.)
> 
> Patch against irq-pio branch (08a556db919f67e1e4d33ae8d40f7222da34d994).
> For your review, thanks.

applied


