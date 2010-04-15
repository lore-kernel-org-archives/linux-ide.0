From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] Fix accesses at LBA28 boundary (old bug, but nasty) (v2)
Date: Thu, 15 Apr 2010 09:46:15 -0400
Message-ID: <4BC718A7.7070006@teksavvy.com>
References: <4BBBB975.7000203@teksavvy.com> <4BBCC648.30807@teksavvy.com> <4BBE0B96.6070007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:57152 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753457Ab0DONqS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Apr 2010 09:46:18 -0400
In-Reply-To: <4BBE0B96.6070007@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On 08/04/10 01:00 PM, Jeff Garzik wrote:
> On 04/07/2010 01:52 PM, Mark Lord wrote:
>> Most drives from Seagate, Hitachi, and possibly other brands,
>> do not allow LBA28 access to sector number 0x0fffffff (2^28 - 1).
>> So instead use LBA48 for such accesses.
>>
>> This bug could bite a lot of systems, especially when the user has
>> taken care to align partitions to 4KB boundaries. On misaligned systems,
>> it is less likely to be encountered, since a 4KB read would end at
>> 0x10000000 rather than at 0x0fffffff.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>> ---
>>
>> Reposting with the pre-existing (u64) cast removed.
>>
>> --- linux-2.6.34-rc3/include/linux/ata.h 2010-03-30 12:24:39.000000000
>> -0400
>> +++ linux/include/linux/ata.h 2010-04-06 18:39:41.167702612 -0400
>> @@ -1025,8 +1025,8 @@
>>
>> static inline int lba_28_ok(u64 block, u32 n_block)
>> {
>> - /* check the ending block number */
>> - return ((block + n_block) < ((u64)1 << 28)) && (n_block <= 256);
>> + /* check the ending block number: must be LESS THAN 0x0fffffff */
>> + return ((block + n_block) < ((1 << 28) - 1)) && (n_block <= 256);
>> }
>
> applied.
>
> Neither 'git am' nor patch(1) would apply the patch for some reason, so
> I applied it manually. Weird... I could not spot obvious whitespace or
> word-wrap corruption.
..

I figured this this out (paritially) today:
Somehow, the (v2) repost ended up with MS-DOS line separators (CR-LF).

I imagine those would confuse most of the tools,
yet remain transparent (hidden) in editors and email programs.

Dunno how they got in there, though.

Cheers
  
