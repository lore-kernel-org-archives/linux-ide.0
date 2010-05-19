From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 09/23] libata-sff: clean up inheritance in several drivers
Date: Wed, 19 May 2010 13:07:53 -0400
Message-ID: <4BF41AE9.80603@garzik.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-10-git-send-email-tj@kernel.org> <4BF200D1.6030600@garzik.org> <4BF2519C.1020800@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46573 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212Ab0ESROA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2010 13:14:00 -0400
Received: by gwaa20 with SMTP id a20so1949052gwa.19
        for <linux-ide@vger.kernel.org>; Wed, 19 May 2010 10:13:59 -0700 (PDT)
In-Reply-To: <4BF2519C.1020800@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/18/2010 04:36 AM, Tejun Heo wrote:
> On 05/18/2010 04:52 AM, Jeff Garzik wrote:
>> applied, sans the sata_mv (mistakenly labelled as pata_marvell) patch
>
> Oops.
>
>> sata_mv is not standard BMDMA, unless I am confused about something?
>
> mv6 uses BMDMA for ATAPI DMA commands, so it's partially bmdma and
> it's clearer to make anything which uses BMDMA inherit from BMDMA,
> so...

I had forgotten about that, my apologies.  Can you resend patch #9 and #10?

	Jeff



