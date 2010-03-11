From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: ATA 4 KiB sector issues.
Date: Thu, 11 Mar 2010 08:04:56 -0500
Message-ID: <17BB1CC0-9B13-401D-B6AA-90365208A042@mit.edu>
References: <4B947393.2050002@kernel.org> <1268031640.4389.11.camel@mulgrave.site> <yq1vdd6bzgz.fsf@sermon.lab.mkp.net> <yq1mxyibz7o.fsf@sermon.lab.mkp.net> <yq1iq96bz22.fsf@sermon.lab.mkp.net> <20100310075334.GA26763@parisc-linux.org> <4B97A2DE.2030901@garzik.org> <4B97C6A5.4010209@tvk.rwth-aachen.de>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:51018 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932238Ab0CKNKM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Mar 2010 08:10:12 -0500
In-Reply-To: <4B97C6A5.4010209@tvk.rwth-aachen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damian Lukowski <damian@tvk.rwth-aachen.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Matthew Wilcox <matthew@wil.cx>, "Martin K. Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Mark Lord <kernel@teksavvy.com>, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

On Mar 10, 2010, at 11:19 AM, Damian Lukowski wrote:
> 
> I have practically no knowledge of Linux' block device drivers,
> but is this really a partitioning issue? I think the problem is
> with the filesystems when clustering multiple blocks without
> knowledge of the sector alignment and sector size of the underlying
> block device. Maybe it is a better solution to adapt the filesystem
> buffer routine which reads/writes data from/to the block device?

No, it's really a partitioning issue.   If the paging subsystem wants a 4k block to fill a particular page, we need to read that 4k block into memory.  If we need to swap out that 4k block, we need to write that 4k block to swap space, or to the memory segment's backing store.   If the partition is misaligned by 512 bytes, this is simply not possible.   The file system has to do what is requested of it by its users, and the reality is that we need to do 4k aligned reads and writes with respect to the beginning of the partition, far more often than not.

Hence, if we want the best performance on 4k sector drives, the partition needs to be aligned with respect to what is most desirable for the device in question.

Best regards,

-- Ted

