From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2] ahci: sata: add support for exynos5440 sata
Date: Mon, 17 Jun 2013 11:24:46 -0700
Message-ID: <20130617182446.GI32663@mtj.dyndns.org>
References: <1366104482-14240-1-git-send-email-ks.giri@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:39827 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab3FQSYv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jun 2013 14:24:51 -0400
Content-Disposition: inline
In-Reply-To: <1366104482-14240-1-git-send-email-ks.giri@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Girish K S <girishks2000@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

On Tue, Apr 16, 2013 at 02:58:02PM +0530, Girish K S wrote:
> This patch adds the compatible string of the exynos5440 sata controller
> compliant with the ahci 1.3 and sata 3.0 specification.
> 
> Signed-off-by: Girish K S <ks.giri@samsung.com>
> 
> changes in v2:
> 		changed the compatible string by adding the actual IP
> owners name instead of the SoC vendor name.

Applied to libata/for-3.11.

Can you please keep SOB at the end of the description after the
revision history from the next time?

Thanks.

-- 
tejun
