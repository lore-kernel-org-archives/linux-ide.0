From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ATA support for 4k sector size
Date: Thu, 26 Feb 2009 13:02:49 -0800
Message-ID: <49A70379.3050306@zytor.com>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>	<49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>	<20090226025043.GJ1363@mit.edu>	<20090226030735.GA16891@parisc-linux.org>	<yq1eixlg4mn.fsf@sermon.lab.mkp.net> <49A6B604.1060702@zytor.com> <yq1iqmxey1o.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:53478 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbZBZVEe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Feb 2009 16:04:34 -0500
In-Reply-To: <yq1iqmxey1o.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Theodore Tso <tytso@mit.edu>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

Martin K. Petersen wrote:
>>>>>> "hpa" == H Peter Anvin <hpa@zytor.com> writes:
> 
>>> Quick answer from one of my contacts.  Desktop drives will indeed
>>> ship with an alignment of 1(*).  The alignment is hardwired at time
>>> of manufacture and can't be changed.
>>>
> 
> hpa> Oh God.
> 
> hpa> This is a disaster.
> 
> Rationale being that modern Microsoft operating systems know how to
> interpret the alignment bits.  Legacy XP will work without changes
> thanks to the shifted alignment.  And Vista+ will do the right thing to
> align partition 1 to what the drive reports.
> 
> Also note that Windows only aligns the first partition.  That's
> something we need to be aware of when setting up dual boot systems.
> 

Yeah, but all of this completely breaks the disk image abstraction, 
which is a very powerful paradigm.

	-hpa

