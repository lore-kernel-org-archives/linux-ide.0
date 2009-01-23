From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: SSD data reliable vs. unreliable [Was: Re: Data Recovery from
	SSDs -  Impact of trim?]
Date: Fri, 23 Jan 2009 22:24:07 +0000
Message-ID: <1232749447.3250.146.camel@localhost.localdomain>
References: <87f94c370901221553p4d3a749fl4717deabba5419ec@mail.gmail.com>
	 <497A2B3C.3060603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:40576 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757039AbZAWWYI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2009 17:24:08 -0500
In-Reply-To: <497A2B3C.3060603@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <rwheeler@redhat.com>
Cc: Greg Freemyer <greg.freemyer@norcrossgroup.com>, Dongjun Shin <djshin90@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, 2009-01-23 at 15:40 -0500, Ric Wheeler wrote:
> Greg Freemyer wrote:
> > Just to make sure I understand, with the proposed trim updates to the
> > ATA spec (T13/e08137r2 draft), a SSD can have two kinds of data.
> >
> > Reliable and unreliable.  Where unreliable can return zeros, ones, old
> > data, random made up data, old data slightly adulterated, etc..
> >
> > And there is no way for the kernel to distinguish if the particular
> > data it is getting from the SSD is of the reliable or unreliable type?
> >
> > For the unreliable data, if the determistic bit is set in the identify
> > block, then the kernel can be assured of reading the same unreliable
> > data repeatedly, but still it has no way of knowing the data it is
> > reading was ever even written to the SSD in the first place.
> >
> > That just seems unacceptable.
> >
> > Greg
> >   
> Hi Greg,
> 
> I sat in on a similar discussion in T10 . With luck, the T13 people have 
> the same high level design:
> 
> (1) following a write to sector X, any subsequent read of X will return 
> that data
> (2) once you DISCARD/UNMAP sector X, the device can return any state 
> (stale data, all 1's, all 0's) on the next read of that sector, but must 
> continue to return that data on following reads until the sector is 
> rewritten

Actually, the latest draft:

http://www.t10.org/cgi-bin/ac.pl?t=d&f=08-356r5.pdf

extends this behaviour: If the array has read capacity(16) TPRZ bit set
then the return for an unmapped block is always zero.  If TPRZ isn't
set, it's undefined but consistent.  I think TPRZ is there to address
security concerns.

James


