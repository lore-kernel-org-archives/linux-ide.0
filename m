From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Mon, 08 Mar 2010 10:34:47 -0500
Message-ID: <yq1r5nubze0.fsf@sermon.lab.mkp.net>
References: <4B947393.2050002@kernel.org>
	<1268031640.4389.11.camel@mulgrave.site> <4B94ACE8.4060400@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:38343 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab0CHPh6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Mar 2010 10:37:58 -0500
In-Reply-To: <4B94ACE8.4060400@zytor.com> (H. Peter Anvin's message of "Sun,
	07 Mar 2010 23:53:12 -0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

>>>>> "hpa" == H Peter Anvin <hpa@zytor.com> writes:

hpa> I would very much like a reference for a platform which has
hpa> firmware which can successfully boot from 4K-logical media.  It
hpa> would be very useful for bootloader testing.

I have yet to find one.


hpa> Aligning partitions is something we should have done long ago.  It
hpa> affects RAID and many flash drives just as much or more than
hpa> 4K-sectored disks.

Yup.


hpa> As far as partitioning... I believe we should be using GPT
hpa> partition tables where possible.  Even on non-EFI systems, it's
hpa> simply a much better partition table format.

Agreed.

-- 
Martin K. Petersen	Oracle Linux Engineering
