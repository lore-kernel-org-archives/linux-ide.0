From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: sata_sil24 driver / Sil3132 controller fails on powerpc
Date: Fri, 1 Apr 2011 18:56:24 +0200
Message-ID: <AANLkTimsDOSJTGr6JxgkzqT15XpGNzKdBXav_+Yjkpz2@mail.gmail.com>
References: <AANLkTikuC3PxPhiH7xNEomaoF-MKx0+VVwgz6YMwyxvj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61167 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab1DAQ40 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Apr 2011 12:56:26 -0400
Received: by fxm17 with SMTP id 17so2737514fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 01 Apr 2011 09:56:25 -0700 (PDT)
In-Reply-To: <AANLkTikuC3PxPhiH7xNEomaoF-MKx0+VVwgz6YMwyxvj@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

On Fri, Apr 1, 2011 at 1:52 PM, Leon Woestenberg
<leon.woestenberg@gmail.com> wrote:
>
> I see the sata_sil24 / Sil 3132 fail on my system.
>
To add evidence, I tested against a Samsung 2.5" SATA drive instead of
an Intel SSD.

I also enabled libata debug logging.

The controller just seems to stop generating interrupts or similar,
and commands start to time-out.

Here is a kernel log dump of dd if=/dev/sda of=/dev/null bs=32k count=30000

Timeout occured at [  168.899156]:

[  138.665674] ata_sg_clean: unmapping 2 sg elements
[  138.674312] ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 93 c0 00 01 00
[  138.680923] ata_scsi_translate: ENTER
[  138.684577] scsi_10_lba_len: ten-byte command
[  138.688927] ata_sg_setup: ENTER, ata2
[  138.692581] ata_sg_setup: 2 sg elements mapped
[  138.697020] ata_scsi_translate: EXIT
[  138.701368] ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 94 c0 00 01 00
[  138.707980] ata_scsi_translate: ENTER
[  138.711634] scsi_10_lba_len: ten-byte command
[  138.715984] ata_sg_setup: ENTER, ata2
[  138.719637] ata_sg_setup: 2 sg elements mapped
[  138.724077] ata_scsi_translate: EXIT
[  168.899156] ata_scsi_timed_out: ENTER
[  168.902817] ata_scsi_timed_out: EXIT, ret=0
[  168.906991] ata_scsi_timed_out: ENTER
[  168.910644] ata_scsi_timed_out: EXIT, ret=0
[  168.914835] ata_scsi_error: ENTER
[  168.918153] __ata_port_freeze: ata2 port frozen
[  168.922688] ata_eh_link_autopsy: ENTER
[  168.926441] ata_eh_link_autopsy: EXIT
[  168.930105] ata2.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
[  168.937156] ata2.00: failed command: READ FPDMA QUEUED
[  168.942306] ata2.00: cmd 60/00:00:c0:93:00/01:00:00:00:00/40 tag 0
ncq 131072 in
[  168.942311]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  168.957086] ata2.00: status: { DRDY }
[  168.960746] ata2.00: failed command: READ FPDMA QUEUED
[  168.965894] ata2.00: cmd 60/00:08:c0:94:00/01:00:00:00:00/40 tag 1
ncq 131072 in
[  168.965899]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  168.980673] ata2.00: status: { DRDY }
[  168.984335] ata_eh_recover: ENTER
[  168.987651] __ata_port_freeze: ata2 port frozen
[  168.992180] ata2: hard resetting link
[  171.195167] sil24_softreset: ENTER
[  171.211173] ata_dev_classify: found ATA device by sig
[  171.216229] sil24_softreset: EXIT, class=1
[  171.220332] ata_eh_thaw_port: ata2 port thawed
[  171.224771] ata_std_postreset: ENTER
[  171.228351] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  171.234354] ata_std_postreset: EXIT
[  171.237843] ata_eh_revalidate_and_attach: ENTER
[  171.242375] ata2.00: ata_dev_read_id: ENTER
[  171.246559] ata_sg_setup: ENTER, ata2
[  171.250213] ata_sg_setup: 1 sg elements mapped
[  176.335176] __ata_port_freeze: ata2 port frozen
[  176.339715] ata_sg_clean: unmapping 1 sg elements
[  176.344412] ata2.00: qc timeout (cmd 0xec)
[  176.348517] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  176.354611] ata2.00: revalidation failed (errno=-5)
[  176.359487] ata_eh_revalidate_and_attach: EXIT rc=-5
[  176.364454] __ata_port_freeze: ata2 port frozen
[  176.368982] ata2: hard resetting link
[  178.511168] sil24_softreset: ENTER
[  178.527169] ata_dev_classify: found ATA device by sig
[  178.532225] sil24_softreset: EXIT, class=1
[  178.536327] ata_eh_thaw_port: ata2 port thawed
[  178.540767] ata_std_postreset: ENTER
[  178.544348] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  178.550350] ata_std_postreset: EXIT
[  178.553840] ata_eh_revalidate_and_attach: ENTER
[  178.558371] ata2.00: ata_dev_read_id: ENTER
[  178.562554] ata_sg_setup: ENTER, ata2
[  178.566208] ata_sg_setup: 1 sg elements mapped
[  188.567185] __ata_port_freeze: ata2 port frozen
[  188.571722] ata_sg_clean: unmapping 1 sg elements
[  188.576419] ata2.00: qc timeout (cmd 0xec)
[  188.580524] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)

Do we have support for interrupt polling under libata?

Next I will investigate the interrupt request registers, maybe a
interrupt race condition in the driver?

Regards,

Leon.
