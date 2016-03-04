From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: sata_rcar: Use ARCH_RENESAS
Date: Fri, 4 Mar 2016 07:48:41 -0500
Message-ID: <20160304124841.GF13868@htj.duckdns.org>
References: <1456968530-19635-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34002 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbcCDMso (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2016 07:48:44 -0500
Content-Disposition: inline
In-Reply-To: <1456968530-19635-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Thu, Mar 03, 2016 at 10:28:50AM +0900, Simon Horman wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
> 
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied to libata/for-4.6.

Thanks.

-- 
tejun
