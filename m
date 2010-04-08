From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: 4k sector size and WD20EARS
Date: Thu, 08 Apr 2010 14:56:18 -0400
Message-ID: <yq1d3y9wz71.fsf@sermon.lab.mkp.net>
References: <4BBDE620.3040601@gc-web.de> <yq17hoix78i.fsf@sermon.lab.mkp.net>
	<alpine.DEB.1.10.1004081811200.21305@uplift.swm.pp.se>
	<yq1tyrlx5tr.fsf@sermon.lab.mkp.net>
	<alpine.DEB.1.10.1004081858560.21305@uplift.swm.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from acsinet11.oracle.com ([141.146.126.233]:16874 "EHLO
	acsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932642Ab0DHS5Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 14:57:25 -0400
In-Reply-To: <alpine.DEB.1.10.1004081858560.21305@uplift.swm.pp.se> (Mikael
	Abrahamsson's message of "Thu, 8 Apr 2010 19:00:50 +0200 (CEST)")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Abrahamsson <swmike@swm.pp.se>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Alexander Clausen <alex@gc-web.de>, linux-ide@vger.kernel.org

>>>>> "Mikael" == Mikael Abrahamsson <swmike@swm.pp.se> writes:

>> We still haven't been given a comprehensive explanation.  "It breaks
>> something for someone" doesn't really give us much to work with...

Mikael> I don't really see what it is you're looking for when it comes
Mikael> to "more information"?

The physical block size is reported in IDENTIFY DEVICE word 106 which
hasn't been and isn't used for anything else.  So nothing should be
looking there unless it is 4KB sector-aware.

I've been testing a variety of drives with 4KB sectors for well over a
year.  All of them correctly reporting the physical block size.  The
only real problems I have found during testing have been missing
SCSI-ATA translation or incorrect alignment reporting (SCSI and ATA
express things differently).

It's bad enough that our I/O stack has to deal with hordes of USB ATA
bridge devices that are unintentionally broken.  But now we are talking
production disk drives that were intentionally neutered.  And we're not
being told why.

Obviously some of this might fall into NDA territory.  And that's fair
enough.  My gripe is that nothing has been done to substantiate the
issue.  A problem that apparently warranted blowing away years of
industry-wide standardization, implementation, and testing efforts.
That's no small thing in my book.

I also want to be assured that the real root cause gets fixed.  We
obviously want future drives to be both standards-compliant and accurate
in their reporting.

-- 
Martin K. Petersen	Oracle Linux Engineering
