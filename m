From: Gwendal Grignou <gwendal@google.com>
Subject: Handling Asynchronous Notification when IO are outstanding
Date: Mon, 8 Mar 2010 16:27:49 -0800
Message-ID: <e7510f761003081627o1134b77eud719e033f68488bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:51471 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080Ab0CIA1x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Mar 2010 19:27:53 -0500
Received: from kpbe18.cbf.corp.google.com (kpbe18.cbf.corp.google.com [172.25.105.82])
	by smtp-out.google.com with ESMTP id o290Rqa5019759
	for <linux-ide@vger.kernel.org>; Mon, 8 Mar 2010 16:27:52 -0800
Received: from qw-out-1920.google.com (qwc5.prod.google.com [10.241.193.133])
	by kpbe18.cbf.corp.google.com with ESMTP id o290RQ2R002794
	for <linux-ide@vger.kernel.org>; Mon, 8 Mar 2010 16:27:51 -0800
Received: by qw-out-1920.google.com with SMTP id 5so1680747qwc.28
        for <linux-ide@vger.kernel.org>; Mon, 08 Mar 2010 16:27:50 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

I am working with Marvell 7042 controller and SiI3276 port multiplier
[PMP] and would like to handle asynchronous notification [AN]
properly.
However, if a command is outstanding when the PMP raises an AN, the
port is frozen, preventing _autopsy_ error code from doing its work.

For example, here is a case where a disk has a power glitch behind a
port multiplier while a command is outstanding. The PMP detects the
signal loss and send an AN.
In sata_mv.c  mv_err_intr() is called and detect the notification: it
pushes info in error descriptor and call ata_port_schedule_eh() via
sata_async_notification().

However, when we enter ata_scsi_error(), if a command is outstanding,
__ata_port_freeze() is called, preventing  sata_scr_read() to succeed
in ata_eh_link_autopsy():


Feb 25 02:11:57 bdfl11 kernel: ata4.00: failed to read SCR 1 (Emask=0x40)
Feb 25 02:11:57 bdfl11 kernel: ata4.01: failed to read SCR 1 (Emask=0x40)
Feb 25 02:11:57 bdfl11 kernel: ata4.02: failed to read SCR 1 (Emask=0x40)
Feb 25 02:11:57 bdfl11 kernel: ata4.03: failed to read SCR 1 (Emask=0x40)
Feb 25 02:11:57 bdfl11 kernel: ata4.04: failed to read SCR 1 (Emask=0x40)
Feb 25 02:11:57 bdfl11 kernel: ata4.05: failed to read SCR 1 (Emask=0x40)
Feb 25 02:11:57 bdfl11 kernel: ata4.15: exception Emask 0x4 SAct 0x0
SErr 0x0 action 0x6 frozen
Feb 25 02:11:57 bdfl11 kernel: ata4.15: edma_err_cause=02000100
pp_flags=00000005, fis_cause=00008200
Feb 25 02:11:57 bdfl11 kernel: ata4.00: exception Emask 0x100 SAct 0x0
SErr 0x0 action 0x6 frozen
Feb 25 02:11:57 bdfl11 kernel: ata4.01: exception Emask 0x100 SAct 0x0
SErr 0x0 action 0x6 frozen
Feb 25 02:11:57 bdfl11 kernel: ata4.02: exception Emask 0x100 SAct 0x0
SErr 0x0 action 0x6 frozen
Feb 25 02:11:57 bdfl11 kernel: ata4.03: exception Emask 0x100 SAct 0x0
SErr 0x0 action 0x6 frozen
Feb 25 02:11:57 bdfl11 kernel: ata4.04: exception Emask 0x100 SAct 0x0
SErr 0x0 action 0x6 frozen
Feb 25 02:11:57 bdfl11 kernel: ata4.04: cmd
ca/00:80:e7:78:56/00:00:00:00:00/e8 tag 3 dma 65536 out
Feb 25 02:11:57 bdfl11 kernel: res 50/00:00:4e:10:45/00:00:00:00:00/e8
Emask 0x4 (timeout)
Feb 25 02:11:57 bdfl11 kernel: ata4.04: status: { DRDY }
Feb 25 02:11:57 bdfl11 kernel: ata4.05: exception Emask 0x100 SAct 0x0
SErr 0x0 action 0x6 frozen
Feb 25 02:11:57 bdfl11 kernel: ata4.15: hard resetting link
Feb 25 02:11:58 bdfl11 kernel: ata4.15: SATA link up 3.0 Gbps (SStatus
123 SControl 300)
Feb 25 02:11:58 bdfl11 kernel: ata4.00: hard resetting link

I haven't found the right solution to handle this problem yet:

1: removing __ata_port_freeze() in ata_scsi_error() unilaterally is
very dangerous, it opens a new race condition and may schedule the
error handler several time.
2: in sata_mv, we can not wait for commands to complete like we do for
NCQ, because in the case above, the command sent to the failed disk
will never come back.

I am thinking of waiting for all IO to complete on all port but the
impacted one(s), adding a new action in ehi descriptor to indicate an
AN is scheduled, and preventing the error to froze the port if only
IOs to the failed ports are outstanding.
Then _autopsy_ code would collect and decode SERROR register for the
failed port.

Is it the right approach?

Thanks,
Gwendal.
