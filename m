From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: ahci_brcm: Avoid clobbering SATA_TOP_CTRL_BUS_CTRL
Date: Tue, 2 Jan 2018 08:38:43 -0800
Message-ID: <20180102163843.GG3668920@devbig577.frc2.facebook.com>
References: <20171222194331.6330-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:33572 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeABQir (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2018 11:38:47 -0500
Content-Disposition: inline
In-Reply-To: <20171222194331.6330-1-f.fainelli@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-ide@vger.kernel.org

On Fri, Dec 22, 2017 at 11:43:08AM -0800, Florian Fainelli wrote:
> We are doing a blind write to SATA_TOP_CTRL_BUS_CTRL to set the system
> endian, but in doing so, we are also overwriting other bits, such as the
> SATA_SCB_BURST_SIZE and SATA_FIFO_SIZE bits, which impact performance.
> Do a read/modify/write so we keep the default values.
> 
> While we are at it, we also greatly simplify the logic and just leave
> the NSP specific bit settings, instead of having a completely different
> sequence.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to libata/for-4.16.

Thanks.

-- 
tejun
