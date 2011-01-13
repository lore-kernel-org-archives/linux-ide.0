From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Why is only one command issue per time in AHCI driver?
Date: Thu, 13 Jan 2011 12:46:46 -0500
Message-ID: <4D2F3A86.3010503@garzik.org>
References: <AANLkTin5=NiZn6ZWZ=r-XS0v_Utrf6dpTb_YzCay-PJM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41278 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334Ab1AMRqu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Jan 2011 12:46:50 -0500
Received: by vws16 with SMTP id 16so697725vws.19
        for <linux-ide@vger.kernel.org>; Thu, 13 Jan 2011 09:46:49 -0800 (PST)
In-Reply-To: <AANLkTin5=NiZn6ZWZ=r-XS0v_Utrf6dpTb_YzCay-PJM@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?576F56eJ6Yie?= <luobingjiun@gmail.com>
Cc: linux-ide@vger.kernel.org

On 01/13/2011 05:52 AM, =E7=BE=85=E7=A7=89=E9=88=9E wrote:
> Hello,
>
> Inside ahci_qc_issue() function, I see that driver always write one b=
it
> to Px.CI register even enable the NCQ.
>
> AHCI allows to fire 32 commands at one time and AHCI driver also
> claims itself able to queue up to 31 commands.
>
> Inside ahci.c :
> static struct scsi_host_template ahci_sht =3D {
>         ATA_NCQ_SHT(DRV_NAME),
>         .can_queue              =3D AHCI_MAX_CMDS - 1,
> ............
>
> Why upper layer(Block or SCSI layer) does not fill up as many as poss=
ible
> commands into Command List before sending the commands out
> (Write to Px.CI register)?

The driver successfully executes up to 31 commands at a time, in parall=
e.

We submit one command at a time to hardware because the block layer=20
passes commands to us one at a time.

	Jeff



