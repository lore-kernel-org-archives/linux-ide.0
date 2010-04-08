From: Alexander Clausen <alex@gc-web.de>
Subject: Re: 4k sector size and WD20EARS
Date: Thu, 08 Apr 2010 19:04:05 +0200
Message-ID: <4BBE0C85.2020904@gc-web.de>
References: <4BBDE620.3040601@gc-web.de> <yq17hoix78i.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server3.gc-web.de ([188.40.57.209]:47625 "EHLO mail.gc-web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932662Ab0DHREI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Apr 2010 13:04:08 -0400
In-Reply-To: <yq17hoix78i.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org

On 04/08/2010 06:02 PM, Martin K. Petersen wrote:
> For unknown reasons these drive report themselves as 512-byte drives
> despite using 4096-byte sectors internally.

ouch.

> However, recent fdisk/parted will align on a 1MB boundary by
> default which happens do the trick in this particular case

> Alexander>   1 Primary 0 3907024064 63 3907024065 Linux (83) None
> Alexander>  alex@hal:~$

> No, you should shift the start sector using the fdisk's advanced menu.

I created this partition table using cfdisk (util-linux 2.17 from debian/experimental). I guess even 
that is too old?

I now re-created the partition table using fdisk from util-linux-ng git and got this:

Command (m for help): p

Disk /dev/sdb: 2000.4 GB, 2000398934016 bytes
81 heads, 63 sectors/track, 765633 cylinders, total 3907029168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x2afff6d1

    Device Boot      Start         End      Blocks   Id  System
/dev/sdb1            2048  3907029167  1953513560   83  Linux

but:

$ sudo cfdisk -P s /dev/sdb
FATAL ERROR: Bad primary partition 0: Partition ends in the final partial cylinder

bug?

thanks for the help,
Alexander
