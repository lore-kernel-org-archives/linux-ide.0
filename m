From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA support for 4k sector size
Date: Fri, 11 Dec 2009 02:32:46 -0500
Message-ID: <yq17hsuufs1.fsf@sermon.lab.mkp.net>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>
	<49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>
	<20090226025043.GJ1363@mit.edu>
	<20090226030735.GA16891@parisc-linux.org>
	<yq1myc9g9ua.fsf@sermon.lab.mkp.net> <4B21EF54.9070609@daa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:29125 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757368AbZLKHdr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Dec 2009 02:33:47 -0500
In-Reply-To: <4B21EF54.9070609@daa.com.au> (James Andrewartha's message of
	"Fri, 11 Dec 2009 15:05:56 +0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Andrewartha <jamesa@daa.com.au>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Matthew Wilcox <matthew@wil.cx>, Theodore Tso <tytso@mit.edu>, "H. Peter Anvin" <hpa@zytor.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

>>>>> "James" == James Andrewartha <jamesa@daa.com.au> writes:

>> Given how long this has taken (we're now talking ~2011 for GA) it may
>> very well be that the alignment knobs will be unused because
>> everybody will be using Vista or 7 by then.

James> The plan does seem to have changed - WD's shipping 4k sector
James> drives that are sane and require a drive jumper or tool for WinXP
James> and old cloning utilities.

The disk vendors have agreed to transition no later than 2011.  There
are definitely drives coming out with 4KB physical blocks before then.

There has been a lot of discussion of the merits of shipping 1-aligned
drives by default given that Vista and Windows 7 handle alignment
correctly.

I don't think there has been any firm decisions in IDEMA wrt. 0
vs. 1-aligned.  It may be up to each vendor's discretion, target market
segment, etc.

-- 
Martin K. Petersen	Oracle Linux Engineering
