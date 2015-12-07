From: Tejun Heo <tj@kernel.org>
Subject: Re: [v2 0/2] ata/libata-eh.c: introduce ATA_FLAG_NO_LOG_PAGE
Date: Mon, 7 Dec 2015 10:26:30 -0500
Message-ID: <20151207152630.GD9175@mtj.duckdns.org>
References: <cover.1449248754.git.andreas.werner@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34475 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932639AbbLGP0c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2015 10:26:32 -0500
Content-Disposition: inline
In-Reply-To: <cover.1449248754.git.andreas.werner@men.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Werner <andreas.werner@men.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, Dec 04, 2015 at 06:12:24PM +0100, Andreas Werner wrote:
> This patchset add a new ata port flag ATA_FLAG_NO_LOG_PAGE to be able
> to blacklist ports/controller which e.g. locks up on a log page read.
> 
> This flag is added to the sata_fsl driver which is the first affected
> one.
> 
> The lockup was detected on Freescale P1013/P1022, T4240 using a ATP
> mSATA.
> The device failed during initialisation if the SATA device includes the
> devslp feature.
> 
> With this patchset, we blacklist the fsl sata controller and return
> a error on any attempt to read a log page. This allows us to access
> the mSATA.

Applied 1-2 to libata/for-4.4-fixes.

Thanks.

-- 
tejun
