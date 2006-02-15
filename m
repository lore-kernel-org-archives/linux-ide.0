From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] libata: increase LBA48 max sectors to 65535
Date: Wed, 15 Feb 2006 14:07:25 +0100
Message-ID: <20060215130725.GP4203@suse.de>
References: <1139754779159-git-send-email-htejun@gmail.com> <43EF8E61.5040409@pobox.com> <43EFD73D.4070207@gmail.com> <43F011DF.6020203@pobox.com> <20060215072449.GA31691@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:40210 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1945928AbWBONIl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 08:08:41 -0500
Content-Disposition: inline
In-Reply-To: <20060215072449.GA31691@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Wed, Feb 15 2006, Tejun Heo wrote:
> max_hw_sectors/max_sectors separation patch made into the tree,
> increase max_sectors to its hardware limit.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
> Jeff, first of all, thanks for the pointer.  I have two more
> questions.
> 
> * I make ATA_MAX_SECTORS_LBA48 65535 (the 0000h case is supposed to be
>   broken, right?); however, the comment says 65534.  Should it be
>   65534?

Since we never noticed any breakage on !sectors on lba28, I think we can
safely assume that !sectors will work fine for lba48 as well. So why not
just make it full 64k, eg 65536? ->max_hw_sectors is an unsigned int
now, so 64k wont overflow it.


-- 
Jens Axboe

