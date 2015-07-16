From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Do not blacklist M510DC
Date: Thu, 16 Jul 2015 12:16:24 -0400
Message-ID: <20150716161624.GX15934@mtj.duckdns.org>
References: <1437008603-16554-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f196.google.com ([209.85.160.196]:36092 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbbGPQQ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jul 2015 12:16:27 -0400
Content-Disposition: inline
In-Reply-To: <1437008603-16554-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org

On Wed, Jul 15, 2015 at 09:03:23PM -0400, Martin K. Petersen wrote:
> A new Micron drive was just announced, once again recycling the first
> part of the model string. Add an underscore to the M510/M550 pattern to
> avoid picking up the new DC drive.
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: <stable@vger.kernel.org>

Applied to libata/for-4.2-fixes.

Thanks.

-- 
tejun
