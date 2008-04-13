From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream 1/2] libata: kill dead code paths in reset path
Date: Sun, 13 Apr 2008 12:27:14 -0400
Message-ID: <48023462.1050305@rtr.ca>
References: <47FA4AFF.2010209@gmail.com> <48003C04.4040508@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1689 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680AbYDMQ1P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Apr 2008 12:27:15 -0400
In-Reply-To: <48003C04.4040508@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Some code paths which had been made obsolete by recent reset
>> simplification were still around.  Kill them.
>>
>> * ata_eh_reset() checked for ATA_DEV_UNKNOWN to determine
>>  classification failure.  This is no longer applicable.
>>
>> * ata_do_reset() should convert ATA_DEV_UNKNOWN to ATA_DEV_NONE
>>  regardless of reset result (e.g. -EAGAIN).
>>
>> * LLDs don't need to convert ATA_DEV_UNKNOWN to ATA_DEV_NONE.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>> drivers/ata/libata-eh.c     |   19 +------------------
>> drivers/ata/sata_inic162x.c |    2 --
>> drivers/ata/sata_sil24.c    |    3 ---
>> 3 files changed, 1 insertion(+), 23 deletions(-)
> 
> applied 1-2
> 
> Mark, let us know how we stand WRT sata_mv PMP needs, this should help.
..

I plan to spend Monday updating the sata_mv PMP support over
to the newly restructured libata helpers from Tejun, so we'll
know for sure at that time.  Should be good, though.

There's also an existing reworked mv_hardreset patch to go into #upstream.
Did you catch that one?  ("[PATCH] sata_mv rework hardreset sequence")

If all goes well, the re-spun PMP support for sata_mv should
appear here as patches by Tuesday or so.

After that, the IRQ/EH rework will follow,
and then various errata fixes as I get to them.

There's a small chance that ATAPI support may also make
the merge window, but I'm not holding my breath on that one.

Jens is currently poking at rudimentary target mode
support for sata_mv, but it still has quite a ways to go.

Cheers
