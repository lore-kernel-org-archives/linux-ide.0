From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA support for 4k sector size
Date: Thu, 26 Feb 2009 15:35:47 -0500
Message-ID: <yq1iqmxey1o.fsf@sermon.lab.mkp.net>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>
	<49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>
	<20090226025043.GJ1363@mit.edu>
	<20090226030735.GA16891@parisc-linux.org>
	<yq1eixlg4mn.fsf@sermon.lab.mkp.net> <49A6B604.1060702@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:21886 "EHLO
	rgminet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566AbZBZUgx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Feb 2009 15:36:53 -0500
In-Reply-To: <49A6B604.1060702@zytor.com> (H. Peter Anvin's message of "Thu\, 26 Feb 2009 07\:32\:20 -0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Matthew Wilcox <matthew@wil.cx>, Theodore Tso <tytso@mit.edu>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

>>>>> "hpa" == H Peter Anvin <hpa@zytor.com> writes:

>> Quick answer from one of my contacts.  Desktop drives will indeed
>> ship with an alignment of 1(*).  The alignment is hardwired at time
>> of manufacture and can't be changed.
>> 

hpa> Oh God.

hpa> This is a disaster.

Rationale being that modern Microsoft operating systems know how to
interpret the alignment bits.  Legacy XP will work without changes
thanks to the shifted alignment.  And Vista+ will do the right thing to
align partition 1 to what the drive reports.

Also note that Windows only aligns the first partition.  That's
something we need to be aware of when setting up dual boot systems.

-- 
Martin K. Petersen	Oracle Linux Engineering
