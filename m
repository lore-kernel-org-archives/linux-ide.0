From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Wed, 10 Mar 2010 09:11:03 +0900
Message-ID: <4B96E397.1040005@kernel.org>
References: <4B947393.2050002@kernel.org> <alpine.DEB.1.10.1003090733330.9819@uplift.swm.pp.se> <4B961D8F.3010500@ziu.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40203 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629Ab0CJAMa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Mar 2010 19:12:30 -0500
In-Reply-To: <4B961D8F.3010500@ziu.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Soltys <soltys@ziu.info>
Cc: Mikael Abrahamsson <swmike@swm.pp.se>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

Hello,

On 03/09/2010 07:06 PM, Michal Soltys wrote:
> Mikael Abrahamsson wrote:
>> On Mon, 8 Mar 2010, Tejun Heo wrote:
>>
>>>  http://ata.wiki.kernel.org/index.php/ATA_4_KiB_sector_issues
>>
>> Excellent summary.
>>
>>> C-2. Windows XP depends on the traditional partition layout.
>>
>> Is this really true? WD ships their EARS drives with an alignment tool
>> that as far as I can understand, moves the partition so
>> it's aligned to 4KiB:

Hmmm... I based that claim on the MS KB page and as you pointed out
the problem there could probably be issues with specific BIOS
implementation interacting badly.  I'll update the doc.

> XP SP2 (or later) can boot from any place, including logical partitions
> (tested that recently). Most important thing is "hidden sectors" (recent
> chain.c32 can set that automatically through ntldr and/or sethidden
> options). No idea about pre-SP2 ; Win 2000 will not boot from
> "misaligned" (with reference to cylinder boundary) partition.

I was thinking about testing XP booting this weekend but really want
to avoid it, so thanks a lot for the info.  I'll update the doc
accordingly but can you please enlighten me on how it works and what's
broken in detail?  So, XP should be fine with any alignment?

Thanks.

-- 
tejun
