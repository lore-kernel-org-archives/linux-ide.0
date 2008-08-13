From: Bokhan Artem <APTEM@ngs.ru>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Thu, 14 Aug 2008 00:37:32 +0700
Message-ID: <48A31BDC.8070203@ngs.ru>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru> <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru> <48A30920.5030803@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:45999 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbYHMRhf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 13:37:35 -0400
In-Reply-To: <48A30920.5030803@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

It's very strange for me that it is not runtime configurable... OK, thn=
x.

Also I'm not very close to ata protocols, so :
1. Why there is need to reset link if sector can not be read?
2. Why device is locked until hard reset?

Aug 13 08:45:45 ubuntu kernel: [ 5634.080692] sd 4:0:0:0: [sde]=20
1465149168 512-byte hardware sectors (750156 MB)
Aug 13 08:45:46 ubuntu kernel: [ 5635.088067]          res=20
40/00:08:e0:a7:36/01:00:01:00:00/00 Emask 0x4 (timeout)
Aug 13 08:45:46 ubuntu kernel: [ 5635.088136] ata5: hard resetting link



Mark Lord =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Artem Bokhan wrote:
>> When I run 'dd if=3D/dev/sda of=3D/dev/null skip=3D9700 bs=3D1M' and=
 it meets=20
>> bad block, it takes about=20
>> '/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:02.0/host=
4/target4:0:0/4:0:0:0/timeout=20
>> + about 10 seconds' to determine I/O error. Until that IO to device=20
>> is locked, as I understand. I want to reduce the time of lock as =20
>> much as possible.
> ..
>
> Tell the SCSI layer to stop flogging the drive with unnecessary retri=
es.
> A quick and dirty way, is this patch below, but it really should be m=
ore
> intelligent than this for some situations:
>
> --- linux/include/scsi/sd.h.orig    2008-06-09 14:27:19.000000000 -04=
00
> +++ linux/include/scsi/sd.h    2008-08-13 12:16:01.000000000 -0400
> @@ -23,7 +23,7 @@
> /*
>  * Number of allowed retries
>  */
> -#define SD_MAX_RETRIES        5
> +#define SD_MAX_RETRIES        1
> #define SD_PASSTHROUGH_RETRIES    1
>
> /*

