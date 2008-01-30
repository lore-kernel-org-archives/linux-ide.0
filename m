From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_nv: fix for completion handling
Date: Wed, 30 Jan 2008 11:28:33 +0900
Message-ID: <479FE0D1.1030607@gmail.com>
References: <479FD88F.8090605@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:10155 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbYA3C2k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 21:28:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so97990wah.23
        for <linux-ide@vger.kernel.org>; Tue, 29 Jan 2008 18:28:39 -0800 (PST)
In-Reply-To: <479FD88F.8090605@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Kuan Luo <kluo@nvidia.com>, Allen Martin <AMartin@nvidia.com>

Robert Hancock wrote:
> This patch is based on an original patch from Kuan Luo of NVIDIA,
> posted under subject "fixed a bug of adma in rhel4u5 with HDS7250SASUN500G".
> His description follows. I've reworked it a bit to avoid some unnecessary
> repeated checks but it should be functionally identical.
> 
> "The patch is to solve the error message "ata1: CPB flags CMD err,
> flags=0x11" when testing HDS7250SASUN500G in rhel4u5.
> I tested this hd in 2.6.24-rc7 which needed to remove the mask in
> blacklist to run the ncq and the same error also showed up. 
> 
> I traced the  bug and found that the interrupt finished a command (for
> example, tag=0) when the driver got that adma status is
> NV_ADMA_STAT_DONE  and  cpb->resp_flags is NV_CPB_RESP_DONE.
> However, For this hd, the drive maybe didn't clear bit 0 at this moment.
> It meaned the hardware  had not completely finished the command.
> If at the same time  the driver freed the command(tag 0) and sended
> another command (tag 0), the error happened.
> 
> The notifier register is 32-bit register containing notifier value.
> Value is bit vector containing one bit per tag number (0-31) in
> corresponding bit positions (bit 0 is for tag 0, etc). When bit is set
> then ADMA indicates that command with corresponding tag number completed
> execution.
> 
> So i added the check notifier code. Sometimes i saw that the notifier
> reg set some bits  , but the adma status set NV_ADMA_STAT_CMD_COMPLETE
> ,not NV_ADMA_STAT_DONE. So i added the NV_ADMA_STAT_CMD_COMPLETE check
> code."
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

Any chance this fixes the FLUSH problem?

-- 
tejun
