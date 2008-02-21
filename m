From: Mark Lord <mlord@pobox.com>
Subject: Re: What's needed for PMP support?
Date: Thu, 21 Feb 2008 10:07:40 -0500
Message-ID: <47BD93BC.3080301@pobox.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com>
 <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com>
 <47BC798F.6070900@pobox.com> <47BCF28F.5080702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rune.pobox.com ([208.210.124.79]:45054 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbYBUPMd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Feb 2008 10:12:33 -0500
In-Reply-To: <47BCF28F.5080702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello, Mark.
> 
> Mark Lord wrote:
>> Tejun, I've added PMP to sata_mv, and am now trying to get it
>> to work with a Marvell PM attached.
>>
>> And the behaviour I see is very bizarre.
>>
>> After hard+soft resets, the PM signature is found,
>> and libata interrogates the PM registers.
>>
>> It successfully reads register 0, and then register 1.
>> But all subsequent registers read out (incorrectly) as zeros.
> 
> Hmmm...
> 
>> I've traced the taskfiles in/out, and it all looks proper
>> except for the actual data coming back from the PM.
>>
>> After some experimentation, I found that all of the PM registers
>> were readable, if I simple inserted a  sata_pmp_read(link, 0, &junk)
>> in front of each issue of sata_pmp_read(link, reg, &r_val).
> 
> Hmmmmmmm...
> 
>> Then the PM is recognized and all, but fails port enumerations
>> probably due to either my hack or the same original bug (whatever that is?)
>>
>> I'm confused.
> 
> That makes two of us.
> 
>> The PM itself works fine here on sata_sil24 and AHCI(jmicron),
..

Well, last night I found someone else to try the code
with a 0x1095:0x3726 (vendor/device?) Port-Multiplier.
It *appears* to work fine with sata_mv, unlike the Marvell one.
Hopefully the nice folks at Marvell will take a look (I've emailed them)
and report back with some useful information eventually.

> No but I had my fair share of problems doing PMP support for both sil24
> and ahci.  Any chance you can get access to a bus analyzer?  I had a
> very weird problem w/ ahci PMP support which I don't think I could fix
> if I didn't have access to a bus analyzer at the time.  (I don't
> remember details now tho.)
..

I figure they must have a few of those kicking around at Marvell..

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
