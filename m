From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_tf_read_block() question
Date: Sun, 16 Aug 2009 11:15:31 +0900
Message-ID: <4A876BC3.3020407@gmail.com>
References: <20090815.224843.240484147.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:59287 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbZHPCPe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Aug 2009 22:15:34 -0400
In-Reply-To: <20090815.224843.240484147.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Atsushi.

Atsushi Nemoto wrote:
> I have a question on CHS calculation in ata_tf_read_block().
> 
> The calculation in ata_tf_read_block() is:
> 	block = (cyl * dev->heads + head) * dev->sectors + sect;
> 
> but ata_build_rw_tf() does:
> 	track = (u32)block / dev->sectors;
> 	cyl   = track / dev->heads;
> 	head  = track % dev->heads;
> 	sect  = (u32)block % dev->sectors + 1;
> 
> It seems inconsistent.  The correct calculation is:
> 	block = (cyl * dev->heads + head) * dev->sectors + sect - 1;
> isn't it?

Yes, indeed.

> I don't have any real problem.  Just noticed by code reading.

ata_tf_read_block() currently is used only when reporting failed block
address to upper layer so off-by-one bug there wouldn't be too
visible, especially for the venerable CHS addressing.

Care to submit a patch w/ warning message and capping for sect == 0
case?

Thanks.

-- 
tejun
