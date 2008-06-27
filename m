From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_uli: hardreset is broken
Date: Fri, 27 Jun 2008 03:00:35 -0400
Message-ID: <48649013.7030008@garzik.org>
References: <485CA8B4.7040609@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50824 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932077AbYF0HAi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jun 2008 03:00:38 -0400
In-Reply-To: <485CA8B4.7040609@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, casteyde.christian@free.fr

Tejun Heo wrote:
> sata_uli can't do hardresets reliably and lock up.  This went
> unnoticed till now as softreset was the default and hardreset was only
> used after softreset failed.
> 
> Reported by Christian Casteyde in bz#10860.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Christian Casteyde <casteyde.christian@free.fr>
> ---
>  drivers/ata/sata_uli.c |    1 +
>  1 file changed, 1 insertion(+)

applied


