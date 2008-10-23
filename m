From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: transfer EHI control flags to
 slave ehc.i
Date: Wed, 22 Oct 2008 20:40:49 -0400
Message-ID: <48FFC811.5070108@garzik.org>
References: <48FD680F.3090206@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50715 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbYJWAkw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 20:40:52 -0400
In-Reply-To: <48FD680F.3090206@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> ATA_EHI_NO_AUTOPSY and ATA_EHI_QUIET are used to control the behavior
> of EH.  As only the master link is visible outside EH, these flags are
> set only for the master link although they should also apply to the
> slave link, which causes spurious EH messages during probe and
> suspend/resume.
> 
> This patch transfers those two flags to slave ehc.i before performing
> slave autopsy and reporting.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/libata-eh.c |    5 +++++
>  include/linux/libata.h  |    3 +++
>  2 files changed, 8 insertions(+)

applied


