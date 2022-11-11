Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA43C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 11 Nov 2022 22:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiKKWcu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 17:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiKKWct (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 17:32:49 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F735532C4
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 14:32:47 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=oMhSPiBzii1bSY0H+QNACK4zRJCO60wLBZy0Z5aQG9U=;
        b=jhQkwTI5rVGTi9ZXXiIWrwtqZAHlDdB+FyEGTLCJc7ObwGM9k9/So7Zhz6aNk92Cv9/pJUDDbMKfTsJGXxMBkQ5lChz6uW/zop0WhVCq1I0pOilwxN+6tPdjUSOunzN5BluBPRzo2ANso1e56MuvReG4O8CRw+DhhX93ICaLSPV3OrJ5eXRELAMEdNyh0niK+L9rpkcnOOz/YTx4weDjiLWyQQrCMKF5yOOtaBlG4R20lOEZNaKAE1y2lO
        LUK/Gad1QZW/P3jKNicur3E+ByrB0rcRUdSdOQJSZ2ie7sonUcKmXbuJHwSo3PU0wjcAx/EzepgN9ZEwiRuLKlI1Ga1A==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Fri, 11 Nov 2022 22:32:45 +0000
MIME-Version: 1.0
Date:   Fri, 11 Nov 2022 22:32:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
References: <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
X-Originating-IP: 86.122.18.201
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

November 10, 2022 4:06 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc=
.com> wrote:

> This of course does not mean that this is not a bug in the ahci-mvebu
> driver. We can try digging into that. First thing to try: enable debug
> messages in libata and libahci/ahci-mvebu. See
> Documentation/admin-guide/dynamic-debug-howto.rst for that. Then connec=
t
> your eSATA box and see what it says.
>=20
>=20--
> Damien Le Moal
> Western Digital Research

I used:
cd /proc/dynamic_debug/
echo -n "file *ata* +pflmt" > control
echo -n "file *ahci* +pflmt" > control
echo -n "module ahci_mvebu +pflmt" > control
echo -n "module libata +pflmt" > control

There are no errors running the commands.

Check:
root@(none):/proc/dynamic_debug# grep libata control
include/linux/libata.h:2049 [libata]ata_wait_idle =3Dpmflt "ata%u: abnorm=
al Status 0x%X\n"
drivers/ata/libata-sff.c:2107 [libata]ata_sff_drain_fifo =3Dpmflt "ata%u:=
 drained %d bytes to clear
DRQ\n"
drivers/ata/libata-transport.c:344 [libata]ata_port_classify =3Dpmflt "at=
a%u: found %s device by
sig\n"
drivers/ata/libata-eh.c:2747 [libata]ata_eh_reset =3Dpmflt "ata%u.%02u: l=
ink status unknown, clearing
UNKNOWN to NONE\n"
drivers/ata/libata-eh.c:2742 [libata]ata_eh_reset =3Dpmflt "ata%u.%02u: l=
ink offline, clearing class
%d to NONE\n"
drivers/ata/libata-eh.c:2736 [libata]ata_eh_reset =3Dpmflt "ata%u.%02u: l=
ink online but device
misclassified\n"
drivers/ata/libata-eh.c:2542 [libata]ata_eh_reset =3Dpmflt "ata%u: port d=
isabled--ignoring\n"
drivers/ata/libata-eh.c:2542 [libata]ata_eh_reset =3Dpmflt "ata%u.%02u: p=
ort disabled--ignoring\n"
drivers/ata/libata-scsi.c:4244 [libata]ata_scsi_assign_ofnode =3Dpmflt "f=
ound matching device node\n"
drivers/ata/libata-core.c:3344 [libata]ata_dev_set_mode =3Dpmflt "ata%u.%=
02u: xfer_shift=3D%u,
xfer_mode=3D0x%x\n"
drivers/ata/libata-core.c:4305 [libata]ata_dev_set_xfermode =3Dpmflt "ata=
%u.%02u: set features - xfer
mode\n"
drivers/ata/libata-core.c:2356 [libata]ata_dev_config_trusted =3Dpmflt "a=
ta%u.%02u: Trusted Computing
capability qword not valid!\n"
drivers/ata/libata-core.c:2274 [libata]ata_dev_config_sense_reporting =3D=
pmflt "ata%u.%02u: failed to
enable Sense Data Reporting, Emask 0x%x\n"
drivers/ata/libata-core.c:2124 [libata]ata_dev_config_ncq_send_recv =3Dpm=
flt "ata%u.%02u: disabling
queued TRIM support\n"
drivers/ata/libata-core.c:1363 [libata]ata_dump_id =3Dpmflt "ata%u.%02u: =
49=3D=3D0x%04x 53=3D=3D0x%04x
63=3D=3D0x%04x 64=3D=3D0x%04x 75=3D=3D0x%04x\n80=3D=3D0x%04x 81=3D=3D0x%0=
4x 82=3D=3D0x%04x 83=3D=3D0x%04x
84=3D=3D0x%04x\n88=3D=3D0x%04x 93=3D=3D0x%04x\n"
drivers/ata/libata-core.c:2596 [libata]ata_dev_configure =3Dpmflt "ata%u.=
%02u: %s: cfg 49:%04x
82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n"
drivers/ata/libata-core.c:2545 [libata]ata_dev_configure =3Dpmflt "ata%u.=
%02u: no device\n"
drivers/ata/libata-core.c:4391 [libata]ata_dev_init_params =3Dpmflt "ata%=
u.%02u: init dev params \n"
drivers/ata/libata-core.c:1877 [libata]ata_dev_read_id =3Dpmflt "ata%u.%0=
2u: host indicates ignore
ATA devices, ignored\n"
drivers/ata/libata-core.c:1843 [libata]ata_dev_read_id =3Dpmflt "ata%u.%0=
2u: both IDENTIFYs aborted,
assuming NODEV\n"
drivers/ata/libata-core.c:1811 [libata]ata_dev_read_id =3Dpmflt "ata%u.%0=
2u: NODEV after polling
detection\n"
drivers/ata/libata-core.c:1970 [libata]ata_read_log_page =3Dpmflt "ata%u.=
%02u: read log page - log
0x%x, page 0x%x\n"
drivers/ata/libata-core.c:4351 [libata]ata_dev_set_feature =3Dpmflt "ata%=
u.%02u: set features\n"
root@(none):/proc/dynamic_debug# grep ahci control
drivers/ata/libahci.c:1313 [libahci]ahci_init_controller =3Dpmflt "HOST_C=
TL 0x%x\n"
drivers/ata/libahci.c:1310 [libahci]ahci_init_controller =3Dpmflt "HOST_C=
TL 0x%x\n"
drivers/ata/libahci.c:1279 [libahci]ahci_port_init =3Dpmflt "PORT_IRQ_STA=
T 0x%x\n"
drivers/ata/libahci.c:1274 [libahci]ahci_port_init =3Dpmflt "PORT_SCR_ERR=
 0x%x\n"

I don't see any ahci_mvebu debug strings.

Kernel log:
---- Connect laptop HDD ----
[ 195.229143][ T108] [108] libata:ata_port_classify:344: ata2: found ata =
device by sig
[ 195.409141][ T108] [108] libata:ata_port_classify:344: ata2: found ata =
device by sig
[ 195.417008][ T108] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[ 195.685415][ T108] [108] libata:ata_dev_configure:2596: ata2.00: ata_de=
v_configure: cfg 49:2f00
82:346b 83:7d09 84:6123 85:3469 86:bc09 87:6123 88:007f
[ 195.699132][ T108] [108] libata:ata_dump_id:1363: ata2.00: 49=3D=3D0x2f=
00 53=3D=3D0x0007 63=3D=3D0x0407
64=3D=3D0x0003 75=3D=3D0x001f
[ 195.699132][ T108] 80=3D=3D0x01f0 81=3D=3D0x0029 82=3D=3D0x346b 83=3D=
=3D0x7d09 84=3D=3D0x6123
[ 195.699132][ T108] 88=3D=3D0x007f 93=3D=3D0x0000
[ 195.721221][ T108] ata2.00: ATA-8: ST9500325AS, 0001SDM1, max UDMA/133
[ 195.727865][ T108] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (dep=
th 32)
[ 195.735129][ T108] [108] libata:ata_dev_set_xfermode:4305: ata2.00: set=
 features - xfer mode
[ 195.745985][ T108] [108] libata:ata_dev_configure:2596: ata2.00: ata_de=
v_configure: cfg 49:2f00
82:346b 83:7d09 84:6123 85:3469 86:bc09 87:6123 88:407f
[ 195.759699][ T108] [108] libata:ata_dump_id:1363: ata2.00: 49=3D=3D0x2f=
00 53=3D=3D0x0007 63=3D=3D0x0007
64=3D=3D0x0003 75=3D=3D0x001f
[ 195.759699][ T108] 80=3D=3D0x01f0 81=3D=3D0x0029 82=3D=3D0x346b 83=3D=
=3D0x7d09 84=3D=3D0x6123
[ 195.759699][ T108] 88=3D=3D0x407f 93=3D=3D0x0000
[ 195.781791][ T108] [108] libata:ata_dev_set_mode:3344: ata2.00: xfer_sh=
ift=3D12, xfer_mode=3D0x46
[ 195.790443][ T108] ata2.00: configured for UDMA/133
[ 195.795640][ T87] scsi 1:0:0:0: Direct-Access ATA ST9500325AS SDM1 PQ: =
0 ANSI: 5
[ 195.804660][ T87] device: 'target1:0:0': device_add
[ 195.809750][ T87] bus: 'scsi': add device target1:0:0
[ 195.815024][ T87] device: '1:0:0:0': device_add
[ 195.819805][ T87] bus: 'scsi': add device 1:0:0:0
[ 195.825210][ T87] scsi 1:0:0:0: scheduling asynchronous probe
[ 195.831480][ T28] bus: 'scsi': __driver_probe_device: matched device 1:=
0:0:0 with driver sd
[ 195.831688][ T87] device: '1:0:0:0': device_add
[ 195.840063][ T28] bus: 'scsi': really_probe: probing driver sd with dev=
ice 1:0:0:0
[ 195.852567][ T28] sd 1:0:0:0: no default pinctrl state
[ 195.857932][ T28] device: '1:0:0:0': device_add
[ 195.863018][ T28] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: =
(500 GB/466 GiB)
[ 195.871262][ T28] sd 1:0:0:0: [sdb] Write Protect is off
[ 195.876774][ T28] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 195.882593][ T28] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: e=
nabled, doesn't support
DPO or FUA
[ 195.892422][ T28] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 byte=
s
[ 195.899336][ T28] device: 'sdb': device_add
[ 195.905171][ T28] device: '8:16': device_add
[ 195.932431][ T28] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[ 195.938644][ T28] driver: 'sd': driver_bound: bound to device '1:0:0:0'
[ 195.945486][ T28] bus: 'scsi': really_probe: bound device 1:0:0:0 to dr=
iver sd
[ 195.952927][ T28] sd 1:0:0:0: async probe completed
---- Disconnect HDD ----
[ 243.349142][ T108] ata2: SATA link down (SStatus 0 SControl 300)
[ 248.750304][ T108] ata2: SATA link down (SStatus 0 SControl 300)
[ 254.110303][ T108] ata2: SATA link down (SStatus 0 SControl 300)
[ 254.116424][ T108] ata2.00: disable device
[ 254.120641][ T87] ata2.00: detaching (SCSI 1:0:0:0)
[ 254.125714][ T87] device: '1:0:0:0': device_unregister
[ 254.131477][ T87] bus: 'scsi': remove device 1:0:0:0
[ 254.136793][ T87] device: '8:16': device_unregister
[ 254.141898][ T87] device: '8:16': device_create_release
[ 254.199147][ T87] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[ 254.205047][ T87] sd 1:0:0:0: [sdb] Synchronize Cache(10) failed: Resul=
t: hostbyte=3D0x04
driverbyte=3DDRIVER_OK
[ 254.215099][ T87] sd 1:0:0:0: [sdb] Stopping disk
[ 254.220012][ T87] sd 1:0:0:0: [sdb] Start/Stop Unit failed: Result: hos=
tbyte=3D0x04
driverbyte=3DDRIVER_OK
[ 254.229591][ T87] bus: 'scsi': remove device target1:0:0
---- Connect Areca DAS ----
[ 385.299142][ T108] ata2: SATA link down (SStatus 100 SControl 300)
[ 386.979141][ T108] ata2: SATA link down (SStatus 100 SControl 300)
[ 388.109141][ T108] ata2: SATA link down (SStatus 100 SControl 300)
[ 389.999141][ T108] ata2: SATA link down (SStatus 100 SControl 300)
[ 390.879141][ T108] ata2: SATA link down (SStatus 100 SControl 300)
[ 390.885440][ T108] ata2: EH pending after 5 tries, giving up

