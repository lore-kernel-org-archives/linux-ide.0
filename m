From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates
Date: Wed, 04 Aug 2010 14:46:14 -0400
Message-ID: <4C59B576.4090807@garzik.org>
References: <20100804015530.GA8136@havoc.gtf.org> <AANLkTik-68XiTq3VC6ta3-YVL8r=FpwFErAx8nVV4CJ4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41924 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab0HDSqv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Aug 2010 14:46:51 -0400
In-Reply-To: <AANLkTik-68XiTq3VC6ta3-YVL8r=FpwFErAx8nVV4CJ4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 08/04/2010 02:32 PM, Linus Torvalds wrote:
> On Tue, Aug 3, 2010 at 6:55 PM, Jeff Garzik<jeff@garzik.org>  wrote:
>>
>> Tejun Heo (4):
>>       ata_generic: drop hard coded DMA force logic for CENATEK
>>       ata_piix: fix locking around SIDPR access
>>       libata: more PCI IDs for jmicron controllers
>>       sata_fsl,mv,nv: prepare for NCQ command completion update
>
> Hmm. Aren't these the ones that you said causes "sata_mv is behaving
> weirdly"? I think I'll wait for you to do another pull request when
> that is sorted out..

"prepare for..." is patch #1 of 2.  With #2, sata_mv starts behaving 
strangely.  #1 seems to be working here.

	Jeff


