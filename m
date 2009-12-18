From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: kernel 2.6.31.1 + Sil 3512 + WDC WD5000AAKS-00V1A0 = no NCQ and
 UDMA5 instead of UDMA6
Date: Thu, 17 Dec 2009 22:10:58 -0500
Message-ID: <4B2AF2C2.9010708@pobox.com>
References: <4B2A3D25.9030209@hardwarefreak.com> <4B2A720B.2040809@pobox.com> <4B2AE779.9060109@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:40517 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbZLRDLC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 22:11:02 -0500
Received: by yxe17 with SMTP id 17so2556137yxe.33
        for <linux-ide@vger.kernel.org>; Thu, 17 Dec 2009 19:11:01 -0800 (PST)
In-Reply-To: <4B2AE779.9060109@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stan Hoeppner <stan@hardwarefreak.com>
Cc: linux-ide@vger.kernel.org

On 12/17/2009 09:22 PM, Stan Hoeppner wrote:
> Jeff Garzik put forth on 12/17/2009 12:01 PM:
>> On 12/17/2009 09:16 AM, Stan Hoeppner wrote:
>>> Hi Jeff,
>>>
>>> I recently added a Silicon Image 3512 based PCI card to an old Intel
>>> 440BX machine along with a single platter 500GB WD SATA2 drive.  I'd
>>> have gone with an ahci sata2 controller but couldn't find one in 33MHz
>>> PCI.  I compiled a new kernel, adding SCSI disk, libata and sata_sil
>>> support using make menuconfig and kernel.org sources installed the
>>> debian way on lenny 5.0.3.  I left the old piix diver in so I could
>>> still boot from the old IDE disk and move the entire Linux system over.
>>>    That all went pretty smoothly, I'm now booting from the new disk, and
>>> the sata subsystem is working pretty well, especially compared to the
>>> old 40GB Maxtor IDE disk (now removed from the system).
>>
>> sata_sil hardware does not support NCQ.
>>
>>      Jeff
>
> Dangit, I thought the 3512 was one of the SiI chips that did support it.
>    My mistake.  Is there anything else I can tweak to get more of this
> drive's performance or am I stuck with what I have?  My read of your
> default UDMA/100 comments is that it's a safety net type setting for the
> 3112.  Would bumping this to UDMA/133 give me any improvement over the
> PCI bus?  Is there anything else I could tweak?

Nope.  You are pretty much maxing out the drive, of whatever drive you 
plug in.  The sata bus -- at its hardware spec'd maximum -- is far 
faster than just about any drive, and the PCI bus is far faster than the 
sata bus.

You could probably max out the SATA bus with a RAM-based SATA device; 
that's it.

	Jeff


