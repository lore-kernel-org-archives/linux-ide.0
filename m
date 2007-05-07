From: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Mon, 07 May 2007 17:05:40 -0300
Message-ID: <463F8694.4000708@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com> <460896D8.8040203@gmail.com> <460899D4.6070708@gmail.com> <4608A0BD.2010209@gmail.com> <463B019E.7010700@gmail.com> <463B71FA.8090005@gmail.com> <463B74DB.8060509@gmail.com> <463B89B9.8050104@gmail.com> <463B8B3C.9010509@gmail.com> <463CC22C.20902@gmail.com> <463CC52E.8050500@gmail.com> <463EF97D.1000805@gmail.com> <463F41E0.30009@gmail.com> <463F473B.90307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:15393 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966439AbXEGUFr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 16:05:47 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1515835wxd
        for <linux-ide@vger.kernel.org>; Mon, 07 May 2007 13:05:46 -0700 (PDT)
In-Reply-To: <463F473B.90307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, gregkh@suse.de

Tejun Heo escribi=F3:
> Mat=ED=ADas Alejandro Torres wrote:
>  =20
>> $ patch -p1 --dry-run <../patch
>>
>> patching file drivers/pci/quirks.c
>> Hunk #1 FAILED at 1624.
>> 1 out of 1 hunk FAILED -- saving rejects to file
>> drivers/pci/quirks.c.rej (empty file)
>>    =20
>
> The patch applies okay to 2.6.21.1.  Please apply it on top of
> unmodified 2.6.21.1.
>
> Thanks.

The patch works in 2.6.21.1,

[    0.000000] Kernel command line:=20
root=3DUUID=3D5875415d-590b-47be-8e7c-30e4c073c6d2 ro
=2E...
[    3.748000] PCI: MSI quirk detected. MSI deactivated.
=2E...
[    7.112000] PM: Adding info for No Bus:host1
[    7.596000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    7.596000] ata2.00: ATA-7: HDS728080PLA380, PF2OA6EA, max UDMA/133
[    7.596000] ata2.00: 160836480 sectors, multi 0: LBA48 NCQ (depth 31=
/32)
[    7.596000] ata2.00: configured for UDMA/133
[    7.596000] scsi2 : ahci

Thanks, Matias

