From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-pmp: clear hob for pmp register accesses
Date: Sun, 24 Feb 2008 00:29:50 -0500
Message-ID: <47C100CE.9000009@garzik.org>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BCF28F.5080702@gmail.com> <47BD93BC.3080301@pobox.com> <47BDE489.6070701@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36104 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759184AbYBXF3w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Feb 2008 00:29:52 -0500
In-Reply-To: <47BDE489.6070701@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

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
> ---
> drivers/ata/libata-pmp.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied


