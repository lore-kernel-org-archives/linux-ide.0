From: Greg Freemyer <greg.freemyer@norcrossgroup.com>
Subject: SSD data reliable vs. unreliable [Was: Re: Data Recovery from SSDs -
	Impact of trim?]
Date: Thu, 22 Jan 2009 18:53:17 -0500
Message-ID: <87f94c370901221553p4d3a749fl4717deabba5419ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:13058 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbZAVXxT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 18:53:19 -0500
Received: by qw-out-2122.google.com with SMTP id 3so2056607qwe.37
        for <linux-ide@vger.kernel.org>; Thu, 22 Jan 2009 15:53:17 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dongjun Shin <djshin90@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, Jan 22, 2009 at 6:40 PM, Dongjun Shin <djshin90@gmail.com> wrote:
> On Thu, Jan 22, 2009 at 12:56 AM, Greg Freemyer
> <greg.freemyer@norcrossgroup.com> wrote:
>>
>> Dongjun,
>>
>> I just read the T13/e08137r2 draft you linked to and the powerpoint
>> which addresses security issues caused by the 2007 proposed specs
>> implementations.
>>
>> I'm very concerned not with the discarded sectors, but with the fact
>> that I see no way to know which sectors hold valid / reliable data vs.
>> those that have been discarded and thus hold unreliable data.
>>
>> The T13/e08137r2 draft It is not strong enough to address this issue
>> in my opinion.
>>
>> == Details
>>
>> As I understand it there is no way for a OS / kernel / etc. to know
>> whether a given sector on a SSD contains reliable data or not.  And
>> even for SSDs that provide "deterministic" data in response to sector
>> reads, the data itself could have been randomly modified/corrupted by
>> the SSD, but the data returned regardless with no indication from the
>> SSD that it is not the original data associated with that sector.
>>
>> The spec merely says that once a determistic SSD has a sector read,
>> all subsequent sector reads from that sector will provide the same
>> data.  That does not prevent the SSD from randomly modifying the
>> discarded sectors prior to the first read.
>>
>> Lacking any specific indication from the SSD that data read from it is
>> reliable vs. junk seems to make it unusable for many needs.  ie. I am
>> talking about all sectors here, not just the discarded ones.  The
>> kernel can't tell the difference between them anyway.
>>
>> In particular I am very concerned about using a SSD to hold data that
>> would eventually be used in a court of law.  How could I testify that
>> the data retrieved from the SSD is the same as the data written to the
>> SSD since per the spec. the SSD does not even have a way to
>> communicate the validity of data back to the kernel.
>>
>> I would far prefer that reads from "discarded" sectors be flagged in
>> some way.  Then tools, kernels, etc. could be modified to check the
>> flag and only depend on sector data retrieved from the SSD that is
>> flagged reliable.  Or inversely, not tagged unreliable.
>>
>
> (I've changed my e-mail to gmail, sorry)
>
> The "flagging" may make the situation complex.
> For example, a read request may span over valid and invalid area.
> (invalid means it's discarded and the original data is destroyed)
>
> --
> Dongjun

Just to make sure I understand, with the proposed trim updates to the
ATA spec (T13/e08137r2 draft), a SSD can have two kinds of data.

Reliable and unreliable.  Where unreliable can return zeros, ones, old
data, random made up data, old data slightly adulterated, etc..

And there is no way for the kernel to distinguish if the particular
data it is getting from the SSD is of the reliable or unreliable type?

For the unreliable data, if the determistic bit is set in the identify
block, then the kernel can be assured of reading the same unreliable
data repeatedly, but still it has no way of knowing the data it is
reading was ever even written to the SSD in the first place.

That just seems unacceptable.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
