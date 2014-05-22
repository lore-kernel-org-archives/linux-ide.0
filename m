From: Alan Evans <alanwevans@gmail.com>
Subject: Re: ahci: host/target numbers change with detection order
Date: Thu, 22 May 2014 13:14:56 -0600
Message-ID: <CAMFVOoVxo0guq3=T1skwZKxiOwNc01q79Xtu8wLNhqH-jYOKxQ@mail.gmail.com>
References: <CAMFVOoU=nbVSzZPU0eJ6Gy=yFNdWQfctANjfQyVjAp0hJFzDrA@mail.gmail.com>
	<537CC35A.6060505@ubuntu.com>
Reply-To: AlanWEvans@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:55253 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbaEVTO5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 May 2014 15:14:57 -0400
Received: by mail-qc0-f173.google.com with SMTP id i8so6421130qcq.18
        for <linux-ide@vger.kernel.org>; Thu, 22 May 2014 12:14:56 -0700 (PDT)
In-Reply-To: <537CC35A.6060505@ubuntu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: linux-ide@vger.kernel.org

Phillip,

Thank you very much for your help.

>From the look of it port_no was added to ata_port in kernel 3.11.  It
looks like I am out of luck without upgrading or back porting it
myself.  I guess I'll have to weight my options.

Thanks again,
-Alan

On Wed, May 21, 2014 at 9:16 AM, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 5/19/2014 4:46 PM, Alan Evans wrote:
>> I have a host that is used to process the data on removable
>> drives. It is essential to be able to indicate to an operator which
>> drives are done and can be removed.
>>
>> When we were using a HighPoint card that uses sata_mv.ko we could
>> count on the results of 'udevadm info -q path -n <dev>'
>> representing a single physical port on the card.
>>
>> I have been testing a new card based on a Marvell 88SE9230
>> (ahci.ko) and I find that the scsi host number and corresponding
>> target are changing depending on the order drives are attached to
>> the system, not based on the port number.
>
> These numbers are assigned on a first come first serve basis, so if
> another device initializes first, then it jumps in front.  If you want
> to know the port number, look in the port_no file of the ata_port.
>
>> Further for some reason in /sys/class/scsi_host I am seeing 8
>> hosts created per card where I would expect 4.
>
> Apparently the controller supports 8 ports.
>
>> Does anyone have any thoughts on why the behaviour differs between
>> ahci.ko and sata_mv.ko?  Is it the chip?  The module?
>
> It looks like sata_mv does not support parallel scanning of all ports,
> but ahci does.  In other words, sata_mv scanned one port at a time, in
> order, so they always registered in order, but ahci scans them all at
> the same time, so the order they finish in varies.
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.17 (MingW32)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iQEcBAEBAgAGBQJTfMNaAAoJEI5FoCIzSKrwG0UH/Rrkh25BSA+3vqj6aQUDW0Ox
> Fyeklgj+inohLzed5ZmGur2vfr8GA5Xrs1vO6Sk6hvDVadRhcyt45qkxAlVT09YS
> vwXAQQQoIXzbiqetX7TJYJwo5TzCc3mIjUJjHrpfPrbUc43gs89yuqKpGubXurQp
> N+QUPI4X1U6HRORsbFO9WfzZT3hvj99Nv0KmoDQUaSkhOS7lOqEPep1v42HflJLF
> DlHmJmsuQmAy7fn4i2MpllnJx99EdpeFgPi2GdsPWi8gOBviuPMz0AWclUwY4K/q
> SD0mHDrj+w/kE9wqJNUs2etkCNYMZwyfin1jxLyVaioiK8OFXkcoYyObGI79TzI=
> =758u
> -----END PGP SIGNATURE-----
