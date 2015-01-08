From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Thu, 8 Jan 2015 10:36:53 -0500
Message-ID: <20150108153653.GD9402@htj.dyndns.org>
References: <20150108151151.GC9402@htj.dyndns.org>
 <1420731267-7385-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:42291 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbbAHPg5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jan 2015 10:36:57 -0500
Content-Disposition: inline
In-Reply-To: <1420731267-7385-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Thu, Jan 08, 2015 at 10:34:27AM -0500, Martin K. Petersen wrote:
> As defined, the DRAT (Deterministic Read After Trim) and RZAT (Return
> Zero After Trim) flags in the ATA Command Set are unreliable in the
> sense that they only define what happens if the device successfully
> executed the DSM TRIM command. TRIM is only advisory, however, and the
> device is free to silently ignore all or parts of the request.
> 
> In practice this renders the DRAT and RZAT flags completely useless and
> because the results are unpredictable we decided to disable discard in
> MD for 3.18 to avoid the risk of data corruption.
> 
> Hardware vendors in the real world obviously need better guarantees than
> what the standards bodies provide. Unfortuntely those guarantees are
> encoded in product requirements documents rather than somewhere we can
> key off of them programatically. So we are compelled to disabling
> discard_zeroes_data for all devices unless we explicitly have data to
> support whitelisting them.
> 
> This patch whitelists SSDs from a few of the main vendors. None of the
> whitelists are based on written guarantees. They are purely based on
> empirical evidence collected from internal and external users that have
> tested or qualified these drives in RAID deployments.
> 
> The whitelist is only meant as a starting point and is by no means
> comprehensive:
> 
>    - All intel SSD models except for 510
>    - Micron M5?0/M600
>    - Samsung SSDs
>    - Seagate SSDs
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Applied to libata/for-3.19-fixes.

Thanks.

-- 
tejun
