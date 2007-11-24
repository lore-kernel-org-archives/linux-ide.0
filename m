From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB (v3)
Date: Sat, 24 Nov 2007 14:12:10 +0900
Message-ID: <4747B2AA.600@gmail.com>
References: <47463534.9010100@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:13000 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXKXFMS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Nov 2007 00:12:18 -0500
Received: by wa-out-1112.google.com with SMTP id v27so34575wah
        for <linux-ide@vger.kernel.org>; Fri, 23 Nov 2007 21:12:17 -0800 (PST)
In-Reply-To: <47463534.9010100@shaw.ca>
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

Acked-by: Tejun Heo <htejun@gmail.com>

Thanks.

-- 
tejun
