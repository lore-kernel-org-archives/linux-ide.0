From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/4] libata: skip debounce delay on link resume
Date: Fri, 8 Jan 2016 11:50:43 -0500
Message-ID: <20160108165043.GT1898@mtj.duckdns.org>
References: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
 <1452211413-1350-5-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34864 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcAHQup (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jan 2016 11:50:45 -0500
Content-Disposition: inline
In-Reply-To: <1452211413-1350-5-git-send-email-f.fainelli@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, Danesh Petigara <dpetigara@broadcom.com>

On Thu, Jan 07, 2016 at 04:03:33PM -0800, Florian Fainelli wrote:
> From: Danesh Petigara <dpetigara@broadcom.com>
> 
> The link resume logic uses a 200msec delay while debouncing
> the SControl register. The rationale behind that delay is
> to accommodate some PHYs that behave badly if their SStatus/
> SControl registers are pounded immediately on resume.
> The Broadcom STB SATA PHY does not seem to have this issue.
> This patch introduces a new link flag that allows platforms
> to skip the debounce delay if it isn't needed.
> 
> Signed-off-by: Danesh Petigara <dpetigara@broadcom.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to libata/for-4.5.

Thanks.

-- 
tejun
