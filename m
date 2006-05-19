From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 1/1] libata: Fix the HSM error_mask mapping
Date: Fri, 19 May 2006 13:22:59 +0800
Message-ID: <446D5633.9010309@tw.ibm.com>
References: <e4b02t$e9b$1@sea.gmane.org> <44690B0F.90200@gmail.com> <e4bvsb$s9m$1@sea.gmane.org> <4469893A.10901@gmail.com> <e4g3or$jbm$1@sea.gmane.org> <446BF147.4040904@gmail.com> <446C98CA.50008@garzik.org> <446D3EC8.5070109@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:2774 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932177AbWESFXF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 01:23:05 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4J5N5gU024772
	for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 01:23:05 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4J5N4an176746
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 23:23:04 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4J5N34P016985
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 23:23:04 -0600
In-Reply-To: <446D3EC8.5070109@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, Nicolas STRANSKY <Nico@stransky.cx>, linux-ide@vger.kernel.org, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Jeff Garzik wrote:
> 
>>Tejun Heo wrote:
>>
>>
>>>It seems that HSM_ST needs to handle !DRQ && ERR case before the first
>>>iteration (or maybe it should be pushed into HSM_ST_FIRST?).  Does my
>>>analysis make sense?
>>
>>
>>Agreed, though we should check for ERR on ATAPI path first, too, IMO.
>>
> 
> 
> Fix the HSM error_mask mapping.
> 
> Changes:
> - Better mapping in ac_err_mask()
> - In HSM_ST_FIRST ans HSM_ST state, check ATA_ERR|ATA_DF and map it to AC_ERR_DEV instead of AC_ERR_HSM.
> - In HSM_ST_FIRST and HSM_ST state, map DRQ=1 ERR=1 to AC_ERR_HSM.
> - For PIO data in and DRQ=1 ERR=1, add check after the junk data block is read.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> The device might stop the HSM by BSY=0 DRQ=1 ERR=1 when it finds something wrong.

Sorry, it should be 
"The device might stop the HSM by BSY=0 DRQ=0 ERR=1 when it finds something wrong."

-- albert

> Map this condition to AC_ERR_DEV for accuracy.
> This should fix the problem of SMART reported by Nicolas.
> (patch against upstream branch.)

