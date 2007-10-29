From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add MAXTOR 7V300F0/VA111900 to NCQ blacklist
Date: Mon, 29 Oct 2007 06:22:30 -0400
Message-ID: <4725B466.2030408@garzik.org>
References: <20071029085744.GQ11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50440 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbXJ2KWc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Oct 2007 06:22:32 -0400
In-Reply-To: <20071029085744.GQ11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, c-otto@gmx.de

Tejun Heo wrote:
> MAXTOR 7V300F0/VA111900 does spurious NCQ completions.  Add it to
> blacklist.  This problem is reported by Carsten Otto.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Carsten Otto <c-otto@gmx.de>
> ---
>  drivers/ata/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)

applied


