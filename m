From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Fix accesses at LBA28 boundary (old bug, but nasty) (v2)
Date: Thu, 08 Apr 2010 06:01:53 +0900
Message-ID: <4BBCF2C1.90308@gmail.com>
References: <4BBBB975.7000203@teksavvy.com> <4BBCC648.30807@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:54944 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab0DGU6d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2010 16:58:33 -0400
Received: by qw-out-2122.google.com with SMTP id 8so535845qwh.37
        for <linux-ide@vger.kernel.org>; Wed, 07 Apr 2010 13:58:31 -0700 (PDT)
In-Reply-To: <4BBCC648.30807@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ric Wheeler <rwheeler@redhat.com>

On 04/08/2010 02:52 AM, Mark Lord wrote:
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

Heh, yeah, killing the cast works too.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
