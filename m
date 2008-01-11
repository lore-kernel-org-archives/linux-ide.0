From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] ata_piix: ignore ATA_DMA_ERR on vmware
 ich4
Date: Fri, 11 Jan 2008 10:00:48 +0900
Message-ID: <4786BFC0.3010704@gmail.com>
References: <4782013D.7010304@gmail.com> <47869313.7060306@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:6826 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203AbYAKCWq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 21:22:46 -0500
Received: by rv-out-0910.google.com with SMTP id k20so775503rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 10 Jan 2008 18:22:45 -0800 (PST)
In-Reply-To: <47869313.7060306@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> VMware ich4 emulation incorrectly sets DMA_ERR on TF error.  Ignore
>> it.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> hrm.  IIRC, the old-IDE code just sorta ignores this, and in the
> original libata I followed old-IDE's habit of acking events with
> 
>     write-to-dma-status-register(err | intr)
> 
> so what part of libata-core cares about this distinction?  what is the
> specific behavior from the original problem report that this solves?

Well, basically, some versions of vmware sets DMA_ERR on CHECK_SENSE, so
cdroms get reset when they try to report sense data.

Thanks.

-- 
tejun

