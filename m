From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH/RFC] libata: turn on the ATAPI DMA DIR support per word
 62
Date: Fri, 07 Apr 2006 02:47:33 -0400
Message-ID: <44360B05.6050509@garzik.org>
References: <CF6023AC-C62F-4BA8-A1DA-5CF6100B9608@verizon.net> <44360922.8050801@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47559 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932318AbWDGGri (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 02:47:38 -0400
In-Reply-To: <44360922.8050801@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: linux-ide@vger.kernel.org, Jonathan Benson <airbatica@verizon.net>, Tejun Heo <htejun@gmail.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Turn on the ATAPI DMA DIR support if word 62 indicates it.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> ATAPI DMA DIR follow-up patch to turn on the DMA_DIR support automatically
> by checking identify device word 62. (Thanks for Jeff and Tejun's pointer.)
> 
> According to Jonathan's test result, SiI 3611 (the current known bridge that
> requires the ATAPI DMA DIR support) doesn't implement word 62. So, the
> atapi_dmadir parameter is preserved to enable the DMA DIR support manually as
> work around.

Two comments:

* I would like to find a device that's compliant with the spec, and test 
the patch, before committing.

* DMADIR not only includes a bit flag indicating its presence, it also 
moves all the DMA capability bits from their standard places.  You'll 
have to audit every place that reads dev->id[]'s mwdma/udma masks and 
make sure they look at the DMADIR-special-case location, when DMADIR is set.

	Jeff



