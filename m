From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: turn selectproc() method into dev_select() method
Date: Mon, 23 Mar 2009 13:47:03 +0300
Message-ID: <49C768A7.4010701@ru.mvista.com>
References: <200903191831.43621.sshtylyov@ru.mvista.com> <49C2688A.3070808@ru.mvista.com> <200903202002.55510.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:14806 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752598AbZCWKqP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Mar 2009 06:46:15 -0400
In-Reply-To: <200903202002.55510.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org

Bartlomiej Zolnierkiewicz wrote:

>>Hello, I wrote:

>>>Turn selectproc() method into dev_select() method by teaching it to =
write to the
>>>device register and moving it from 'struct ide_port_ops' to 'struct =
ide_tp_ops'.

>>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>[...]

>>>Index: linux-2.6/drivers/ide/trm290.c
>>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>--- linux-2.6.orig/drivers/ide/trm290.c
>>>+++ linux-2.6/drivers/ide/trm290.c
>>>@@ -171,10 +171,11 @@ static void trm290_prepare_drive (ide_dr
>>> 	local_irq_restore(flags);
>>> }
>>>=20
>>>-static void trm290_selectproc (ide_drive_t *drive)
>>>+static void trm290_dev_select(ide_drive_t *drive)
>>> {
>>> 	trm290_prepare_drive(drive, !!(drive->dev_flags & IDE_DFLAG_USING_=
DMA));
>>>-}
>>>+
>>>+	outb(drive->select | ATA_DEVICE_OBS, drive->hwif->io_ports.device_=
addr);}

>>    Oops, I keep forgetting about running checkpatch.pl first. :-<
>>    Bart, do I need to repost, or you can fix it while applying?

> fixed while applying

> ditto for:

> drivers/ide/ns87415.c:314: error: =E2=80=98ns87415_tp_ops=E2=80=99 un=
declared here (not in a function)
> make[1]: *** [drivers/ide/ns87415.o] Error 1
> make: *** [drivers/ide/ns87415.o] Error 2

    Since the patch has turned to ve fatally defective in yet another w=
ay,=20
I'll have to recast/resend it anyway...

MBR, Sergei
