From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: SSD data reliable vs. unreliable [Was: Re: Data Recovery from
 	SSDs - Impact of trim?]
Date: Mon, 26 Jan 2009 11:22:52 -0500
Message-ID: <497DE35C.6090308@redhat.com>
References: <87f94c370901221553p4d3a749fl4717deabba5419ec@mail.gmail.com>	 <497A2B3C.3060603@redhat.com>	 <1232749447.3250.146.camel@localhost.localdomain>	 <87f94c370901231526jb41ea66ta1d6a23d7631d63c@mail.gmail.com>	 <497A542C.1040900@redhat.com> <7fce22690901260659u30ffd634m3fb7f75102141ee9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:43145 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbZAZQW7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 11:22:59 -0500
In-Reply-To: <7fce22690901260659u30ffd634m3fb7f75102141ee9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@norcrossgroup.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Dongjun Shin <djshin90@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Greg Freemyer wrote:
> On Fri, Jan 23, 2009 at 6:35 PM, Ric Wheeler <rwheeler@redhat.com> wrote:
>   
>> Greg Freemyer wrote:
>>     
>>> On Fri, Jan 23, 2009 at 5:24 PM, James Bottomley
>>> <James.Bottomley@hansenpartnership.com> wrote:
>>>
>>>       
>>>> On Fri, 2009-01-23 at 15:40 -0500, Ric Wheeler wrote:
>>>>
>>>>         
>>>>> Greg Freemyer wrote:
>>>>>
>>>>>           
>>>>>> Just to make sure I understand, with the proposed trim updates to the
>>>>>> ATA spec (T13/e08137r2 draft), a SSD can have two kinds of data.
>>>>>>
>>>>>> Reliable and unreliable.  Where unreliable can return zeros, ones, old
>>>>>> data, random made up data, old data slightly adulterated, etc..
>>>>>>
>>>>>> And there is no way for the kernel to distinguish if the particular
>>>>>> data it is getting from the SSD is of the reliable or unreliable type?
>>>>>>
>>>>>> For the unreliable data, if the determistic bit is set in the identify
>>>>>> block, then the kernel can be assured of reading the same unreliable
>>>>>> data repeatedly, but still it has no way of knowing the data it is
>>>>>> reading was ever even written to the SSD in the first place.
>>>>>>
>>>>>> That just seems unacceptable.
>>>>>>
>>>>>> Greg
>>>>>>
>>>>>>
>>>>>>             
>>>>> Hi Greg,
>>>>>
>>>>> I sat in on a similar discussion in T10 . With luck, the T13 people have
>>>>> the same high level design:
>>>>>
>>>>> (1) following a write to sector X, any subsequent read of X will return
>>>>> that data
>>>>> (2) once you DISCARD/UNMAP sector X, the device can return any state
>>>>> (stale data, all 1's, all 0's) on the next read of that sector, but must
>>>>> continue to return that data on following reads until the sector is
>>>>> rewritten
>>>>>
>>>>>           
>>>> Actually, the latest draft:
>>>>
>>>> http://www.t10.org/cgi-bin/ac.pl?t=d&f=08-356r5.pdf
>>>>
>>>> extends this behaviour: If the array has read capacity(16) TPRZ bit set
>>>> then the return for an unmapped block is always zero.  If TPRZ isn't
>>>> set, it's undefined but consistent.  I think TPRZ is there to address
>>>> security concerns.
>>>>
>>>> James
>>>>
>>>>         
>>> To James,
>>>
>>> I took a look at the spec, but I'm not familiar with the SCSI spec to
>>> grok it immediately.
>>>
>>> Is the TPRZ bit meant to be a way for the manufacturer to report which
>>> of the two behaviors their device implements, or is it a externally
>>> configurable flag that tells the SSD which way to behave?
>>>
>>> Either way, is there reason to believe the ATA T13 spec will get
>>> similar functionality?
>>>
>>> To Ric,
>>>
>>> First, in general I think is is bizarre to have a device that is by
>>> spec able to return both reliable and non-reliable data, but the spec
>>> does not include a signaling method to differentiate between the two.
>>>
>>> ===
>>> My very specific concern is that I work with evidence that will
>>> eventually be presented at court.
>>>
>>> We routinely work with both live files and recoved deleted files
>>> (Computer Forensic Analysis).  Thus we would typically be reading the
>>> discarded sectors as well as in-use sectors.
>>>
>>> After reading the original proposal from 2007, I assumed that a read
>>> would provide me either data that had been written specifically to the
>>> sectors read, or that the SSD would return all nulls.  That is very
>>> troubling to the ten thousand or so computer forensic examiners in the
>>> USA, but it true we just had to live with it.
>>>
>>> Now reading the Oct. 2008 revision I realized that discarded sectors
>>> are theoretically allowed to return absolutely anything the SSD feels
>>> like returning.  Thus the SSD might return data that appears to be
>>> supporting one side of the trial or the other, but it may have been
>>> artificially created by the SSD.  And I don't even have a flag that
>>> says "trust this data".
>>>
>>> The way things currently stand with my understanding of the proposed
>>> spec. I will not be able to tell the court anything about the
>>> reliability of any data copied from the SSD regardless of whether it
>>> is part of an active file or not.
>>>
>>> At its most basic level, I transport a typical file on a SSD by
>>> connecting it to computer A, writing data to it, disconnecting from A
>>> and connecting to computer B and then print it from there for court
>>> room use.
>>>
>>> When I read that file from the SSD how can I assure the court that
>>> data I read is even claimed to be reliable by the SSD?
>>>
>>>  ie. The SSD has no way to say "I believe this data is what was
>>> written to me via computer A" so why should the court or anyone else
>>> trust the data it returns.
>>>
>>> IF the TPRZ bit becomes mandatory for both ATA and SCSI SSDs, then if
>>> it is set I can have confidence that any data read from the device was
>>> actually written to it.
>>>
>>> Lacking the TPRZ bit, ...
>>>
>>> Greg
>>>
>>>       
>> I think that the incorrect assumption here is that you as a user can read
>> data that is invalid. If you are using a file system, you will never be able
>> to read those unmapped/freed blocks (the file system will not allow it).
>>
>> If you read the raw device as root, then you could seem random bits of data
>> - maybe data recovery tools would make this an issue?
>>
>> ric
>>     
>
> Ric,
>
> 3 things -
>
> 1) I believe there are about 10,000 computer forensic examiners in the
> US.  By definition we work below the filesystem level.  Certainly for
> us the current T13/e08137r2 draft is very troublesome.
>   

