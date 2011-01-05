From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Tue, 04 Jan 2011 19:05:36 -0500
Message-ID: <yq1r5cstdtb.fsf@sermon.lab.mkp.net>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com>
	<4D2223BF.8090901@canonical.com>
	<AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com>
	<4D2247A3.2060506@canonical.com>
	<AANLkTi=Kv8f3e8zhSkDohkgJqOv+XKQ_dPR=aFbpzm27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:54819 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab1AEAFp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2011 19:05:45 -0500
In-Reply-To: <AANLkTi=Kv8f3e8zhSkDohkgJqOv+XKQ_dPR=aFbpzm27@mail.gmail.com>
	(Greg Freemyer's message of "Mon, 3 Jan 2011 17:50:51 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>

>>>>> "Greg" == Greg Freemyer <greg.freemyer@gmail.com> writes:

Greg> In the mean time I've found the hdparm also looks at word 217 and
Greg> reports SSD devices.  It has apparently been doing that since
Greg> v9.12 or so.  (spring 2009).

Yes. And the Linux kernel has had the sysfs parameter since 2.6.29 which
came out around the same time.


Greg> My current concern is that the logic is slowly diverging between
Greg> the kernel 2.6.36 implementation and the hdparm v9.36
Greg> implementation.

As Mark said: The whole point of hdparm is to talk directly to the
device. There never was convergence, nor should there be.


Greg> 1) The kernel routine ata_id_rotation_rate() (in ata.h) is only
Greg> trusting word 217 if its ATA7 or higher.

The standards bodies are glacially slow (ACS-2 still hasn't been
ratified, although it's close. Again. Maybe). Consequently most device
vendors "backport" features from the drafts. But obviously they can't
and won't report compliance with an unfinished standard.

There are plenty of SSD drives out there which claim ATA7 compliance and
which support word 217. The reason we have a version check in the first
place is to guard against legacy devices which have inadvertently put
garbage in word 217.

We have had the rotational flag in place for a couple of years and have
had very few reports about devices misrepresenting themselves. So I'm
not entirely convinced we need quirk handling for this. Your friendly
kernel developers already made sure the rotational flag can be
overridden from user space.

-- 
Martin K. Petersen	Oracle Linux Engineering
