From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: force CAP_NCQ for earlier NV MCPs
Date: Mon, 13 Apr 2009 04:27:38 -0400
Message-ID: <49E2F77A.5020502@garzik.org>
References: <49DD164B.6000809@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51184 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135AbZDMI1m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 04:27:42 -0400
In-Reply-To: <49DD164B.6000809@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>, zaceni2@yandex.ru

Tejun Heo wrote:
> Along with MCP65, MCP67 and 73 also don't set CAP_NCQ.  Force it.
> Reported by zaceni@yandex.ru on bko#13014 and confirmed by Peer Chen.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: NightFox <zaceni2@yandex.ru>
> Cc: Peer Chen <pchen@nvidia.com>
> ---
>  drivers/ata/ahci.c |   57 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 24 deletions(-)
> 
>  drivers/ata/ahci.c |   57 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 24 deletions(-)

applied



