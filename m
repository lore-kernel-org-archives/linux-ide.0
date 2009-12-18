From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: kernel 2.6.31.1 + Sil 3512 + WDC WD5000AAKS-00V1A0 = no NCQ and
 UDMA5 instead of UDMA6
Date: Thu, 17 Dec 2009 20:22:49 -0600
Message-ID: <4B2AE779.9060109@hardwarefreak.com>
References: <4B2A3D25.9030209@hardwarefreak.com> <4B2A720B.2040809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:60355 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbZLRCWu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 21:22:50 -0500
In-Reply-To: <4B2A720B.2040809@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik put forth on 12/17/2009 12:01 PM:
> On 12/17/2009 09:16 AM, Stan Hoeppner wrote:
>> Hi Jeff,
>>
>> I recently added a Silicon Image 3512 based PCI card to an old Intel
>> 440BX machine along with a single platter 500GB WD SATA2 drive.  I'd
>> have gone with an ahci sata2 controller but couldn't find one in 33MHz
>> PCI.  I compiled a new kernel, adding SCSI disk, libata and sata_sil
>> support using make menuconfig and kernel.org sources installed the
>> debian way on lenny 5.0.3.  I left the old piix diver in so I could
>> still boot from the old IDE disk and move the entire Linux system over.
>>   That all went pretty smoothly, I'm now booting from the new disk, and
>> the sata subsystem is working pretty well, especially compared to the
>> old 40GB Maxtor IDE disk (now removed from the system).
> 
> sata_sil hardware does not support NCQ.
> 
>     Jeff

Dangit, I thought the 3512 was one of the SiI chips that did support it.
  My mistake.  Is there anything else I can tweak to get more of this
drive's performance or am I stuck with what I have?  My read of your
default UDMA/100 comments is that it's a safety net type setting for the
3112.  Would bumping this to UDMA/133 give me any improvement over the
PCI bus?  Is there anything else I could tweak?

Thanks Jeff.

--
Stan
