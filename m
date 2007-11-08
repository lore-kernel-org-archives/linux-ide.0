From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: skip 0xff polling for PATA
	controllers
Date: Thu, 8 Nov 2007 13:14:36 -0500
Message-ID: <20071108181436.GG3491@havoc.gtf.org>
References: <47327262.9020004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:36969 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762452AbXKHSOh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 13:14:37 -0500
Content-Disposition: inline
In-Reply-To: <47327262.9020004@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Luca Tettamanti <kronos.it@gmail.com>

On Thu, Nov 08, 2007 at 11:20:18AM +0900, Tejun Heo wrote:
> In a presentation of true workmanship, pata_ali asserts IRQ
> permanantly if the TF status register is read more than once when
> there's no device attached to the port.
> 
> Avoid waiting polling for !0xff if it's PATA.  It's needed only for
> some rare SATA devices anyway.
> 
> This problem is reported by Luca Tettamanti in bugzilla bug 9298.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Tested-By: Luca Tettamanti <kronos.it@gmail.com>

applied


