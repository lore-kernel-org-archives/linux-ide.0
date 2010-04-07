From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Fix accesses at LBA28 boundary (old bug, but nasty)
 (v2)
Date: Wed, 7 Apr 2010 20:18:20 +0100
Message-ID: <20100407201820.77b0d67f@lxorguk.ukuu.org.uk>
References: <4BBBB975.7000203@teksavvy.com>
	<4BBCC648.30807@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51108 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757493Ab0DGTOs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2010 15:14:48 -0400
In-Reply-To: <4BBCC648.30807@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Ric Wheeler <rwheeler@redhat.com>

On Wed, 07 Apr 2010 13:52:08 -0400
Mark Lord <kernel@teksavvy.com> wrote:

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

Acked-by: Alan Cox <alan@linux.intel.com>
