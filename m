From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: initialize port_task when !CONFIG_ATA_SFF
Date: Wed, 22 Oct 2008 20:40:31 -0400
Message-ID: <48FFC7FF.10108@garzik.org>
References: <48FC050C.3000207@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50698 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbYJWAkf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 20:40:35 -0400
In-Reply-To: <48FC050C.3000207@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org, Larry Finger <Larry.Finger@lwfinger.net>

Tejun Heo wrote:
> Subject: libata: initialize port_task when !CONFIG_ATA_SFF
> 
> ap->port_task was not initialized if !CONFIG_ATA_SFF later triggering
> lockdep warning.  Make sure it's initialized.
> 
> Reported by Larry Finger.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> ---
>  drivers/ata/libata-core.c |    2 ++
>  1 file changed, 2 insertions(+)

applied


