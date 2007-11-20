From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM
Date: Tue, 20 Nov 2007 10:03:01 +0900
Message-ID: <47423245.1050109@gmail.com>
References: <198606.73895.qm@web52608.mail.re2.yahoo.com> <200711141317.35746.ak@suse.de> <alpine.LFD.0.9999.0711141633400.3265@localhost.localdomain> <200711141746.26793.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:32118 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbXKTBDJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 20:03:09 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1588431rvb
        for <linux-ide@vger.kernel.org>; Mon, 19 Nov 2007 17:03:08 -0800 (PST)
In-Reply-To: <200711141746.26793.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org

Andi Kleen wrote:
>  
>> The AHCI code falls back to 32bit DMA in that case. Which in turn
>> causes the problem seen by Srihari. There is not much printk sticking
>> necessary, the code is simply not handling this. 
> 
> What code is not handling what? 
> 
> IOMMU merging should be always safe. If it is not the driver should
> not submit things in a single SG list.

Yeap, a sg merged by IOMMU should be safe.  It's just another contiguous
memory area from the POV of the controller anyway.  I wonder what went
wrong here.  What has exactly changed with iommu_merge patch?

-- 
tejun
