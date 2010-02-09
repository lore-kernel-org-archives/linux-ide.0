From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: "raid5:md0: read error not correctable (sector 795463080 on sdf1)"
  error on controller with SIL 3114
Date: Mon, 08 Feb 2010 23:13:33 -0600
Message-ID: <4B70EEFD.1040603@gmail.com>
References: <a01a16b51002080311i420f6429ld3545c44c04603eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:60447 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab0BIFNg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Feb 2010 00:13:36 -0500
Received: by iwn12 with SMTP id 12so8223553iwn.26
        for <linux-ide@vger.kernel.org>; Mon, 08 Feb 2010 21:13:35 -0800 (PST)
In-Reply-To: <a01a16b51002080311i420f6429ld3545c44c04603eb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?SMOla29uIEzDuHZkYWw=?= <hlovdal@gmail.com>
Cc: linux-ide@vger.kernel.org

On 02/08/2010 05:11 AM, H=C3=A5kon L=C3=B8vdal wrote:
> Hi. I have had some trouble with the machine I want to have as a file=
 server.
>
> After having let the "get raid up and running reliably" project lie
> dormant for some time, I tried again this Friday. After connecting th=
e
> disks, the status was the following: 4 out of 6 disk in a raid6 setup
> were recognised (see log-1). I was able to mount the volume when the
> machine was finished booting.
>
> I then added the two missing disks with mdadm, one of them started
> rebuilding and the other one were not recognised in some way (log-2).
> The rebuild of the disk was successfull (log-3), but later some error=
s
> occured, see log-4 below, and now only three disks are left in the
> array (log-5).
>
> Are these errors related to Tejun's recent statement "Sil3112/3114 ar=
e
> now virtually the only controllers with occassional and unresolved da=
ta
> corruption issues."? Disks sda (hosting root file system for os), sdb
> sdc and sdd are connected the motherboard while sde, sdf and sdg are
> connected to a controller card using 3114:

=2E.

> ---BEGIN log-4---
> Feb  6 07:09:57 localhost kernel: ata8.00: exception Emask 0x0 SAct
> 0x0 SErr 0x0 action 0x0
> Feb  6 07:09:57 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
> Feb  6 07:09:57 localhost kernel: ata8.00: cmd
> 25/00:80:cf:cd:69/00:00:2f:00:00/e0 tag 0 dma 65536 in
> Feb  6 07:09:57 localhost kernel:         res
> 51/40:00:e4:cd:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
> Feb  6 07:09:57 localhost kernel: ata8.00: status: { DRDY ERR }
> Feb  6 07:09:57 localhost kernel: ata8.00: error: { UNC }

That's fairly definitive, uncorrected read error reported by the drive.=
=20
You might want to check its SMART status. Could be a bad drive, or=20
potentially other causes like excessive vibration, high temperature,=20
power issues..
