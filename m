From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH] ata: piix: wait for end of asynchronous probing before
Date: Thu, 27 Oct 2016 13:55:19 -0500
Message-ID: <CAL_Jsq+HPd2Ftm7cDD4rpT6jx=EgS9nX+_WiwRcxhpPbi=85xQ@mail.gmail.com>
References: <1476722704-12839-1-git-send-email-clabbe.montjoie@gmail.com> <20161019172848.GD18532@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751169AbcJ0Szo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 27 Oct 2016 14:55:44 -0400
In-Reply-To: <20161019172848.GD18532@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wed, Oct 19, 2016 at 12:28 PM, Tejun Heo <tj@kernel.org> wrote:
> (cc'ing Greg and Rob)
>
> Hello,
>
> On Mon, Oct 17, 2016 at 06:45:04PM +0200, Corentin Labbe wrote:
>> Enabling CONFIG_DEBUG_TEST_DRIVER_REMOVE under qemu give me a WARN() trace.
>> Waiting for the end of the ATA RESET seems to clean the issue.
>> But I am not sure if my solution and the way to solve it are correct.
>>
>> Regards
>>
>> ---8<---
>> From b2d097130a9d67529075f6e3c3d9552ac5415d18 Mon Sep 17 00:00:00 2001
>> From: Corentin Labbe <clabbe.montjoie@gmail.com>
>> Date: Mon, 17 Oct 2016 17:50:02 +0200
>> Subject: [RFC PATCH] ata: piix: wait for end of asynchronous probing before
>>  removing
>>
>> Under qemu I got the following trace with CONFIG_DEBUG_TEST_DRIVER_REMOVE
>> [    1.092021] ata_piix 0000:00:01.1: version 2.13
>> [    1.093277] scsi host0: ata_piix
>> [    1.093720] scsi host1: ata_piix
>> [    1.094152] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc080 irq 14
>> [    1.094902] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc088 irq 15
>> [    1.252998] ------------[ cut here ]------------
>> [    1.253799] WARNING: CPU: 0 PID: 1 at drivers/ata/libata-core.c:6482 ata_host_detach+0x148/0x150
>
> I don't think it's correct to try to remove the driver while async
> probing is in progress and we shouldn't work around it from individual
> drivers.  I think we already have enough async barriers to prevents
> this under normal operation - there's full synchronization during boot
> before control gets passed to userland and module unloading does full
> async flushing too.  What we should do, probably, is to make the debug
> code do full async flush before test unloading the driver.

Seems like this is mixing async drv probe and async scsi scan and the
problem is in the latter? I don't think async drv probe should have
any problems. If a driver probe starts some async operation, then it
seems to me that it is its responsibility to wait for completion in
remove().

Rob
