From: Greg Freemyer <greg.freemyer@norcrossgroup.com>
Subject: Re: SSD data reliable vs. unreliable [Was: Re: Data Recovery from
	SSDs - Impact of trim?]
Date: Fri, 23 Jan 2009 18:26:28 -0500
Message-ID: <87f94c370901231526jb41ea66ta1d6a23d7631d63c@mail.gmail.com>
References: <87f94c370901221553p4d3a749fl4717deabba5419ec@mail.gmail.com>
	 <497A2B3C.3060603@redhat.com>
	 <1232749447.3250.146.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:48434 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757572AbZAWX03 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2009 18:26:29 -0500
Received: by qyk4 with SMTP id 4so5545137qyk.13
        for <linux-ide@vger.kernel.org>; Fri, 23 Jan 2009 15:26:28 -0800 (PST)
In-Reply-To: <1232749447.3250.146.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ric Wheeler <rwheeler@redhat.com>, Dongjun Shin <djshin90@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, Jan 23, 2009 at 5:24 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Fri, 2009-01-23 at 15:40 -0500, Ric Wheeler wrote:
>> Greg Freemyer wrote:
>> > Just to make sure I understand, with the proposed trim updates to the
>> > ATA spec (T13/e08137r2 draft), a SSD can have two kinds of data.
>> >
>> > Reliable and unreliable.  Where unreliable can return zeros, ones, old
>> > data, random made up data, old data slightly adulterated, etc..
>> >
>> > And there is no way for the kernel to distinguish if the particular
>> > data it is getting from the SSD is of the reliable or unreliable type?
>> >
>> > For the unreliable data, if the determistic bit is set in the identify
>> > block, then the kernel can be assured of reading the same unreliable
>> > data repeatedly, but still it has no way of knowing the data it is
>> > reading was ever even written to the SSD in the first place.
>> >
>> > That just seems unacceptable.
>> >
>> > Greg
>> >
>> Hi Greg,
>>
>> I sat in on a similar discussion in T10 . With luck, the T13 people have
>> the same high level design:
>>
>> (1) following a write to sector X, any subsequent read of X will return
>> that data
>> (2) once you DISCARD/UNMAP sector X, the device can return any state
>> (stale data, all 1's, all 0's) on the next read of that sector, but must
>> continue to return that data on following reads until the sector is
>> rewritten
>
> Actually, the latest draft:
>
> http://www.t10.org/cgi-bin/ac.pl?t=d&f=08-356r5.pdf
>
> extends this behaviour: If the array has read capacity(16) TPRZ bit set
> then the return for an unmapped block is always zero.  If TPRZ isn't
> set, it's undefined but consistent.  I think TPRZ is there to address
> security concerns.
>
> James

To James,

I took a look at the spec, but I'm not familiar with the SCSI spec to
grok it immediately.

Is the TPRZ bit meant to be a way for the manufacturer to report which
of the two behaviors their device implements, or is it a externally
configurable flag that tells the SSD which way to behave?

Either way, is there reason to believe the ATA T13 spec will get
similar functionality?

To Ric,

First, in general I think is is bizarre to have a device that is by
spec able to return both reliable and non-reliable data, but the spec
does not include a signaling method to differentiate between the two.

===
My very specific concern is that I work with evidence that will
eventually be presented at court.

We routinely work with both live files and recoved deleted files
(Computer Forensic Analysis).  Thus we would typically be reading the
discarded sectors as well as in-use sectors.

After reading the original proposal from 2007, I assumed that a read
would provide me either data that had been written specifically to the
sectors read, or that the SSD would return all nulls.  That is very
troubling to the ten thousand or so computer forensic examiners in the
USA, but it true we just had to live with it.

Now reading the Oct. 2008 revision I realized that discarded sectors
are theoretically allowed to return absolutely anything the SSD feels
like returning.  Thus the SSD might return data that appears to be
supporting one side of the trial or the other, but it may have been
artificially created by the SSD.  And I don't even have a flag that
says "trust this data".

The way things currently stand with my understanding of the proposed
spec. I will not be able to tell the court anything about the
reliability of any data copied from the SSD regardless of whether it
is part of an active file or not.

At its most basic level, I transport a typical file on a SSD by
connecting it to computer A, writing data to it, disconnecting from A
and connecting to computer B and then print it from there for court
room use.

When I read that file from the SSD how can I assure the court that
data I read is even claimed to be reliable by the SSD?

 ie. The SSD has no way to say "I believe this data is what was
written to me via computer A" so why should the court or anyone else
trust the data it returns.

IF the TPRZ bit becomes mandatory for both ATA and SCSI SSDs, then if
it is set I can have confidence that any data read from the device was
actually written to it.

Lacking the TPRZ bit, ...

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
