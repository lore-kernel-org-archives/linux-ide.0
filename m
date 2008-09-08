From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] sata_nv: disable hardreset for generic
Date: Mon, 08 Sep 2008 21:17:30 +0200
Message-ID: <48C57A4A.2050303@kernel.org>
References: <4895407B.5030602@kernel.org> <48B803F8.8000306@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48428 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111AbYIHTTd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 15:19:33 -0400
In-Reply-To: <48B803F8.8000306@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@sun7.cn, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>
Cc: stable@kernel.org

Tejun Heo wrote:
> From 2.6.26, libata is defaulting to hardreset for various reasons one
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

This one definitely should go into -stable too.  The original patch is...

http://article.gmane.org/gmane.linux.ide/34077/raw

Thanks.

-- 
tejun
