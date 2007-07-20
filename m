From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-git13] libata: add ST9160821AS 3.CLF to NONCQ blacklist
Date: Fri, 20 Jul 2007 07:47:07 -0400
Message-ID: <46A0A0BB.50801@garzik.org>
References: <46A030D2.1070800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49761 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761136AbXGTLrJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 07:47:09 -0400
In-Reply-To: <46A030D2.1070800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, sam@freed.net

Tejun Heo wrote:
> Yay, the first one from Seagate.  3.ALC firmware is okay.  This was
> reported by Sam Freed on bugzilla bug 8759.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Sam Freed <sam@freed.net>
> ---
>  drivers/ata/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)

applied


