From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Tue, 08 May 2007 10:07:32 +0200
Message-ID: <46402FC4.8020609@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com> <460896D8.8040203@gmail.com> <460899D4.6070708@gmail.com> <4608A0BD.2010209@gmail.com> <463B019E.7010700@gmail.com> <463B71FA.8090005@gmail.com> <463B74DB.8060509@gmail.com> <463B89B9.8050104@gmail.com> <463B8B3C.9010509@gmail.com> <463CC22C.20902@gmail.com> <463CC52E.8050500@gmail.com> <463EF97D.1000805@gmail.com> <463F41E0.30009@gmail.com> <463F473B.90307@gmail.com> <463F8694.4000708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:42202 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934564AbXEHIHs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 04:07:48 -0400
Received: by py-out-1112.google.com with SMTP id p76so1373893pyb
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 01:07:47 -0700 (PDT)
In-Reply-To: <463F8694.4000708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Cc: linux-ide@vger.kernel.org, gregkh@suse.de

Mat=ED=ADas Alejandro Torres wrote:
> The patch works in 2.6.21.1,
>=20
> [    0.000000] Kernel command line:
> root=3DUUID=3D5875415d-590b-47be-8e7c-30e4c073c6d2 ro
> ....
> [    3.748000] PCI: MSI quirk detected. MSI deactivated.
> ....
> [    7.112000] PM: Adding info for No Bus:host1
> [    7.596000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    7.596000] ata2.00: ATA-7: HDS728080PLA380, PF2OA6EA, max UDMA/13=
3
> [    7.596000] ata2.00: 160836480 sectors, multi 0: LBA48 NCQ (depth =
31/32)
> [    7.596000] ata2.00: configured for UDMA/133
> [    7.596000] scsi2 : ahci
>=20
> Thanks, Matias
>=20

Alright, thanks.  I'll submit the patch.

--=20
tejun
