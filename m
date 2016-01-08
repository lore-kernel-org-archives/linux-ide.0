From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/4] ata: ahci_brcmstb: enable support for ALPM
Date: Fri, 8 Jan 2016 11:29:15 -0500
Message-ID: <20160108162915.GQ1898@mtj.duckdns.org>
References: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
 <1452211413-1350-2-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36587 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbcAHQ3R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jan 2016 11:29:17 -0500
Content-Disposition: inline
In-Reply-To: <1452211413-1350-2-git-send-email-f.fainelli@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, Danesh Petigara <dpetigara@broadcom.com>

On Thu, Jan 07, 2016 at 04:03:30PM -0800, Florian Fainelli wrote:
> From: Danesh Petigara <dpetigara@broadcom.com>
> 
> Enable support for ALPM in the host controller's capabilities
> register. Also adjust the PLL  timeout to give it enough time
> to lock when the port exits slumber mode.

Applied to libata/for-4.5 w/ minor style adjustments.

Thanks.

-- 
tejun
