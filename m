From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Seagate SATA disk flush cache timeout issue
Date: Sun, 22 Apr 2012 00:19:06 -0600
Message-ID: <4F93A2DA.2050307@gmail.com>
References: <201204131039173121876@rd.bstar.com.cn>, <201204131039534213981@rd.bstar.com.cn>, <201204131053446718483@bstar.com.cn> <201204161031454684853@bstar.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45973 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab2DVGTI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2012 02:19:08 -0400
Received: by iadi9 with SMTP id i9so585108iad.19
        for <linux-ide@vger.kernel.org>; Sat, 21 Apr 2012 23:19:08 -0700 (PDT)
In-Reply-To: <201204161031454684853@bstar.com.cn>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?55Sw5b+X5Luy?= <tzz@bstar.com.cn>
Cc: linux-ide <linux-ide@vger.kernel.org>

On 04/15/2012 08:31 PM, =E7=94=B0=E5=BF=97=E4=BB=B2 wrote:
> Hi,
>
> I'm working on an embedded linux DVR product and its kernel is based =
on 2.6.24. During recent testing I found several SATA disk IO errors wh=
ile read/write disks for long time, e.g. about 24 hours.
>
> I find three kinds of Seagate SATA disk have such problem. They are
> ST2000DL003 (Barracuda Green / 2TB   / 5900rpm / 64M cache  / 4KB per=
 sector)
> ST500DM002  (Barracuda Green / 500G / 7200rpm / 16M cache  / 4KB per =
sector)
> ST1000526SV (SV35 series       / 1TB   / 7200rpm / 32M cache  / 512B =
per sector).
>
> The kernel output is alike below.
> ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata4.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>           res 40/00:01:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata4.00: status: { DRDY }
> ata4: port is slow to respond, please be patient (Status 0xd0)
> ata4: device not ready (errno=3D-16), forcing hardreset
> ata4: hard resetting link
> ata4: port is slow to respond, please be patient (Status 0xff)
> ata4: COMRESET failed (errno=3D-16)
> ata4: hard resetting link
> ata4: port is slow to respond, please be patient (Status 0xff)
> ata4: COMRESET failed (errno=3D-16)
> ata4: hard resetting link
> ata4: port is slow to respond, please be patient (Status 0xff)
> ata4: COMRESET failed (errno=3D-16)
> ata4: hard resetting link
> ata4: COMRESET failed (errno=3D-16)
> ata4: reset failed, giving up
> ata4.00: disabled
> ata4: EH complete
>
> I analyzed the kernel output and got its reason is ATA_CMD_FLUSH_EXT =
command timeout.
> I tried adding SCSI flush cache command timeout to 120 seconds and re=
trying 5 times when the command is timed out, the symptom was still hap=
pened.
> I tried adding ATA_CMD_FLUSH_EXT timeout to 120 seconds becuase of th=
e specification of ATA8, the symptom was still happened.
>
> There is a very strange symptom that is before the failed ATA_CMD_FLU=
SH_EXT(cmd ea) command, the last command must be ATA_CMD_VERIFY(cmd 40)=
=2E

Do you know what is issuing verify commands?

It seems like the drive is just ceasing to respond after that command=20
gets issued. Could be a drive firmware problem or something similar. Bu=
t=20
you could try a newer kernel version and see if the behavior changes.

> In most kernel outputs, the sector LBAs that ATA_CMD_VERIFY accessed =
are in a very narrow range (from 0xC24F00 to 0xC24F09), even for differ=
ent disk modles, such as ST2000DL003 and ST1000526SV.
>
> I also found same symptom in debian buglist http://bugs.debian.org/cg=
i-bin/bugreport.cgi?bug=3D625922
>
> Can you give me some suggestion on this issue?
>
> Thanks.
>
> Tony Tian
>
> 2012-04-16
>
>
> tzz@bstar.com.cn
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

