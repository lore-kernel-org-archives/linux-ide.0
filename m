From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata_rcar: clear STOP bit in bmdma_start() method
Date: Wed, 22 May 2013 17:12:48 +0400
Message-ID: <519CC450.6030203@cogentembedded.com>
References: <201305212307.55385.sergei.shtylyov@cogentembedded.com> <20130521234128.GD6985@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:53657 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320Ab3EVNMp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 May 2013 09:12:45 -0400
Received: by mail-lb0-f177.google.com with SMTP id o10so2028338lbi.22
        for <linux-ide@vger.kernel.org>; Wed, 22 May 2013 06:12:44 -0700 (PDT)
In-Reply-To: <20130521234128.GD6985@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

Hello.

On 22-05-2013 3:41, Tejun Heo wrote:

>> Iff bmdma_setup() has to stop a DMA transfer before starting a new one, then the
>> STOP bit in the ATAPI_CONTROL1 register will remain set (it's only cleared when
>> setting the START bit to 1) and then bmdma_start() method will set both START
>> and STOP bits simultaneously which should abort the transfer being just started.
>> Avoid that by explicitly clearing the STOP bit in bmdma_start() method (in this
>> case it will be ignored on write).

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Applied to libata/for-3.10-fixes w/ stable cc'd.

    Thanks, I forgot about -stable. Anyway, it doesn't seem that serious 
as bmdma_setup() usually shouldn't abort DMA.

> Thanks.

WBR, Sergei

