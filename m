From: Tony Battersby <tonyb@cybernetics.com>
Subject: Re: AHCI problem with hotplug
Date: Fri, 09 Jan 2009 11:30:05 -0500
Message-ID: <49677B8D.7060807@cybernetics.com>
References: <494178E3.6030305@cybernetics.com> <49588784.4020808@kernel.org> <4958E3DC.7080009@cybernetics.com> <49591710.7040102@shaw.ca> <49596D9E.3040904@kernel.org> <495D8606.5070807@kernel.org> <4964CCBF.5030408@cybernetics.com> <49655FBA.3060005@kernel.org> <49660B9F.4010408@cybernetics.com> <496696B2.7010006@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host64.cybernetics.com ([98.174.209.230]:2439 "EHLO
	mail.cybernetics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbZAIQaI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jan 2009 11:30:08 -0500
In-Reply-To: <496696B2.7010006@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Robert Hancock wrote:
> Tony Battersby wrote:
>   
>> Tejun Heo wrote:
>>     
>>> Hello,
>>>
>>> Tony Battersby wrote:
>>>   
>>>       
>>>> Sorry it took so long.  I have attached the output of lspci when booting
>>>> without a SATA disk attached, and also when booting with a SATA disk
>>>> attached.
>>>>     
>>>>         
>>> 00:1f.2 SATA controller [0106]: Intel Corporation 82801GR/GH (ICH7 Family) SATA AHCI Controller [8086:27c1] (rev 01) (prog-if 01 [AHCI 1.0])
>>> ...
>>> 90: 40 00 11 10 80 01 00 40 00 00 00 00 00 00 00 00
>>>           ^^^^^
>>> 	  PCS 0x1011
>>>
>>> Port 0 and 4 enabled and 4 present.  Does "setpci -s 1f.2 93b=f" fix
>>> hotplugging?
>>>
>>>   
>>>       
>> setpci gives the following error:
>>
>> pcilib: sysfs_write: tried to write 1 bytes at 2363, but only 0 succeeded
>>
>> lspci shows no difference before and after.
>>     
>
> I assume that was done as root?
>
>   
Yes, done as root.

I am not really familiar with setpci, but apparently 93b and 93.b mean
different things, and I suspect you probably meant 93.b.  Also, if the
goal is to set the indicated PCS register to the same value it has when
hotplugging does work, then the command that does that is "setpci -s
1f.2 92.b=01" or "setpci -s 1f.2 92.b=11".  However, this command still
does not help.  Below are some more details of what I tried.

boot with disk plugged into first SATA port
lspci -nxxx -s 1f.2

HEXDUMP #1
00:1f.2 0106: 8086:27c1 (rev 01)
00: 86 80 c1 27 07 04 b0 02 01 01 06 01 00 00 00 00
10: 99 68 00 00 7d 68 00 00 91 68 00 00 79 68 00 00
20: 81 68 00 00 00 04 00 ed 00 00 00 00 d9 15 80 77
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 02 00 00
40: 07 a3 00 80 00 00 00 00 01 00 01 00 00 00 00 00
50: 00 00 00 00 11 10 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 02 40 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 70 01 00 0c 30 e0 fe 89 41 00 00 00 00 00 00
90: 40 00 11 10 80 01 00 40 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 05 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

unplug disk; hot unplug detected
lspci -nxxx -s 1f.2

HEXDUMP #2 (diff to HEXDUMP #1)
-90: 40 00 11 10 80 01 00 40 00 00 00 00 00 00 00 00
+90: 40 00 01 10 80 01 00 40 00 00 00 00 00 00 00 00

plug disk back into first SATA port; hotplug detected
lspci -nxxx -s 1f.2

(identical to HEXDUMP #1)



boot with disk not plugged in
lspci -nxxx -s 1f.2

HEXDUMP #3
00:1f.2 0106: 8086:27c1 (rev 01)
00: 86 80 c1 27 07 04 b0 02 01 01 06 01 00 00 00 00
10: 99 68 00 00 7d 68 00 00 91 68 00 00 79 68 00 00
20: 81 68 00 00 00 04 00 ed 00 00 00 00 d9 15 80 77
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 02 00 00
40: 00 80 00 80 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 02 40 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 70 01 00 0c 30 e0 fe 89 41 00 00 00 00 00 00
90: 40 00 0f 10 80 01 00 40 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 05 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

diff between HEXDUMP #1 and HEXDUMP #3
-40: 07 a3 00 80 00 00 00 00 01 00 01 00 00 00 00 00
+40: 00 80 00 80 00 00 00 00 00 00 00 00 00 00 00 00
-50: 00 00 00 00 11 10 00 00 00 00 00 00 00 00 00 00
+50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-90: 40 00 11 10 80 01 00 40 00 00 00 00 00 00 00 00
+90: 40 00 0f 10 80 01 00 40 00 00 00 00 00 00 00 00

plug disk into first SATA port; no hotplug detected
lspci -nxxx -s 1f.2

HEXDUMP #4 (diff to HEXDUMP #3)
-90: 40 00 0f 10 80 01 00 40 00 00 00 00 00 00 00 00
+90: 40 00 1f 10 80 01 00 40 00 00 00 00 00 00 00 00

However, unplugging the disk does not clear the bit that was set by
plugging in the disk.  Also, /proc/interrupts shows 0 AHCI interrupts.


Reboot with disk not plugged in to clear the bit that was set by
plugging in the disk.
lspci -nxxx -s 1f.2

identical to HEXDUMP #3

setpci -s 1f.2 92.b=01
lspci -nxxx -s 1f.2

HEXDUMP #5 (diff to HEXDUMP #3)
-90: 40 00 0f 10 80 01 00 40 00 00 00 00 00 00 00 00
+90: 40 00 01 10 80 01 00 40 00 00 00 00 00 00 00 00

plug disk into first SATA port; no hotplug detected
lspci -nxxx -s 1f.2

HEXDUMP #6 (diff to HEXDUMP #5)
-90: 40 00 01 10 80 01 00 40 00 00 00 00 00 00 00 00
+90: 40 00 11 10 80 01 00 40 00 00 00 00 00 00 00 00

comparing this to HEXDUMP #1:
-40: 07 a3 00 80 00 00 00 00 01 00 01 00 00 00 00 00
+40: 00 80 00 80 00 00 00 00 00 00 00 00 00 00 00 00
-50: 00 00 00 00 11 10 00 00 00 00 00 00 00 00 00 00
+50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

So the PCS register is the same, but still no hotplug detected.

However, unplugging the disk does not clear the bit that was set by
plugging in the disk.  Also, /proc/interrupts shows 0 ahci interrupts.

I also tried the following, without knowing what it would do:

setpci -s 1f.2 40.b=07
setpci -s 1f.2 41.b=a3
setpci -s 1f.2 48.b=01
setpci -s 1f.2 4a.b=01
setpci -s 1f.2 54.b=11
setpci -s 1f.2 55.b=10
setpci -s 1f.2 92.b=01

lspci -nxxx -s 1f.2 is now identical to HEXDUMP #1

However, disk hotplug is still not detected, and /proc/interrupts still
shows 0 ahci interrupts.

Tony

