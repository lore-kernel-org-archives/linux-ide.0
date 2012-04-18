From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata fixes
Date: Wed, 18 Apr 2012 15:45:48 -0400
Message-ID: <4F8F19EC.8000305@garzik.org>
References: <20120418184624.GA16313@havoc.gtf.org> <CA+5PVA7zv2H-CQU3Grouk3KH5xA3XLijuO7TPX9zrMdj-7z43Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:42870 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab2DRTpv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2012 15:45:51 -0400
In-Reply-To: <CA+5PVA7zv2H-CQU3Grouk3KH5xA3XLijuO7TPX9zrMdj-7z43Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Josh Boyer <jwboyer@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, stable <stable@kernel.org>

On 04/18/2012 03:34 PM, Josh Boyer wrote:
> On Wed, Apr 18, 2012 at 2:46 PM, Jeff Garzik<jeff@garzik.org>  wrote:
>>
>> NOTE: Includes important regression fix.  See signed tag message for more.
>>
>> Please pull 0c8d32c27f5cf6e14ca14b4758d1e994eebd50fd from
>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git tag/upstream-linus
>>
>>
>> to receive the following updates:
>>
>>   drivers/ata/ata_piix.c         |    2 ++
>>   drivers/ata/libata-core.c      |    4 ++--
>>   drivers/ata/libata-scsi.c      |    4 ++--
>>   drivers/ata/libata-transport.c |    1 +
>>   drivers/ata/libata.h           |    2 +-
>>   drivers/ata/sata_mv.c          |    3 ++-
>>   6 files changed, 10 insertions(+), 6 deletions(-)
>>
>> Dan Carpenter (1):
>>       sata_mv: silence an uninitialized variable warning
>>
>> Dan Williams (1):
>>       libata: make ata_print_id atomic
>>
>> Lin Ming (1):
>>       libata: forbid port runtime pm by default, fixing regression
>
> I noticed that this regression fix doesn't have the
> CC: stable@vger.kernel.org tag in it, but it's needed on the 3.3
> trees.  Should it be sent to the stable list separately?


Good catch.

Stable folks, commit 0c8d32c27f5cf6e14ca14b4758d1e994eebd50fd should be 
merged into the 3.3 tree(s).

	Jeff



