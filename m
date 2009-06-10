From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Restore SB600 SATA controller 64 bit DMA
Date: Wed, 10 Jun 2009 11:06:01 -0400
Message-ID: <4A2FCBD9.4090604@pobox.com>
References: <1243407883.3220.10.camel@brienza-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54614 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754937AbZFJPGE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jun 2009 11:06:04 -0400
In-Reply-To: <1243407883.3220.10.camel@brienza-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org

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

applied


