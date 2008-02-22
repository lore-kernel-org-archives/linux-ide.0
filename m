From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-pmp: clear hob for pmp register accesses
Date: Fri, 22 Feb 2008 10:40:41 +0900
Message-ID: <47BE2819.90601@gmail.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BCF28F.5080702@gmail.com> <47BD93BC.3080301@pobox.com> <47BDE489.6070701@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:42856 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760140AbYBVBku (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Feb 2008 20:40:50 -0500
Received: by nf-out-0910.google.com with SMTP id g13so163500nfb.21
        for <linux-ide@vger.kernel.org>; Thu, 21 Feb 2008 17:40:48 -0800 (PST)
In-Reply-To: <47BDE489.6070701@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Mark Lord wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>>> Hello, Mark.
>>>
>>> Mark Lord wrote:
>>>> Tejun, I've added PMP to sata_mv, and am now trying to get it
>>>> to work with a Marvell PM attached.
>>>>
>>>> And the behaviour I see is very bizarre.
>>>>
>>>> After hard+soft resets, the PM signature is found,
>>>> and libata interrogates the PM registers.
>>>>
>>>> It successfully reads register 0, and then register 1.
>>>> But all subsequent registers read out (incorrectly) as zeros.
> ..
> 
> Saeed has confirmed this behaviour with a SATA analyzer.
> The Marvell port-multiplier apparently likes to see clean HOB
> information when accessing PMP registers.
> 
> Since sata_mv uses PIO shadow register access, this doesn't happen
> automatically, as it might in a more purely FIS-based driver (eg. ahci).
> 
> One way to fix this is to flag these commands with ATA_TFLAG_LBA48,
> forcing libata to write out the HOB fields with known (zero) values.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> Acked-by: Mark Lord <mlord@pobox.com>

Acked-by: Tejun Heo <htejun@gmail.com>

I think this is correct w/ or w/o the mv problem.

-- 
tejun
