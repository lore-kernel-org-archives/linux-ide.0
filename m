From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: [PATCHSET block#for-2.6.36-post] block: replace barrier with
 sequenced flush
Date: Fri, 20 Aug 2010 12:02:49 -0400
Message-ID: <4C6EA729.7030308__43818.4770559475$1282320193$gmane$org@redhat.com>
References: <1281616891-5691-1-git-send-email-tj@kernel.org> <20100820132214.GA6184@lst.de> <4C6E9CAF.5010202@redhat.com> <20100820160009.GI5854@think>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10069 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046Ab0HTQCx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Aug 2010 12:02:53 -0400
In-Reply-To: <20100820160009.GI5854@think>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Mason <chris.mason@oracle.com>, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, jaxboe@fusionio.com, linux-fsdevel@vger.kernel.org, linux-scsi@vger.kernel.orglinux-

On 08/20/2010 12:00 PM, Chris Mason wrote:
> On Fri, Aug 20, 2010 at 11:18:07AM -0400, Ric Wheeler wrote:
>> On 08/20/2010 09:22 AM, Christoph Hellwig wrote:
>>> FYI: here's a little writeup to document the new cache flushing scheme,
>>> intended to replace Documentation/block/barriers.txt.  Any good
>>> suggestion for a filename in the kernel tree?
>>>
>>> ---
>>
>> I was thinking that we might be better off using the "durable
>> writes" term more since it is well documented (at least in the
>> database world, where it is the "D" in ACID properties).  Maybe
>> "durable_writes_support.txt" ?
>
> sata_lies.txt?
>
> Ok, maybe writeback_cache.txt?
>
> -chris

writeback_cache.txt is certainly the least confusing :)

ric

