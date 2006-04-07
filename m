From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH/RFC] libata: turn on the ATAPI DMADIR support per word
 62 (revised)
Date: Fri, 07 Apr 2006 13:54:56 -0400
Message-ID: <4436A770.70107@garzik.org>
References: <CF6023AC-C62F-4BA8-A1DA-5CF6100B9608@verizon.net> <44360922.8050801@tw.ibm.com> <44360B05.6050509@garzik.org> <44363D2E.7010700@tw.ibm.com> <4436431C.8070800@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38617 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964831AbWDGRzA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 13:55:00 -0400
In-Reply-To: <4436431C.8070800@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: linux-ide@vger.kernel.org, Jonathan Benson <airbatica@verizon.net>, Tejun Heo <htejun@gmail.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Turn on the ATAPI DMADIR support if word 62 indicates it.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> (Revised to add mwdma/udma mask of word 62 per Jeff's comments.
> Need more testing once I get the SiI 3811, etc.)
> 
> ATAPI DMADIR follow-up patch to turn on the DMADIR support automatically
> by checking identify device word 62. (Thanks for Jeff and Tejun's pointer.)
> 
> According to Jonathan's test result, SiI 3611 (the current known bridge that
> requires the ATAPI DMADIR support) doesn't implement word 62. So, the
> atapi_dmadir parameter is preserved to enable the DMA DIR support manually as
> work around.
> 
> Patch against upstream (c2a6585296009379e0f4eff39cdcb108b457ebf2).
> For your review, thanks.

I ACK the patch, though like I said, I would like to see this tested 
first with some compliant devices.

	Jeff