No more messages appear after this. Not even when I unplug the cable. The=
 laptop HDD that worked before is no longer detected. The port is dead.

After hard reset, with the same dynamic_debug setup:
---- Connect Areca DAS ----
[ 548.949140][ T108] ata2: COMRESET failed (errno=3D-32)
[ 548.954221][ T108] ata2: reset failed (errno=3D-32), retrying in 8 secs
[ 559.089139][ T108] ata2: COMRESET failed (errno=3D-32)
[ 559.094212][ T108] ata2: reset failed (errno=3D-32), retrying in 8 secs
[ 569.289139][ T108] ata2: COMRESET failed (errno=3D-32)
[ 569.294211][ T108] ata2: reset failed (errno=3D-32), retrying in 33 sec=
s
[ 604.339139][ T108] ata2: COMRESET failed (errno=3D-32)
[ 604.344212][ T108] ata2: reset failed, giving up
[ 606.599139][ T108] ata2: COMRESET failed (errno=3D-32)
[ 606.604211][ T108] ata2: reset failed (errno=3D-32), retrying in 8 secs
[ 615.799142][ T108] ata2: SATA link down (SStatus 100 SControl 300)
[ 616.999142][ T108] ata2: SATA link down (SStatus 100 SControl 300)
[ 619.459139][ T108] ata2: COMRESET failed (errno=3D-32)
[ 619.464211][ T108] ata2: reset failed (errno=3D-32), retrying in 8 secs
[ 628.809141][ T108] ata2: SATA link down (SStatus 101 SControl 300)
[ 631.059139][ T108] ata2: COMRESET failed (errno=3D-32)
[ 631.064211][ T108] ata2: reset failed (errno=3D-32), retrying in 8 secs
[ 641.579139][ T108] ata2: COMRESET failed (errno=3D-32)
[ 641.584211][ T108] ata2: reset failed (errno=3D-32), retrying in 8 secs
[ 651.779139][ T108] ata2: COMRESET failed (errno=3D-32)
[ 651.784211][ T108] ata2: reset failed (errno=3D-32), retrying in 33 sec=
s
[ 685.399141][ T108] ata2: SATA link down (SStatus 100 SControl 300)
[ 685.405439][ T108] ata2: EH pending after 5 tries, giving up

After this, the port is dead again. No more messages appear.
Notice there is no COMRESET error if I connect the laptop HDD first.

Marius Dinu

