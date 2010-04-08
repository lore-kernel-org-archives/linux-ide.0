From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Fix accesses at LBA28 boundary (old bug, but nasty) (v2)
Date: Thu, 08 Apr 2010 13:00:06 -0400
Message-ID: <4BBE0B96.6070007@pobox.com>
References: <4BBBB975.7000203@teksavvy.com> <4BBCC648.30807@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:41581 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758827Ab0DHRAO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 13:00:14 -0400
Received: by qw-out-2122.google.com with SMTP id 8so871543qwh.37
        for <linux-ide@vger.kernel.org>; Thu, 08 Apr 2010 10:00:13 -0700 (PDT)
In-Reply-To: <4BBCC648.30807@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ric Wheeler <rwheeler@redhat.com>, David Milburn <dmilburn@redhat.com>

On 04/07/2010 01:52 PM, Mark Lord wrote:
> Most drives from Seagate, Hitachi, and possibly other brands,
> do not allow LBA28 access to sector number 0x0fffffff (2^28 - 1).
> So instead use LBA48 for such accesses.
>
> This bug could bite a lot of systems, especially when the user has
> taken care to align partitions to 4KB boundaries. On misaligned systems,
> it is less likely to be encountered, since a 4KB read would end at
> 0x10000000 rather than at 0x0fffffff.
>
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
>
> Reposting with the pre-existing (u64) cast removed.
>
> --- linux-2.6.34-rc3/include/linux/ata.h 2010-03-30 12:24:39.000000000
> -0400
> +++ linux/include/linux/ata.h 2010-04-06 18:39:41.167702612 -0400
> @@ -1025,8 +1025,8 @@
>
> static inline int lba_28_ok(u64 block, u32 n_block)
> {
> - /* check the ending block number */
> - return ((block + n_block) < ((u64)1 << 28)) && (n_block <= 256);
> + /* check the ending block number: must be LESS THAN 0x0fffffff */
> + return ((block + n_block) < ((1 << 28) - 1)) && (n_block <= 256);
> }

applied.

Neither 'git am' nor patch(1) would apply the patch for some reason, so 
I applied it manually.  Weird...  I could not spot obvious whitespace or 
word-wrap corruption.

