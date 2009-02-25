From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA support for 4k sector size
Date: Wed, 25 Feb 2009 18:27:18 -0500
Message-ID: <yq1hc2iumg9.fsf@sermon.lab.mkp.net>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>
	<49A5CBF7.9000501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet13.oracle.com ([148.87.113.125]:31547 "EHLO
	rgminet13.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbZBYX1n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 18:27:43 -0500
In-Reply-To: <49A5CBF7.9000501@zytor.com> (H. Peter Anvin's message of "Wed\, 25 Feb 2009 14\:53\:43 -0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

>>>>> "hpa" == H Peter Anvin <hpa@zytor.com> writes:

>> The two patches following this add support for drives which have
>> sector sizes other than 512 bytes.  I haven't been able to test this
>> as I don't have the hardware.

hpa> What sector size do we report to user space for this?  I'm asking
hpa> because logical sector size is visible in most partition formats.

There are several flavors of drives we have to deal with:

512-byte logical / 512-byte hardware (current)
512-byte logical / 4096-byte hardware (ATA, doing read-modify-write)
4096-byte logical / 4096-byte hardware (SCSI initially, ATA later)

Because of 63-sector legacy problems a bunch of ATA vendors will
initially ship 512/4096 drives that are not naturally aligned.
I.e. logical sector 63 will be aligned on a 4KB hardware sector
boundary to overcome the misaligned default partitioning.

I have been working on some alignment patches the last week.  They hook
into the stuff Matthew has been doing in libata and I'll post them
shortly.

For each block device you'll get a hardware sector size exposed as well
as whether the device (partition) is naturally aligned or not.  This
works for both ATA and SCSI devices.

I'll defer to people like yourself for how this needs to work wrt. boot
loaders and creating partition tables.  I'm CC:ing Eric Sandeen because
he's also looking at this...

-- 
Martin K. Petersen	Oracle Linux Engineering

