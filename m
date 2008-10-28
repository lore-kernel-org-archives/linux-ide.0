From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 4/4] libata: perform port detach in EH
Date: Tue, 28 Oct 2008 00:02:01 -0400
Message-ID: <49068EB9.8040203@garzik.org>
References: <49041323.9020309@kernel.org> <4904135B.4040901@kernel.org> <4904138E.7010905@kernel.org> <490413B9.5030602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47149 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbYJ1ECF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Oct 2008 00:02:05 -0400
In-Reply-To: <490413B9.5030602@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> ata_port_detach() first made sure EH saw ATA_PFLAG_UNLOADING and then
> assumed EH context belongs to it and performed detach operation
> itself.  However, UNLOADING doesn't disable all of EH and this could
> lead to problems including triggering WARN_ON()'s in EH path.
> 
> This patch makes port detach behave more like other EH actions such
> that ata_port_detach() requests EH to detach and waits for completion.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/libata-core.c |   23 ++++-------------------
>  drivers/ata/libata-eh.c   |   32 +++++++++++++++++++++++++++++++-
>  include/linux/libata.h    |    3 ++-
>  3 files changed, 37 insertions(+), 21 deletions(-)

dropped patches 3-4 as well, due to dropping patch #2


