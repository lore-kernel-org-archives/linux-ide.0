From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: ATA support for 4k sector size
Date: Wed, 18 Mar 2009 14:33:39 +0000
Message-ID: <1237386819.3350.15.camel@localhost.localdomain>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>
	 <49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>
	 <20090226025043.GJ1363@mit.edu> <20090226030735.GA16891@parisc-linux.org>
	 <yq1eixlg4mn.fsf@sermon.lab.mkp.net> <49A6B604.1060702@zytor.com>
	 <yq1iqmxey1o.fsf@sermon.lab.mkp.net> <49A70379.3050306@zytor.com>
	 <87f94c370903160751t6de5ed2t40163a6590ba633@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:41742 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756415AbZCROdr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Mar 2009 10:33:47 -0400
In-Reply-To: <87f94c370903160751t6de5ed2t40163a6590ba633@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Matthew Wilcox <matthew@wil.cx>, Theodore Tso <tytso@mit.edu>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

On Mon, 2009-03-16 at 10:51 -0400, Greg Freemyer wrote: 
> On Thu, Feb 26, 2009 at 5:02 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> > Martin K. Petersen wrote:
> >>>>>>>
> >>>>>>> "hpa" == H Peter Anvin <hpa@zytor.com> writes:
> >>
> >>>> Quick answer from one of my contacts.  Desktop drives will indeed
> >>>> ship with an alignment of 1(*).  The alignment is hardwired at time
> >>>> of manufacture and can't be changed.
> >>>>
> >>
> >> hpa> Oh God.
> >>
> >> hpa> This is a disaster.
> >>
> >> Rationale being that modern Microsoft operating systems know how to
> >> interpret the alignment bits.  Legacy XP will work without changes
> >> thanks to the shifted alignment.  And Vista+ will do the right thing to
> >> align partition 1 to what the drive reports.
> >>
> >> Also note that Windows only aligns the first partition.  That's
> >> something we need to be aware of when setting up dual boot systems.
> >>
> >
> > Yeah, but all of this completely breaks the disk image abstraction, which is
> > a very powerful paradigm.
> >
> >        -hpa
> >
> If the reported geometry of these drives was changed to have sectors /
> track be a multiple of 8, wouldn't that fix most of the issues.
> 
> ie. If the drive were to report 56 sectors per track, then a
> traditional partitioning tool would start the first partition as
> sector 56 and a Vista like partitioning tool would place the first
> partition at sector 2048.  Both would have the same 4K sector
> alignment.
> 
> If my logic is sound, anyway to get this recommendation upstream to
> hardware manufacturers.  It seems like an almost trivial change for
> them.

This is Ted Ts'o's proposed fix for the problem as well ... we do the
C/H/S translation in scsicam.c and it's then stored in the DOS partition
label.  The only problems are that changing this on the fly might be
problematic for things that believe scsicam_bios_param without first
checking the DOS label (because they'll then be mismatched).  And also,
if the vendors use their power to offset the first 4k block, we'll be
mismatched again.  Plus, once the values are written in the label we
can't update them.

> FYI: It sounds to me like partitioning tools should totally drop
> efforts to align with cylinders, instead they should start asking what
> the unit of atomic read/writes is at the physical layer and if any
> offsets are needed to align the partition with the atomic write areas.
> 
> That would fit better for both SSD technology and for this 4K sectors
> issue than trying to continue to support cylinders at all.

The DOS label is the problematic one ... all the rest have (mostly) more
sensible schemes.  The problem is that the DOS label is the most
prevalent one.

James


