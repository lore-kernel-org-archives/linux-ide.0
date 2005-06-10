From: kallol@nucleodyne.com
Subject: Re: Performance figure for sx8 driver
Date: Fri, 10 Jun 2005 10:39:00 -0400
Message-ID: <20050610103900.f5is8molgox28c4o@www.nucleodyne.com>
References: <20050608212425.8951j70kxbwpcs8c@www.nucleodyne.com>
	<42A7DD18.50004@pobox.com>
	<20050610103022.ajs6633qyv400sw4@www.nucleodyne.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from easyspace.ezspl.net ([216.74.109.141]:7892 "EHLO
	easyspace.ezspl.net") by vger.kernel.org with ESMTP id S262565AbVFJOjD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Jun 2005 10:39:03 -0400
In-Reply-To: <20050610103022.ajs6633qyv400sw4@www.nucleodyne.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kallol@nucleodyne.com
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

The following steps have been used to reproduce the problem.
I am not sure how hdparm worked on non-scsi or non-ide device.

> $ cat /proc/diskstats
>    1    0 ram0 0 0 0 0 0 0 0 0 0 0 0
>    1    1 ram1 0 0 0 0 0 0 0 0 0 0 0
>    1    2 ram2 0 0 0 0 0 0 0 0 0 0 0
>    1    3 ram3 0 0 0 0 0 0 0 0 0 0 0
>    1    4 ram4 0 0 0 0 0 0 0 0 0 0 0
>    1    5 ram5 0 0 0 0 0 0 0 0 0 0 0
>    1    6 ram6 0 0 0 0 0 0 0 0 0 0 0
>    1    7 ram7 0 0 0 0 0 0 0 0 0 0 0
>    1    8 ram8 0 0 0 0 0 0 0 0 0 0 0
>    1    9 ram9 0 0 0 0 0 0 0 0 0 0 0
>    1   10 ram10 0 0 0 0 0 0 0 0 0 0 0
>    1   11 ram11 0 0 0 0 0 0 0 0 0 0 0
>    1   12 ram12 0 0 0 0 0 0 0 0 0 0 0
>    1   13 ram13 0 0 0 0 0 0 0 0 0 0 0
>    1   14 ram14 0 0 0 0 0 0 0 0 0 0 0
>    1   15 ram15 0 0 0 0 0 0 0 0 0 0 0
>  160   64 sx8/2 1 0 8 10 0 0 0 0 0 10 10
>  160   65 sx8/2p1 0 0 0 0
>  160  128 sx8/4 1 0 8 20 0 0 0 0 0 20 20
>  160  129 sx8/4p1 0 0 0 0
>  160  192 sx8/6 1 0 8 20 0 0 0 0 0 20 20
>  160  193 sx8/6p1 0 0 0 0
>    3    0 hda 1 0 8 0 0 0 0 0 0 0 0
>    3    1 hda1 0 0 0 0
>
>  $ mknod /dev/sda b 160 64
> $ mknod /dev/sdb b 160 128
> $ mknod /dev/sdc b 160 192
>  $ ./hdparm -t /dev/sda &
> $./hdparm -t /dev/sdb
................

Quoting kallol@nucleodyne.com:

> Hello Jeff,
>            Changing CARM_MAX_Q to 30 and upgrading the firmware to
> firmware(BIOS-1.00.0.37, Firmware-1.3.19) does not help.
>
> Anything else to try?
>
> Kallol
>
> Quoting Jeff Garzik <jgarzik@pobox.com>:
>
>> kallol@nucleodyne.com wrote:
>>> Does anyone have performace figure for sx8 driver which is for 
>>> promise SATAII150
>>> 8 port PCI-X adapter?
>>>
>>> Someone reports that on a platform with sx8 driver, multiple hdparms on
>>> different disks those are connected to the same adapter (there are 
>>> 8 ports) can
>>> not get more than 45MB/sec in total, whereas a SCSI based driver 
>>> for the same
>>> adapter gets around 150MB/sec.
>>>
>>> Any comment on this?
>>
>> Known.  Early firmwares for SX8 had problems that forced the driver to
>> limit the number of outstanding requests, for all ports, to _one_.
>>
>> Later firmwares have fixed this, but the driver has not been updated to
>> detect newer(fixed) firmwares.
>>
>> You may update drivers/block/sx8.c as such:
>>
>> - CARM_MAX_Q              = 1,               /* one command at a time */
>> + CARM_MAX_Q              = 30,              /* 30 commands at a time */
>>
>> if you have a newer firmware, to obtain much better performance.
>>
>> 	Jeff
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>
>
>



