From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Restore SB600 SATA controller 64 bit DMA
Date: Wed, 27 May 2009 16:22:20 +0900
Message-ID: <4A1CEA2C.10508@kernel.org>
References: <1243407883.3220.10.camel@brienza-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45248 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761961AbZE0HWr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 May 2009 03:22:47 -0400
In-Reply-To: <1243407883.3220.10.camel@brienza-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Shane Huang wrote:
> Community reported one SB600 SATA issue(BZ #9412), which led to 64 bit
> DMA disablement for all SB600 revisions by driver maintainers with
> commits c7a42156d99bcea7f8173ba7a6034bbaa2ecb77c and
> 4cde32fc4b32e96a99063af3183acdfd54c563f0.
> 
> But the root cause is ASUS M2A-VM system BIOS bug in old revisions
> like 0901, while forcing into 32bit DMA happens to work as workaround.
> Now it's time to withdraw 4cde32fc4b32e96a99063af3183acdfd54c563f0
> so as to restore the SB600 SATA 64bit DMA capability.
> This patch is also adding the workaround for M2A-VM old BIOS revisions,
> but users are suggested to upgrade their system BIOS to the latest one
> if they meet this issue.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> Cc: Tejun Heo <tj@kernel.org>

It would be nicer to mention the export of dmi_get_year() but..

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
