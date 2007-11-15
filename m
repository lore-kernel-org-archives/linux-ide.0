From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/2] sata_nv: fix ATAPI issues with memory over 4GB (v3)
Date: Thu, 15 Nov 2007 10:38:58 +0900
Message-ID: <473BA332.9030406@gmail.com>
References: <473A7677.6080007@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:10505 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbXKOBjI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 20:39:08 -0500
Received: by wa-out-1112.google.com with SMTP id v27so450284wah
        for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 17:39:07 -0800 (PST)
In-Reply-To: <473A7677.6080007@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Robert Hancock wrote:
> This fixes some problems with ATAPI devices on nForce4 controllers in ADMA mode
> on systems with memory located above 4GB. We need to delay setting the 64-bit
> DMA mask until the PRD table and padding buffer are allocated so that they don't
> get allocated above 4GB and break legacy mode (which is needed for ATAPI
> devices).
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

applied to #tj-upstream-fixes.

-- 
tejun
