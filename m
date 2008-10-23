From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes, UDPATED] libata-eh: fix slave link EH
 action mask handling
Date: Wed, 22 Oct 2008 20:40:57 -0400
Message-ID: <48FFC819.9030203@garzik.org>
References: <48FD5EE0.9040407@kernel.org> <48FDB324.1050701@ru.mvista.com> <48FDBEF1.40508@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50724 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999AbYJWAlE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 20:41:04 -0400
In-Reply-To: <48FDBEF1.40508@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Tejun Heo wrote:
> Slave link action mask is transferred to master link and all the EH
> actions are taken by the master link.  ata_eh_about_to_do() and
> ata_eh_done() are called with ATA_EH_ALL_ACTIONS to clear the slave
> link actions during transfer.  This always sets ATA_PFLAG_RECOVERED
> flag causing spurious "EH complete" messages.
> 
> Don't set ATA_PFLAG_RECOVERED for slave link actions.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Thanks.  Commit message updated.
> 
>  drivers/ata/libata-eh.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

applied


