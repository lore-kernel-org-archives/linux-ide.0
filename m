From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] pata_cmd64x: revert commit d62f5576
Date: Tue, 17 Aug 2010 17:01:10 +0200
Message-ID: <4C6AA436.2090003@kernel.org>
References: <4C6A7CF6.5090706@kernel.org> <201008171456.43648.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43902 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab0HQPEq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Aug 2010 11:04:46 -0400
In-Reply-To: <201008171456.43648.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "\"linux-ide@vger.kernel.org\" st" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Milan Kocian <milan.kocian@wq.cz>

Hello,

On 08/17/2010 02:56 PM, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 17 August 2010 02:13:42 pm Tejun Heo wrote:
>> Commit d62f5576 (pata_cmd64x: fix handling of address setup timings)
>> incorrectly called ata_timing_compute() on UDMA mode on 0 @UT leading
>> to devide by zero fault.  Revert it until better fix is available.
>> This is reported in bko#16607 by Milan Kocian who also root caused it.
>>
>>   https://bugzilla.kernel.org/show_bug.cgi?id=16607
> 
> How's about giving the ATA maintainer some time to resolve the issue
> properly?

Yeap, sure.

> The revert should be a last resort action (+ the issue was reported
> only yesterday) as it introduces another regression (it just replaces
> new bug with the old bug while adding noise in the process)..

The old problem is much less severe tho.  The introduced regression
causes oops while the old bug probably doesn't show itself too often.
Does it really need to merge the DMA timings too?  If the device can't
do certain timing, it's PIO configuration should reflect that so
merging PIO part only should be enough for PIO configuration, no?

Thanks.

-- 
tejun
