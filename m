From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/2] sata_nv: fix ATAPI issues with memory over 4GB (v3)
Date: Thu, 15 Nov 2007 13:11:42 +0900
Message-ID: <473BC6FE.8090700@gmail.com>
References: <473A7677.6080007@shaw.ca> <473BA332.9030406@gmail.com> <473BC5DF.1040302@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:62532 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbXKOELw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 23:11:52 -0500
Received: by wa-out-1112.google.com with SMTP id v27so486993wah
        for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 20:11:52 -0800 (PST)
In-Reply-To: <473BC5DF.1040302@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Robert Hancock wrote:
> Tejun Heo wrote:
>> Robert Hancock wrote:
>>> This fixes some problems with ATAPI devices on nForce4 controllers in
>>> ADMA mode
>>> on systems with memory located above 4GB. We need to delay setting
>>> the 64-bit
>>> DMA mask until the PRD table and padding buffer are allocated so that
>>> they don't
>>> get allocated above 4GB and break legacy mode (which is needed for ATAPI
>>> devices).
>>>
>>> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
>>
>> applied to #tj-upstream-fixes.
>>
> 
> I have a report that these patches crashed but the previous patch worked:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=351451
> 
> So there may still be a problem here.

Hmmm... The change seemed safe to me.  Anyways, dropping the patch for
now.  Please re-send later.  Also, please format patch description such
that it fits in 80c.

Thanks.

-- 
tejun
