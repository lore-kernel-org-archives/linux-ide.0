From: Roger Heflin <rheflin@atipa.com>
Subject: Re: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2
Date: Wed, 26 Apr 2006 09:05:46 -0500
Message-ID: <444F7E3A.5070109@atipa.com>
References: <444E5620.50404@atipa.com> <444F72C8.4060401@atipa.com> <444F7490.3030800@labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:1244 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932456AbWDZOFt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Apr 2006 10:05:49 -0400
In-Reply-To: <444F7490.3030800@labri.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Emmanuel Fleury <emmanuel.fleury@labri.fr>
Cc: linux-ide@vger.kernel.org

Emmanuel Fleury wrote:
> Hi,
> 
> Roger Heflin wrote:
>>> ata1: command 0xc8 timeout, stat 0x50 host_stat 0x24
>>> ata1: status=0x50 { DriveReady SeekComplete }
>>> sda: Current: sense key: No Sense
>>>     Additional sense: No additional sense information
>>> Info fld=0x3481ff
>>> ata2: command 0xc8 timeout, stat 0x50 host_stat 0x24
>>> ata2: status=0x50 { DriveReady SeekComplete }
>>> sdb: Current: sense key: No Sense
>>>     Additional sense: No additional sense information
>>> Info fld=0x166ff
>>> ata1: command 0xc8 timeout, stat 0x50 host_stat 0x24
>>> ata1: status=0x50 { DriveReady SeekComplete }
>>> sda: Current: sense key: No Sense
>>>     Additional sense: No additional sense information
>>> Info fld=0x3482ff
>>> ata2: command 0xc8 timeout, stat 0x50 host_stat 0x24
>>> ata2: status=0x50 { DriveReady SeekComplete }
>>> sdb: Current: sense key: No Sense
>>>     Additional sense: No additional sense information
>>> Info fld=0x167ff
>>> ata1: command 0xca timeout, stat 0x50 host_stat 0x24
>>> ata1: status=0x50 { DriveReady SeekComplete }
> 
> Can you try to set the following config options as module:
> 
> Device Drivers  --->
>   SCSI device support  --->
>     SCSI low-level drivers  --->
>       AHCI SATA support
> 
> And
> 
> Device Drivers  --->
>   SCSI device support  --->
>     SCSI low-level drivers  --->
>       NVIDIA SATA support
>

Both are already build as modules, so the failure was with
them as modules.   I used the default type of config setup
from FC5 kernels which loves to build everything as
modules, since FC5 gets annoyed with things being build it.

                             Roger