I can see why that makes life harder for you all, but I don't think that 
this impacts normal users in any way. Manufacturers will have to comment 
on their implementation, but my expectation is that SSD devices will use 
this to pre-erase blocks which would most likely end up giving you 
blocks of zeroes.

I can even guess that some users will be delighted that SSD's would make 
their data a bit less easy to be used against them in court :-)
> 2) For normal users - The fsck tool is designed to verify various
> pieces of meta-data are all in sync.  With a unmap / trim / discard
> functionality a new repository of meta-data is introduced within the
> SSD.  Yet a way to audit the state of this meta-data is not provided.
>
> If the free list of sectors/blocks etc. gets way out of sync with a
> current fsck, the user is notified (however ungracefully) and the user
> can take the corrective action of restoring a backup.
>
> With the current T13/e08137r2 draft:
> The filesystem's view of the reliable data and the SSDs view of
> reliable data could conceivably get totally out of whack, but there is
> not even a theoretical way to audit the two mapping layers to verify
> they are in sync.
>
> I don't know what the ramifications of them getting out of sync might
> be, but auditability is not a feature I am happy to see discarded.
>   

This seems to be overstated. The file system layer knows what its valid 
data is at any time and will send down unmap/trim commands only when it 
is sure that the block is no longer in use.

The only concern is one of efficiency/performance - the commands are 
advisory, so the target can ignore them (i.e., not pre-erase them or 
allocate them in T10 to another user). There will be no need for fsck to 
look at unallocated blocks.

The concern we do have is that RAID and checksums must be consistent. 
Once read, the device must return the same contents after a trim/unmap 
so as not to change the parity/hash/etc.

> 3) US Security laws such as hipaa / sox, etc. require auditability in
> the maintenance of certain records.  I realize I'm stretching, but one
> could argue that data maintained on a generic T13/e08137r2 compliant
> SSD does not meet the auditability requirements of those laws.
>
> Greg
>   

Having been in the archival storage business at EMC Centera, I think 
that this is a stretch :-)  Audits track changes to data, usually by 
writing those changes into another location than the file system itself.

One serious suggestion is that you take your concerns up with the T13 
group directly - few people on this list sit in on those, I believe that 
it is an open forum.

Regards,

Ric


