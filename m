From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Fix accesses at LBA28 boundary (old bug, but nasty)
Date: Wed, 07 Apr 2010 10:29:07 +0900
Message-ID: <4BBBDFE3.4000602@gmail.com>
References: <4BBBB975.7000203@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:58790 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932397Ab0DGB3P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2010 21:29:15 -0400
Received: by qw-out-2122.google.com with SMTP id 8so196615qwh.37
        for <linux-ide@vger.kernel.org>; Tue, 06 Apr 2010 18:29:14 -0700 (PDT)
In-Reply-To: <4BBBB975.7000203@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ric Wheeler <rwheeler@redhat.com>

Hello, Mark.

On 04/07/2010 07:45 AM, Mark Lord wrote:
> Most drives from Seagate, Hitachi, and possibly other brands,
> do not allow LBA28 access to sector number 0x0fffffff (2^28 - 1).
> So instead use LBA48 for such accesses.
> 
> This bug could bite a lot of systems, especially when the user has
> taken care to align partitions to 4KB boundaries.  On misaligned systems,
> it is less likely to be encountered, since a 4KB read would end at
> 0x10000000 rather than at 0x0fffffff.

Oh, nice catch.  Kinda scary.

> Signed-off-by: Mark Lord <mlord@pobox.com>
>
> --- linux-2.6.34-rc3/include/linux/ata.h    2010-03-30
> 12:24:39.000000000 -0400
> +++ linux/include/linux/ata.h    2010-04-06 18:39:41.167702612 -0400
> @@ -1025,8 +1025,8 @@
>  
>  static inline int lba_28_ok(u64 block, u32 n_block)
>  {
> -    /* check the ending block number */
> -    return ((block + n_block) < ((u64)1 << 28)) && (n_block <= 256);
> +    /* check the ending block number: must be LESS THAN 0x0fffffff */
> +    return ((block + n_block) < (u64)((1 << 28) - 1)) && (n_block <= 256);

But why move the type casting?  The cast isn't required to begin with
but starting with u64 constant means the whole compile time
calculation will be in u64 (the intention of that cast I guess).

Thanks.

-- 
tejun
