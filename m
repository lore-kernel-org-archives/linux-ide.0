From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Readahead with softraid1
Date: Fri, 8 Jul 2005 11:28:37 -0400
Message-ID: <87f94c37050708082828e37574@mail.gmail.com>
References: <1120824029.23681.18.camel@localhost.localdomain>
	 <1120824984.3415.233.camel@vom>
Reply-To: Greg Freemyer <greg.freemyer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:7067 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262686AbVGHP3D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jul 2005 11:29:03 -0400
Received: by wproxy.gmail.com with SMTP id i1so481316wra
        for <linux-ide@vger.kernel.org>; Fri, 08 Jul 2005 08:29:00 -0700 (PDT)
In-Reply-To: <1120824984.3415.233.camel@vom>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: DCox@icc.net
Cc: Erik Slagter <erik@slagter.name>, Linux IDE List <linux-ide@vger.kernel.org>

On 7/8/05, Danny Cox wrote:
> Erik,
> 
> On Fri, 2005-07-08 at 14:00 +0200, Erik Slagter wrote:
> > I am using softraid 1 on two sata disks and I'm trying to get the best
> > possible performance. IMHO read actions (if properly addressed) should
> > be split over the two drivers and performed independently. However, I
> > don't notice anything to back this up. The read performance (with the
> > dreaded hdparm) shows read performance on sda,sdb and md0 exactly the
> > same.
> ...
> > What am I doing wrong here???
> 
>         Nothing.  I'll take a shot at answering this one instead of lurking
> this time.  Then, I'll crawl back under my rock.
> 
>         The raid1 driver keeps a "last visited block" for each drive.  This is
> the block number that was most recently read or written by that drive.
> When a read request arrives, the driver examines each drive for the
> nearest last visited block to the one requested.  Guess what?  If the
> read starts with drive sda, then it will *always* be the one chosen to
> service the read in the future, because the last visited block number is
> only one off.  This would only change if there are multiple processes
> performing I/O on the md device.  Then, it may switch to another drive.
> In any case, it will *tend* to stick with the same drive.
> 
>         Did I explain that well, or only muddy the waters?
> 
> --
> Daniel S. Cox
> Internet Commerce Corporation
> 

Interesting.  Unfortunately, I do a lot of sequential reading with
little or no other computer activity and had wondered about the "slow"
speed of RAID 1 on read.

Does anyone know if that a common implementation on Hardware Raid
controllers too?

I have actually been working mostly with 3ware 7000 series cards, so
the md implementation does not affect me, but if that is a common
design then the 3ware card may have a similar algorithm.

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
