From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH #upstream-fixes] sata_nv: disable hardreset for generic
Date: Wed, 13 Aug 2008 15:51:28 +0900
Message-ID: <48A28470.9030907@kernel.org>
References: <4895407B.5030602@kernel.org> <15F501D1A78BD343BE8F4D8DB854566B2F83394E@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46141 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454AbYHMGyT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 02:54:19 -0400
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B2F83394E@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: linux@sun7.cn, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Kuan Luo <kluo@nvidia.com>

Peer Chen wrote:
> Hard reset should work for MCP61 and 2.6.26 work fine on my MCP61 board,
> I believe the failure is specific case.
> Does this board work fine under windows? Switch the HDD or connecting
> the HDD to other ports are also worth trying.

Sorry about the delay.  Can you please try to test one?  This one is
rather serious regression as devices fail detection and it's far better
to disable hardreset on all MCP61s if we can't determine which specific
ones are problematic.

Thank you.

-- 
tejun
