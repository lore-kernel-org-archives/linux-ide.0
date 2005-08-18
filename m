From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: when are buffers/caches flushed?
Date: Thu, 18 Aug 2005 13:34:01 +0200
Message-ID: <43047229.7010007@imc-berlin.de>
References: <43046817.803@imc-berlin.de> <43046FD2.4080401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:22287 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S932200AbVHRLeF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 07:34:05 -0400
In-Reply-To: <43046FD2.4080401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:

> Steven Scholz wrote:
>=20
>> Hi there,
>>
>> According to an (old) man page of sync(2)
>>
>>        According to  the  standard  specification  (e.g.,  SVID),
>>        sync()  schedules  the  writes,  but may return before the
>>        actual writing is done.   However,  since  version  1.3.20
>>        Linux  does actually wait.  (This still does not guarantee
>>        data integrity: modern disks have large caches.)
>>
>> How about recent kernels? Does sync() block until buffers are flushe=
d?
>> How can I find out if the disk caches are actually flushed?
>>
>> I want to make sure that all data is flushed to my disk drive before=
=20
>> powering down the system.
>>
>> Thanks.
>>
>=20
>  All disk caches are flushed before shutdown via the following path.
>=20
> kernel/sys.c::sys_reboot()
> kernel/drivers/base/power/shutdown.c::device_shutdown()
>  driver specific ->shutdown callback, for ide disks, the path is
> drivers/ide/ide-disk.c::ide_device_shutdown()
> drivers/ide/ide-disk.c::ide_cacheflush_p()
> drivers/ide/ide-disk.c::do_idedisk_flushcache()
>=20
>  And, AFAIK, sync() doesn't flush disk caches.

How about umount?

--
Steven




--=20
Steven Scholz

imc Measurement & Control               imc Me=DFsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland
