From: David Shaw <dshaw@jabberwocky.com>
Subject: Re: Hyper-V and IDE disks > 128GB
Date: Wed, 1 Dec 2010 10:53:16 -0500
Message-ID: <EE12C226-4D9D-4EBD-AF79-A58E286B4474@jabberwocky.com>
References: <12CD8E2D-64F0-46D6-8ACB-C411D7BECEE7@jabberwocky.com> <20101102192738.1bb0ccf4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from walrus.jabberwocky.com ([173.9.29.57]:33929 "EHLO
	walrus.jabberwocky.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab0LAPxS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Dec 2010 10:53:18 -0500
Received: from dshaw.nasuni.net (gw-comcast1.nasuni.com [173.166.63.186])
	(authenticated bits=0)
	by walrus.jabberwocky.com (8.14.3/8.14.3) with ESMTP id oB1FrHmU030347
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 1 Dec 2010 10:53:17 -0500
In-Reply-To: <20101102192738.1bb0ccf4@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Nov 2, 2010, at 3:27 PM, Alan Cox wrote:

>> with the same results) under the Hyper-V virtualization platform.  Specifically, the virtual IDE disks
>> probe as "ATA-0", which seems to turn off 48-bit LBA, thus capping the
>> disk size at 128GB.
> 
> Early ATA does not support LBA48 so that behaviour is correct from Linux
> 
>> 
>> This seems to have worked properly (at least in the sense that the full size of the disk was visible) on kernel 2.6.27.41.  See http://www.serverphorums.com/read.php?12,79638
>> 
>> In any event, this is how the virtual disk shows up at boot:
>> 
>> Oct 15 11:06:06 localhost kernel: ata1.01: ATA-0: Virtual HD, 1.1.0, max MWDMA2
>> Oct 15 11:06:06 localhost kernel: ata1.01: 267382800 sectors, multi 128: LBA
> 
>> Can someone suggest a direction to go in next?
> 
> Well it looks like a bug in the hypedvisor so I guess the first steps are
> to check with Microsoft if there is an update and to open a bug report
> with them. If the volume naming is consistent then I guess we can also in
> theory add a hack for Linux to recognize the broken volumes (assuming
> LBA48 actually works if you ignore the drive identify data)

I'll file a report with Microsoft and see what happens.  Thanks!

David

