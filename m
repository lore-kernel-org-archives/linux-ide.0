From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19
Date: Wed, 10 Jan 2007 18:00:50 -0800 (PST)
Message-ID: <20070111020050.62269.qmail@web802.biz.mail.mud.yahoo.com>
References: <1168472072.14261.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web802.biz.mail.mud.yahoo.com ([209.191.90.75]:48970 "HELO
	web802.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030196AbXAKCAv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jan 2007 21:00:51 -0500
In-Reply-To: <1168472072.14261.5.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

I've kinda given up for the moment.  I finally figured out the 137GB limit and
created a partition much smaller than that.  The driver *seems* to work, but
when I do md5sums on the files I copy to the disk, I get random results, i.e.
never the same thing twice on the same file once RAM cache is cleared.  The
disk drive itself works just fine on a different machine using sata_nv.  Maybe
it's something specific to the 1622TA2 card I have.  I dunno.  I have another
SATA drive coming that's only 80GB.  I'll put that one on this controller when
it comes in and see if things change.

Bob

--- Richard Purdie <rpurdie@rpsys.net> wrote:

> On Wed, 2006-12-20 at 20:16 -0800, Bob Stewart wrote:
> > Sorry, that should have been "logblocks".  As shown below, it works unless
> the
> > partition is such that logblocks will be larger than 16383.  In fdisk, that
> > number of cylinders anything greater than 16709.  "Works" is relative,
> though. 
> > When doing a copy of several gigabytes, the syslog shows periodic device
> > errors, which I have posted previously.  Each time, it lowers the access
> rate
> > until it eventually reaches PI04.
> [...]
> > Here is the fdisk screen for the above disk.  If I use a figure larger than
> > 16709 cylinders mkfs.xfs will not be successful.
> > 
> > Disk /dev/sda: 200.0 GB, 200049647616 bytes
> > 255 heads, 63 sectors/track, 24321 cylinders
> > Units = cylinders of 16065 * 512 = 8225280 bytes
> > 
> >    Device Boot      Start         End      Blocks   Id  System
> > /dev/sda1               1       16709   134215011   83  Linux
> 
> Its probably significant that the problem appears at >137GB. I've got a
> similar issue with a 320GB drive I've just tried to use. I've not pinned
> down the limit but I partitioned the drive in two and the first half
> works, the second half gives corrupt superblock errors when trying to
> mount it (ext3).
> 
> I tried both the 2.6.19 version and one based on 2.6.20-rc4, same
> problem. Is there anything specific the driver needs to do work with
> disks > 137GB?
> 
> I've just tried to grab the datasheet but the Initio webserver has
> chosen this moment to act up...
> 
> Richard
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

