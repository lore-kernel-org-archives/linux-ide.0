From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH 1/3] libata-dev: Convert pdc2027x from PIO to MMIO
Date: Thu, 04 Aug 2005 15:40:15 -0400
Message-ID: <42F26F1F.8010903@emc.com>
References: <42F24DBE.0@tw.ibm.com> <42F25114.1050009@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.lss.emc.com ([168.159.2.31]:59703 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S262629AbVHDTj0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Aug 2005 15:39:26 -0400
In-Reply-To: <42F25114.1050009@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> +	cgcr = readl(port_mmio(ap, PDC_GLOBAL_CTL));

I've read that read[bwl]() and write[bwl]() are deprecated and 
discouraged in new code and instead ioread{8,16,32}() and 
iowrite{8,16,32}() should be used.  Is this the case?

BR
