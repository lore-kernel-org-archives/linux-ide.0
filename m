From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata-eh: fix slave link EH action mask
 handling
Date: Tue, 21 Oct 2008 14:12:35 +0900
Message-ID: <48FD64C3.8020103@kernel.org>
References: <48FD5EE0.9040407@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53091 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbYJUFOl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2008 01:14:41 -0400
In-Reply-To: <48FD5EE0.9040407@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Tejun Heo wrote:
> Slave link action mask is transferred to masater link and all the EH
> actions are taken by the master link.  ata_eh_about_to_do() and
> ata_eh_done() are called with ATA_EH_ALL_ACTIONS to clear the slave
> link actions during transfer.  This always sets ATA_PFLAG_RECOVERED
> flag causing spurious "EH complete" messages.
> 
> Don't set ATA_PFLAG_RECOVERED for slave link actions.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Oops, slave link is not included in 2.6.27, so this fix doesn't need to
go into -stable.  Stable team, please ignore this patch.  Sorry about
the noise.

Thanks.

-- 
tejun
