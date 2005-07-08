From: Danny Cox <DCox@icc.net>
Subject: Re: Readahead with softraid1
Date: Fri, 08 Jul 2005 08:16:24 -0400
Message-ID: <1120824984.3415.233.camel@vom>
References: <1120824029.23681.18.camel@localhost.localdomain>
Reply-To: DCox@icc.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webmail.ecweb.com ([209.168.254.136]:6333 "EHLO
	webmail.ecweb.com") by vger.kernel.org with ESMTP id S262587AbVGHMQd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jul 2005 08:16:33 -0400
In-Reply-To: <1120824029.23681.18.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Linux IDE List <linux-ide@vger.kernel.org>

Erik,

On Fri, 2005-07-08 at 14:00 +0200, Erik Slagter wrote:
> I am using softraid 1 on two sata disks and I'm trying to get the best
> possible performance. IMHO read actions (if properly addressed) should
> be split over the two drivers and performed independently. However, I
> don't notice anything to back this up. The read performance (with the
> dreaded hdparm) shows read performance on sda,sdb and md0 exactly the
> same.
...
> What am I doing wrong here???

	Nothing.  I'll take a shot at answering this one instead of lurking
this time.  Then, I'll crawl back under my rock.

	The raid1 driver keeps a "last visited block" for each drive.  This is
the block number that was most recently read or written by that drive.
When a read request arrives, the driver examines each drive for the
nearest last visited block to the one requested.  Guess what?  If the
read starts with drive sda, then it will *always* be the one chosen to
service the read in the future, because the last visited block number is
only one off.  This would only change if there are multiple processes
performing I/O on the md device.  Then, it may switch to another drive.
In any case, it will *tend* to stick with the same drive.

	Did I explain that well, or only muddy the waters?

-- 
Daniel S. Cox
Internet Commerce Corporation

