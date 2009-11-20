From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata-acpi: missing _SDD is not an error
Date: Fri, 20 Nov 2009 17:58:38 +0900
Message-ID: <4B065A3E.3040404@kernel.org>
References: <4B03F585.3090000@kernel.org> <4B0657D6.3000004@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45655 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbZKTI5R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Nov 2009 03:57:17 -0500
In-Reply-To: <4B0657D6.3000004@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>

Hello,

11/20/2009 05:48 PM, Jeff Garzik wrote:
> On 11/18/2009 08:24 AM, Tejun Heo wrote:
>> Missing _SDD is not an error.  Don't treat it as one.
>>
>> Signed-off-by: Tejun Heo<tj@kernel.org>
>> Reported-by: Takashi Iwai<tiwai@suse.de>
>> ---
>>   drivers/ata/libata-acpi.c |   15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> 
> hmmmm, do you have a link to the bug report?

Unfortunately, it's from novell internal bugzilla entry, but the
following is how it looks like without the patch.

[   15.720046] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   16.540846] ata1.00: ACPI _SDD failed (AE 0x5)
[   16.553907] ata1.00: ACPI: failed the second time, disabled
[   16.567311] ata1.00: configured for UDMA/100

> How critical is this?  Is it a regression fix?

It's not critical.  libata-acpi code will give up after a couple of
tries and just turn off ACPI and is not a regression.

> We are very late into 2.6.32-rc, where we try to minimize the patches
> applied as much as possible.

This can go into #upstream then.  No biggie.

Thanks.

-- 
tejun
