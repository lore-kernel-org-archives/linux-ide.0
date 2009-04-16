From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: use ATA_ID_CFA_*
Date: Thu, 16 Apr 2009 15:23:19 -0400
Message-ID: <49E785A7.2060807@pobox.com>
References: <200904132050.00352.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37878 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758338AbZDPTXW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Apr 2009 15:23:22 -0400
In-Reply-To: <200904132050.00352.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Use ATA_ID_CFA_* constants for CFA specific identify data words 162 and 163.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> Resending now (when it's too late already :-)...
> This patch is against the recent Linus' tree.
> 
>  drivers/ata/libata-core.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

applied


