From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH 1/2] libata: switch to using block layer tagging support
Date: Wed, 20 May 2009 12:42:22 -0700
Message-ID: <e7510f760905201242s3cb84154m6e9a5795fd2357c5@mail.gmail.com>
References: <20090520065942.GD11363@kernel.dk>
	 <20090520070038.GE11363@kernel.dk>
	 <da824cf30905201010h1424e414idc3b01ecf7682005@mail.gmail.com>
	 <e7510f760905201108l4486ff6foc560c1271ebee7a7@mail.gmail.com>
	 <1242845440.2881.74.camel@localhost.localdomain>
	 <4A1452E9.7000204@garzik.org> <4A145458.5080302@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:30943 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbZETTm1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 15:42:27 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id n4KJgSp0003887
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 12:42:28 -0700
Received: from bwz22 (bwz22.prod.google.com [10.188.26.22])
	by zps35.corp.google.com with ESMTP id n4KJgQJ4003162
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 12:42:26 -0700
Received: by bwz22 with SMTP id 22so618139bwz.37
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 12:42:25 -0700 (PDT)
In-Reply-To: <4A145458.5080302@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Grant Grundler <grundler@google.com>, Jens Axboe <jens.axboe@oracle.com>, linux-ide@vger.kernel.org, htejun@gmail.com

Jeff, you're right, I made some mistakes:
- Reading SiI3132 doc again, it only supports 32 command per port, so
the tags must be share among all the drives behind the same port.
But other chipset does support up to 128 commands per port.
- Jens' patch is working when all disks support NCQ. Only when we have
a mix of drives with or without NCQ we have a problem.

We can not have more than 16 devices per ata_port: a PMP can only have
15 device ports [Sata 2.6- 16.2], and we can not connect a PMP to
another one.

Gwendal.

On Wed, May 20, 2009 at 12:04 PM, Jeff Garzik <jeff@garzik.org> wrote:
> Jeff Garzik wrote:
>>
>> Well...   The limiting factor is "ATA command slots per SATA phy", which
>> defines $N active ATA commands per port.  If a SATA NCQ device is attached,
>> you may have $N active ATA commands queued.  If two SATA NCQ devices are
>> attached to a PMP, which is attached to the SATA controller, the two devices
>> share the limit of $N active ATA commands queued.  If 32 devices are
>> attached to a PMP, all 32 devices share the $N command queue limit.
>>
>> But additionally, as Tejun demonstrated, you might have a mix of NCQ and
>> non-NCQ devices attached to the PMP.
>>
>> Thus, it is a case of nested limits:
>>
>> - $N maximum active commands per port; typically N==32
>> - $M maximum active commands per device; typically N==1 or N==32
>
>
> Note that this applies /somewhat/ to mvsas as well:  mvsas has up to 16 "ATA
> register sets" that the OS driver may assign to various ATA devices on a
> single phy.
>
> This simulates the "command slot" concept on dedicated SATA+PMP+NCQ hardware
> like AHCI or sata_sil24.
>
> If you attach more than 16 ATA devices to a PMP, which is theoretically
> possible, then mvsas MUST fail discovery, because it cannot address that
> many ATA devices.
>
> But mvsas's different architecture means that it does not have similar
> "command slot" limits.
>
>        Jeff
>
>
>
>
