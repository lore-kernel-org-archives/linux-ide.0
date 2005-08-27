From: Tyler <pml@dtbb.net>
Subject: Re: [PATCH] siimage docs urls
Date: Fri, 26 Aug 2005 17:18:28 -0700
Message-ID: <430FB154.2040402@dtbb.net>
References: <20050826234426.GA2802@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tor.primus.ca ([216.254.136.21]:33499 "EHLO
	smtp-03.primus.ca") by vger.kernel.org with ESMTP id S965174AbVH0AUm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Aug 2005 20:20:42 -0400
In-Reply-To: <20050826234426.GA2802@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Jeff, the files linked to in the patch, are those under NDA only? or are 
there additional documents available, only under NDA?

Thanks,
Tyler.

Jeff Garzik wrote:

>Signed-off-by: Jeff Garzik <jgarzik@pobox.com>
>
>diff --git a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
>--- a/drivers/ide/pci/siimage.c
>+++ b/drivers/ide/pci/siimage.c
>@@ -6,7 +6,13 @@
>  *
>  *  May be copied or modified under the terms of the GNU General Public License
>  *
>- *  Documentation available under NDA only
>+ *  Documentation for CMD680:
>+ *  http://gkernel.sourceforge.net/specs/sii/sii-0680a-v1.31.pdf.bz2
>+ *
>+ *  Documentation for SiI 3112:
>+ *  http://gkernel.sourceforge.net/specs/sii/3112A_SiI-DS-0095-B2.pdf.bz2
>+ *
>+ *  Errata and other documentation only available under NDA.
>  *
>  *
>  *  FAQ Items:
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>


-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.344 / Virus Database: 267.10.16/83 - Release Date: 8/26/2005

