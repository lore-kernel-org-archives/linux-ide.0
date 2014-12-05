From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return zeroes after TRIM
Date: Thu, 04 Dec 2014 20:53:22 -0500
Message-ID: <yq18uimhnfx.fsf@sermon.lab.mkp.net>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net> <547FCECB.4090908@ubuntu.com>
	<yq1sigwgkqt.fsf@sermon.lab.mkp.net> <547FD4F6.7090700@ubuntu.com>
	<yq1k328gk80.fsf@sermon.lab.mkp.net> <547FE5BD.9070101@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:40430 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbaLEBxa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2014 20:53:30 -0500
In-Reply-To: <547FE5BD.9070101@ubuntu.com> (Phillip Susi's message of "Wed, 03
	Dec 2014 23:40:29 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

>>>>> "Phillip" == Phillip Susi <psusi@ubuntu.com> writes:

Phillip> So your assertion is that you have seen it in writing, 

Actually I haven't. I have talked to a bunch of people that have done
RAID qualification on SSDs. I also gleaned on a few vendor lists of
supported drive configurations.

The good news is that practice of each OEM having their own custom drive
firmware build is not very common for SSDs. And most of the results I
looked at was collected using off-the-shelf drives.

Phillip> I'm not saying a hard hell no, but this certainly makes me
Phillip> uncomfortable.  

You do realize that my patch *restricts* the drives we enable
discard_zeroes_data on, right? Instead of relying solely on the drive's
own reporting we now also require empirical evidence that they do the
right thing.

Phillip> I'd much rather see the manufacturers put it in writing that
Phillip> yes, this make and model will perform this way even though it
Phillip> is not strictly required by ATA8.

Wishful thinking.

The sad reality is that standards are deliberately written to be
vague. And that any hard guarantees are part of product requirements
documents. That's not specific to SSDs in any way. That's true for
pretty much any piece of hardware.

Phillip> What would be better still is if the bloody ATA standard got a
Phillip> clue and said that if the drive claims that it does in fact
Phillip> zero after TRIM, that the TRIM command becomes mandatory
Phillip> instead of advisory.

I agree that the standards efforts in this department are a total train
wreck.

-- 
Martin K. Petersen	Oracle Linux Engineering
