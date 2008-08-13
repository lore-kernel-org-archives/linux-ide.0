From: Bokhan Artem <APTEM@ngs.ru>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Thu, 14 Aug 2008 02:58:20 +0700
Message-ID: <48A33CDC.3000809@ngs.ru>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru> <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru> <48A30920.5030803@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:48885 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbYHMT6X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 15:58:23 -0400
In-Reply-To: <48A30920.5030803@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

As it named RETRY, I set it to 0, "define SD_MAX_RETRIES        0"
But still got two retries. Any suggestions?

dd if=3D/dev/sda of=3D/dev/null bs=3D512 skip=3D20359137 count=3D1

Aug 13 15:50:02 ubuntu kernel: [  244.688030]          res=20
51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug 13 15:50:02 ubuntu kernel: [  244.688206] ata5: hard resetting link
Aug 13 15:50:02 ubuntu kernel: [  245.226248] ata5: SATA link up 3.0=20
Gbps (SStatus 123 SControl 300)
Aug 13 15:50:02 ubuntu kernel: [  245.306267] ata5.00: max_sectors=20
limited to 256 for NCQ
Aug 13 15:50:02 ubuntu kernel: [  245.388635] ata5.00: max_sectors=20
limited to 256 for NCQ
Aug 13 15:50:02 ubuntu kernel: [  245.388637] ata5.00: configured for=20
UDMA/133
Aug 13 15:50:02 ubuntu kernel: [  245.388643] sd 4:0:0:0: [sda] Result:=
=20
hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE,SUGGEST_OK
Aug 13 15:50:02 ubuntu kernel: [  245.388646] sd 4:0:0:0: [sda] Sense=20
Key : Medium Error [current] [descriptor]
Aug 13 15:50:02 ubuntu kernel: [  245.388649] Descriptor sense data wit=
h=20
sense descriptors (in hex):
Aug 13 15:50:02 ubuntu kernel: [  245.388651]         72 03 11 04 00 00=
=20
00 0c 00 0a 80 00 00 00 00 00
Aug 13 15:50:02 ubuntu kernel: [  245.388658]         01 36 a7 e0
Aug 13 15:50:02 ubuntu kernel: [  245.388661] sd 4:0:0:0: [sda] Add.=20
Sense: Unrecovered read error - auto reallocate failed
Aug 13 15:50:02 ubuntu kernel: [  245.388783] ata5: EH complete
Aug 13 15:50:02 ubuntu kernel: [  245.388722] sd 4:0:0:0: [sda]=20
1465149168 512-byte hardware sectors (750156 MB)
Aug 13 15:50:02 ubuntu kernel: [  245.388722] sd 4:0:0:0: [sda] Write=20
Protect is off
Aug 13 15:50:02 ubuntu kernel: [  245.388722] sd 4:0:0:0: [sda] Write=20
cache: enabled, read cache: enabled, doesn't support DPO or FUA

Aug 13 15:50:04 ubuntu kernel: [  247.117648]          res=20
51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug 13 15:50:04 ubuntu kernel: [  247.117824] ata5: hard resetting link
Aug 13 15:50:04 ubuntu kernel: [  247.659679] ata5: SATA link up 3.0=20
Gbps (SStatus 123 SControl 300)
Aug 13 15:50:04 ubuntu kernel: [  247.747372] ata5.00: max_sectors=20
limited to 256 for NCQ
Aug 13 15:50:04 ubuntu kernel: [  247.825139] ata5.00: max_sectors=20
limited to 256 for NCQ
Aug 13 15:50:04 ubuntu kernel: [  247.825141] ata5.00: configured for=20
UDMA/133
Aug 13 15:50:04 ubuntu kernel: [  247.825145] sd 4:0:0:0: [sda] Result:=
=20
hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE,SUGGEST_OK
Aug 13 15:50:04 ubuntu kernel: [  247.825148] sd 4:0:0:0: [sda] Sense=20
Key : Medium Error [current] [descriptor]
Aug 13 15:50:04 ubuntu kernel: [  247.825151] Descriptor sense data wit=
h=20
sense descriptors (in hex):
Aug 13 15:50:04 ubuntu kernel: [  247.825153]         72 03 11 04 00 00=
=20
00 0c 00 0a 80 00 00 00 00 00
Aug 13 15:50:04 ubuntu kernel: [  247.825160]         01 36 a7 e0
Aug 13 15:50:04 ubuntu kernel: [  247.825163] sd 4:0:0:0: [sda] Add.=20
Sense: Unrecovered read error - auto reallocate failed
Aug 13 15:50:04 ubuntu kernel: [  247.825281] ata5: EH complete
Aug 13 15:50:04 ubuntu kernel: [  247.825223] sd 4:0:0:0: [sda]=20
1465149168 512-byte hardware sectors (750156 MB)
Aug 13 15:50:04 ubuntu kernel: [  247.825223] sd 4:0:0:0: [sda] Write=20
Protect is off
Aug 13 15:50:04 ubuntu kernel: [  247.825223] sd 4:0:0:0: [sda] Write=20
cache: enabled, read cache: enabled, doesn't support DPO or FUA



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

