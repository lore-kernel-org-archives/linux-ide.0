From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata Sil3512 bug?;  Promise SATA300 TX4
Date: Fri, 19 Oct 2007 10:26:55 +0900
Message-ID: <471807DF.8010100@gmail.com>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info> <1785297944.20071017170444@zonnet.nl> <4717CB10.3080509@lxnt.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:21719 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbXJSB1B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 21:27:01 -0400
Received: by rv-out-0910.google.com with SMTP id k20so319856rvb
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 18:27:00 -0700 (PDT)
In-Reply-To: <4717CB10.3080509@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Sabourenkov <screwdriver@lxnt.info>
Cc: linux-ide@vger.kernel.org, MisterE <MisterE2002@zonnet.nl>, Mikael Pettersson <mikpe@it.uu.se>, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jgarzik@pobox.com, jeff@garzik.org

Hello,

Alexander Sabourenkov wrote:
> In a somewhat parallel development, write errors caused my (other) md
> RAID-1 to lose one drive while copying data under 2.6.22
> from TX4-attached drives to onboard-VIA-attached ones.
 >
> ... the first two port resets:
> 
> Oct 17 23:10:50 host ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0
> action 0x2
> Oct 17 23:10:50 host ata6.00: (BMDMA stat 0x4)
> Oct 17 23:10:50 host ata6.00: cmd ca/00:08:e7:30:00/00:00:00:00:00/e0
> tag 0 cdb 0x0 data 4096 out
> Oct 17 23:10:50 host res 51/84:08:e7:30:00/00:00:00:00:00/e0 Emask 0x10
> (ATA bus error)
> Oct 17 23:10:50 host ata6: soft resetting port
> Oct 17 23:10:50 host ata6.00: configured for UDMA/133
> Oct 17 23:10:50 host ata6: EH complete
[--snip--]
> Oct 17 23:13:37 host ata6: soft resetting port
> Oct 17 23:14:08 host ata6.00: qc timeout (cmd 0xec)
> Oct 17 23:14:08 host ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> Oct 17 23:14:08 host ata6.00: revalidation failed (errno=-5)
> Oct 17 23:14:08 host ata6.00: disabled
> Oct 17 23:14:08 host ata6: EH complete
> Oct 17 23:14:08 host sd 5:0:0:0: [sdd] Result: hostbyte=DID_BAD_TARGET
> driverbyte=DRIVER_OK,SUGGEST_OK
> Oct 17 23:14:08 host end_request: I/O error, dev sdd, sector 371769215
> Oct 17 23:14:08 host raid1: sdd1: rescheduling sector 371769152
> Oct 17 23:14:08 host sd 5:0:0:0: [sdd] Result: hostbyte=DID_BAD_TARGET
> driverbyte=DRIVER_OK,SUGGEST_OK
> Oct 17 23:14:08 host end_request: I/O error, dev sdd, sector 390379327
> Oct 17 23:14:08 host md: super_written gets error=-5, uptodate=0
> Oct 17 23:14:08 host raid1: Disk failure on sdd1, disabling device.
> 
> I'm unable to reproduce this on 2.6.23, so this is of historic interest
> only.

It might not have anything to do with the os and driver.  Some SATA 
controllers and/or drives aren't very reliable and they just fail from 
time to time.  My previous desktop was using sata_nv w/ seagate sata 
drives and was up 24/7.  I used it for like two years and during that 
time, there was single transfer error and it brought the drive down 
completely and I had to reboot and rebuild my RAID 1 array.  ISTR what's 
dead was the controller port.  IIRC, powering off and on the drive 
didn't help.

Another interesting case was first gen SATA harddrives from certain 
vendor.  After any transfer error, those drives went completely deaf. 
The only way to recover them was removing power, waiting a bit and 
reapplying it.

So, my bet for your second report is your hardware went through 
something similar as above.

Thanks.

-- 
tejun
