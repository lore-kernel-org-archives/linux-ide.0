From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 1/4] libata: fix EH action overwriting
 in ata_eh_reset()
Date: Fri, 22 Aug 2008 02:20:08 -0400
Message-ID: <48AE5A98.6030202@garzik.org>
References: <48916498.20703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37282 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835AbYHVGUN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 02:20:13 -0400
In-Reply-To: <48916498.20703@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> ehc->i.action got accidentally overwritten to ATA_EH_HARD/SOFTRESET in
> ata_eh_reset().  The original intention was to clear reset action
> which wasn't selected.  This can cause unexpected behavior when other
> EH actions are scheduled together with reset.  Fix it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

applied 1-4


