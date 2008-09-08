From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_nv: disable hardreset for generic
Date: Mon, 08 Sep 2008 12:16:28 -0400
Message-ID: <48C54FDC.5020603@garzik.org>
References: <4895407B.5030602@kernel.org> <48B803F8.8000306@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37760 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062AbYIHQQi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 12:16:38 -0400
In-Reply-To: <48B803F8.8000306@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux@sun7.cn, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>

Tejun Heo wrote:
>>From 2.6.26, libata is defaulting to hardreset for various reasons one
> of them being unifying probing, hotplug and EH reset paths uniform.
> Previously, broken hardreset could go unnoticed as it wasn't used
> during probing but when something goes wrong or after hotplug the
> problem will surface and bite hard.
> 
> OSDL bug 11195 reports that sata_nv generic flavor falls into this
> category.  Hardreset itself succeeds but PHY stays offline after
> hardreset.  I tried longer debounce timing but the result was the
> same.
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=11195
> 
> So, it seems we'll have to drop hardreset from the generic flavor.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Peer Chen <pchen@nvidia.com>
> ---
> There have been more than three reports of this problem and there just
> isn't good reason to defer this workaround anymore.  Once this gets
> into #upstream-fixes, I think this should go to -stable too.
> 
> Thanks.
> 
>  drivers/ata/sata_nv.c |   19 +------------------

applied


