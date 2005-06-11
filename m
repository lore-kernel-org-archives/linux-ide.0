From: kallol@nucleodyne.com
Subject: Fwd: Re: Performance figure for sx8 driver
Date: Sat, 11 Jun 2005 02:18:14 -0400
Message-ID: <20050611021814.riaatwh8ztskw4g4@www.nucleodyne.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from easyspace.ezspl.net ([216.74.109.141]:6087 "EHLO
	easyspace.ezspl.net") by vger.kernel.org with ESMTP id S261553AbVFKGSC
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Jun 2005 02:18:02 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org




Hello Jeff,
           How did you verify that performance improved making the
changes those
you suggested?

hdparm does not show it.

Regards,
Kallol

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
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>





----- End forwarded message -----

