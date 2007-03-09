From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: sata_promise SATA300TX4 "intermittent problems"
Date: Fri, 9 Mar 2007 09:01:50 +0200 (EET)
Message-ID: <40739.194.237.142.21.1173423710.squirrel@ncircle.nullnet.fi>
References: <45EECD12.1000506@how.dk>
    <17903.7366.875191.751728@alkaid.it.uu.se> <45F0393D.80301@how.dk>
    <45F0FE4C.7060901@how.dk>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:57782 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993021AbXCIHBz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 02:01:55 -0500
Received: from ncircle.nullnet.fi (a80-186-77-174.elisa-laajakaista.fi [80.186.77.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id D53E22BF76
	for <linux-ide@vger.kernel.org>; Fri,  9 Mar 2007 09:01:51 +0200 (EET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ncircle.nullnet.fi (Postfix) with ESMTP id 9C2FA1578C6
	for <linux-ide@vger.kernel.org>; Fri,  9 Mar 2007 09:01:51 +0200 (EET)
Received: from ncircle.nullnet.fi ([127.0.0.1])
	by localhost (alderan.ncircle.nullnet.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ls9AcveObP9W for <linux-ide@vger.kernel.org>;
	Fri,  9 Mar 2007 09:01:50 +0200 (EET)
Received: from ncircle.nullnet.fi (localhost.localdomain [127.0.0.1])
	by ncircle.nullnet.fi (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Fri,  9 Mar 2007 09:01:50 +0200 (EET)
In-Reply-To: <45F0FE4C.7060901@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,

> Peter Favrholdt wrote:
>> My feeling is this is not caused by 1.5Gbps or 3.0Gbps operation.
>> <...snip>
>> My next test will be a plain 2.6.21rc2. Then I'll apply the patches one
>> by one.
>
> I've tested 2.6.21-rc2 which fails (sdc down after 27 minutes & sdd down
> after 46 minutes).

I've now been running with 2.6.21-rc2-git1 + Mikaels original "patch
bundle" for 7 days without hangs! The machine has 2 Seagate 7200.7 disks
and 2 Seagate 7200.10 (in 3.0Gps mode) with Promise Sata300TX4. The system
does spit the following messages whenever there is load (no hickups user
noticiable hickups however):

Mar  4 03:51:13 alderan kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x0
Mar  4 03:51:13 alderan kernel: ata4.00: cmd
25/00:00:3f:0e:a8/00:04:09:00:00/e0 tag 0 cdb 0x0 data 524288 in
Mar  4 03:51:13 alderan kernel:          res
50/00:00:3e:12:a8/00:00:09:00:00/e0 Emask 0x1 (device error)
Mar  4 03:51:13 alderan kernel: ata4.00: configured for UDMA/133
Mar  4 03:51:13 alderan kernel: ata4: EH complete
Mar  4 03:51:13 alderan kernel: SCSI device sdd: 976773168 512-byte hdwr
sectors (500108 MB)
Mar  4 03:51:13 alderan kernel: sdd: Write Protect is off
Mar  4 03:51:13 alderan kernel: SCSI device sdd: write cache: enabled,
read cache: enabled, doesn't support DPO or FUA


>
> Then I applied just a single patch to 2.6.21-rc2: Mikael Petterssons
> patch to force 1.5Gbps operation and tested again - this time no
> problems at all!
>
> (BTW: both kernels are running with IO-APIC disabled).

I have io-apic enabled, Asus A7V880 (Via KT880-chipset).
In the past, when ever one of the disks failed, it _never_ was
the first disk on the linux system (although I don't remember if it was
connected to promise-cards first port as the ports are still numbered in
some very pecualiar way under linux).

Regards,
Tomi Orava

-- 


