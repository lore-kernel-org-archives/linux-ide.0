From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] libata: convert assert(X)'s in libata core layer
 to WARN_ON(!X)'s
Date: Sat, 11 Feb 2006 17:54:03 -0500
Message-ID: <43EE6B0B.1000600@pobox.com>
References: <1139652673362-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:58320 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750810AbWBKWyG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Feb 2006 17:54:06 -0500
In-Reply-To: <1139652673362-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> In an effort to kill libata-specific assert() and use generic
> WARN_ON(), this patch converts all assert(X)'s in libata core layer to
> WARN_ON(!X)'s.  Most conversions are straight-forward logical negation
> exception for the followings.
> 
> * In libata-core.c:ata_fill_sg(),
>   assert(qc->n_elem > 0) is converted to WARN_ON(qc->n_elem == 0) because
>   qc->n_elem is unsigned and unsigned <= 0 is weird.
> 
> * In libata-scsi.c:ata_gen_ata_desc/fixed_sense(),
>   assert(NULL != qc->ap->ops->tf_read) is converted to
>   WARN_ON(qc->ap->ops->tf_read == NULL), as there are no other users of
>   'constant cond var' style in libata.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-3


