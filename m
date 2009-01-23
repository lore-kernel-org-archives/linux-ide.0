From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: SSD data reliable vs. unreliable [Was: Re: Data Recovery from
 SSDs -  Impact of trim?]
Date: Fri, 23 Jan 2009 15:40:28 -0500
Message-ID: <497A2B3C.3060603@redhat.com>
References: <87f94c370901221553p4d3a749fl4717deabba5419ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:53179 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423AbZAWUl4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jan 2009 15:41:56 -0500
In-Reply-To: <87f94c370901221553p4d3a749fl4717deabba5419ec@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@norcrossgroup.com>
Cc: Dongjun Shin <djshin90@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Greg Freemyer wrote:
> On Thu, Jan 22, 2009 at 6:40 PM, Dongjun Shin <djshin90@gmail.com> wrote:
>   
>> On Thu, Jan 22, 2009 at 12:56 AM, Greg Freemyer
>> <greg.freemyer@norcrossgroup.com> wrote:
>>     
>>> Dongjun,
>>>
>>> I just read the T13/e08137r2 draft you linked to and the powerpoint
>>> which addresses security issues caused by the 2007 proposed specs
>>> implementations.
>>>
>>> I'm very concerned not with the discarded sectors, but with the fact
>>> that I see no way to know which sectors hold valid / reliable data vs.
>>> those that have been discarded and thus hold unreliable data.
>>>
>>> The T13/e08137r2 draft It is not strong enough to address this issue
>>> in my opinion.
>>>
>>> == Details
>>>
>>> As I understand it there is no way for a OS / kernel / etc. to know
>>> whether a given sector on a SSD contains reliable data or not.  And
>>> even for SSDs that provide "deterministic" data in response to sector
>>> reads, the data itself could have been randomly modified/corrupted by
>>> the SSD, but the data returned regardless with no indication from the
>>> SSD that it is not the original data associated with that sector.
>>>
>>> The spec merely says that once a determistic SSD has a sector read,
>>> all subsequent sector reads from that sector will provide the same
>>> data.  That does not prevent the SSD from randomly modifying the
>>> discarded sectors prior to the first read.
>>>
>>> Lacking any specific indication from the SSD that data read from it is
>>> reliable vs. junk seems to make it unusable for many needs.  ie. I am
>>> talking about all sectors here, not just the discarded ones.  The
>>> kernel can't tell the difference between them anyway.
>>>
>>> In particular I am very concerned about using a SSD to hold data that
>>> would eventually be used in a court of law.  How could I testify that
>>> the data retrieved from the SSD is the same as the data written to the
>>> SSD since per the spec. the SSD does not even have a way to
>>> communicate the validity of data back to the kernel.
>>>
>>> I would far prefer that reads from "discarded" sectors be flagged in
>>> some way.  Then tools, kernels, etc. could be modified to check the
>>> flag and only depend on sector data retrieved from the SSD that is
>>> flagged reliable.  Or inversely, not tagged unreliable.
>>>
>>>       
>> (I've changed my e-mail to gmail, sorry)
>>
>> The "flagging" may make the situation complex.
>> For example, a read request may span over valid and invalid area.
>> (invalid means it's discarded and the original data is destroyed)
>>
>> --
>> Dongjun
>>     
>
> Just to make sure I understand, with the proposed trim updates to the
> ATA spec (T13/e08137r2 draft), a SSD can have two kinds of data.
>
> Reliable and unreliable.  Where unreliable can return zeros, ones, old
> data, random made up data, old data slightly adulterated, etc..
>
> And there is no way for the kernel to distinguish if the particular
> data it is getting from the SSD is of the reliable or unreliable type?
>
> For the unreliable data, if the determistic bit is set in the identify
> block, then the kernel can be assured of reading the same unreliable
> data repeatedly, but still it has no way of knowing the data it is
> reading was ever even written to the SSD in the first place.
>
> That just seems unacceptable.
>
> Greg
>   
Hi Greg,

I sat in on a similar discussion in T10 . With luck, the T13 people have 
the same high level design:

(1) following a write to sector X, any subsequent read of X will return 
that data
(2) once you DISCARD/UNMAP sector X, the device can return any state 
(stale data, all 1's, all 0's) on the next read of that sector, but must 
continue to return that data on following reads until the sector is 
rewritten

To get to a cleanly defined initial state, you will have to write a 
specific pattern to the device (say all zeros). Normally, I don't think 
that we care since we don't read sectors that have not been written.  
This is a concern for various scrubbers (RAID rebuilds, RAID parity 
verification, scanning for bad blocks, ??).

What scenario are you worried about specifically?

Ric

