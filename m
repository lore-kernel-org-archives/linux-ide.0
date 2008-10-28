From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: clear saved xfer_mode and ncq_enabled
 on device detach
Date: Mon, 27 Oct 2008 23:58:12 -0400
Message-ID: <49068DD4.3020800@garzik.org>
References: <49041177.40008@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54380 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073AbYJ1D6P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 23:58:15 -0400
In-Reply-To: <49041177.40008@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> libata EH saves xfer_mode and ncq_enabled at start to later set
> DUBIOUS_XFER flag if it has changed.  These values need to be cleared
> on device detach such that hot device swap doesn't accidentally miss
> DUBIOUS_XFER.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/libata-eh.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

applied


