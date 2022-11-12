Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA09C4332F
	for <linux-ide@archiver.kernel.org>; Sat, 12 Nov 2022 01:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiKLB5X (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 20:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKLB5W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 20:57:22 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3222BC23
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 17:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668218240; x=1699754240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PPt5G1uk7gGxLw+zED1SL7kp+2FNFL04m4kPu2LE/zk=;
  b=pBg757gWv07JvcM2C0temKQNZTVQGfXd6opElk8ZGyz94Yne2dtW24Fb
   juiqDlgmIc+VDQaoNCS9/LS6hAiFSz+q20kXPsphwJMIbcQXBFll4h4th
   MUMt8xpsLU6ROPmzdb2sMPIEdPndAZLqsEXAjG2Q54euuGJGJ34GByM8l
   Nq6bKSd/hJMC6W0qoVPtfQ44y4Lc1l/xaLmRMJwF53mDb+uJHZqb+tl8R
   raXJIiXWD3VpKQKq8sub3q73LbOizMxgKp0vzvOU6cpohIejv8Ap/6AgR
   DIVaU32N45mjkBv9t0Tl/ABm3+iE5ojQK5ed9Zk1tySKYPaBA2rv5VHeg
   A==;
X-IronPort-AV: E=Sophos;i="5.96,158,1665417600"; 
   d="scan'208";a="214366493"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2022 09:57:19 +0800
IronPort-SDR: Xi4dh6dJdHu/0AamfXE0pKGk+MbK4etAyGEOTURmjQwrpehjZErGExnUCwkpdThJhmie/JPxSo
 BFT4eYOGBoeXiCc8yC36RW8vrSgtmR6rjwNn/HlSgMwKluBU+xk/tGc2ueR6ZaUYHefsV2+hbU
 wBzoDzokLfwwC31cYCQayAtJEYfzwWXB48nwGWW9Ys+yUBFvDEtUKUbCIKF8hDeIfx7EQxGKXt
 h54sST9ubnIbn6+v9pQFRYu4gtDvfQPPkKqfVfQZGoPdgh+D8FMgIM3fjuadzVY6WRF1XJuzQi
 eeE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 17:16:21 -0800
IronPort-SDR: fhk/eQ/zU0ldgiFTnaX9Fppt7sIZKvL1ewX/oIgFM2sDiENvmJtX65Y2Y7THEJlRg5lrqp2t1a
 0nAq/8u51Nh9+tqUBiEctm/VYajJHKQa5kAxmkUeWRmYmbTrGCaQQpK7Mb6TPZY8kc5VeDX/hU
 flCWAHuZFIL9GVo6OoXcK9cOdwaxeesbL5hRlyOP/N1IOWQ4HCDyRstkGME5U2U8a65n5+zt7y
 LyAFNR0r1v2waXkM9zH7YqUgUfWxesE5t6460o4aoHi+H9aFMm3tiH/rnMvE/oc1VajYcWgKIT
 +YE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 17:57:20 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N8Jbz4gb6z1RvTp
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 17:57:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668218239; x=1670810240; bh=PPt5G1uk7gGxLw+zED1SL7kp+2FNFL04m4k
        Pu2LE/zk=; b=Hj7WpqjP74tM4TuEKlpey7F8C776WI0Kxy2p/OEWz5z05vpA11c
        pngMbe22t/7wBIQZMxtry8F8/SdoyzeE/GZXjS84dkIaYqWq4Bz1PRps0gFsfKnc
        kgEKQ/PU+Iyl3ksgapbtkBUetZI3MnR4Yxj4t2E4kB0ldLjHe0AWG1tZmUr1V2QP
        AJDpfcon9zG8tTxAGahZ3ilPdDNQf50V+yh9fplWZQ9Kz7743WVphhh22wN+ipgL
        zn5LKCzMxIU7TlkDoHyH7fPZyQWn5TFaXt2GVkaeKoFWuJlH5qGqMORj+QKyQqSH
        N7qCY8FGmC4vn8KVwMEROzqGry1uNIsvj/w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QRnczp6WHcTL for <linux-ide@vger.kernel.org>;
        Fri, 11 Nov 2022 17:57:19 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N8Jby3rn8z1RvLy;
        Fri, 11 Nov 2022 17:57:18 -0800 (PST)
Message-ID: <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
Date:   Sat, 12 Nov 2022 10:57:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/12/22 07:32, marius@psihoexpert.ro wrote:
> November 10, 2022 4:06 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>> This of course does not mean that this is not a bug in the ahci-mvebu
>> driver. We can try digging into that. First thing to try: enable debug
>> messages in libata and libahci/ahci-mvebu. See
>> Documentation/admin-guide/dynamic-debug-howto.rst for that. Then connect
>> your eSATA box and see what it says.
>>
>> --
>> Damien Le Moal
>> Western Digital Research
> 
> I used:
> cd /proc/dynamic_debug/
> echo -n "file *ata* +pflmt" > control
> echo -n "file *ahci* +pflmt" > control
> echo -n "module ahci_mvebu +pflmt" > control
> echo -n "module libata +pflmt" > control
> 
> There are no errors running the commands.
> 
> Check:
> root@(none):/proc/dynamic_debug# grep libata control
> include/linux/libata.h:2049 [libata]ata_wait_idle =pmflt "ata%u: abnormal Status 0x%X\n"
> drivers/ata/libata-sff.c:2107 [libata]ata_sff_drain_fifo =pmflt "ata%u: drained %d bytes to clear
> DRQ\n"
> drivers/ata/libata-transport.c:344 [libata]ata_port_classify =pmflt "ata%u: found %s device by
> sig\n"
> drivers/ata/libata-eh.c:2747 [libata]ata_eh_reset =pmflt "ata%u.%02u: link status unknown, clearing
> UNKNOWN to NONE\n"
> drivers/ata/libata-eh.c:2742 [libata]ata_eh_reset =pmflt "ata%u.%02u: link offline, clearing class
> %d to NONE\n"
> drivers/ata/libata-eh.c:2736 [libata]ata_eh_reset =pmflt "ata%u.%02u: link online but device
> misclassified\n"
> drivers/ata/libata-eh.c:2542 [libata]ata_eh_reset =pmflt "ata%u: port disabled--ignoring\n"
> drivers/ata/libata-eh.c:2542 [libata]ata_eh_reset =pmflt "ata%u.%02u: port disabled--ignoring\n"
> drivers/ata/libata-scsi.c:4244 [libata]ata_scsi_assign_ofnode =pmflt "found matching device node\n"
> drivers/ata/libata-core.c:3344 [libata]ata_dev_set_mode =pmflt "ata%u.%02u: xfer_shift=%u,
> xfer_mode=0x%x\n"
> drivers/ata/libata-core.c:4305 [libata]ata_dev_set_xfermode =pmflt "ata%u.%02u: set features - xfer
> mode\n"
> drivers/ata/libata-core.c:2356 [libata]ata_dev_config_trusted =pmflt "ata%u.%02u: Trusted Computing
> capability qword not valid!\n"
> drivers/ata/libata-core.c:2274 [libata]ata_dev_config_sense_reporting =pmflt "ata%u.%02u: failed to
> enable Sense Data Reporting, Emask 0x%x\n"
> drivers/ata/libata-core.c:2124 [libata]ata_dev_config_ncq_send_recv =pmflt "ata%u.%02u: disabling
> queued TRIM support\n"
> drivers/ata/libata-core.c:1363 [libata]ata_dump_id =pmflt "ata%u.%02u: 49==0x%04x 53==0x%04x
> 63==0x%04x 64==0x%04x 75==0x%04x\n80==0x%04x 81==0x%04x 82==0x%04x 83==0x%04x
> 84==0x%04x\n88==0x%04x 93==0x%04x\n"
> drivers/ata/libata-core.c:2596 [libata]ata_dev_configure =pmflt "ata%u.%02u: %s: cfg 49:%04x
> 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n"
> drivers/ata/libata-core.c:2545 [libata]ata_dev_configure =pmflt "ata%u.%02u: no device\n"
> drivers/ata/libata-core.c:4391 [libata]ata_dev_init_params =pmflt "ata%u.%02u: init dev params \n"
> drivers/ata/libata-core.c:1877 [libata]ata_dev_read_id =pmflt "ata%u.%02u: host indicates ignore
> ATA devices, ignored\n"
> drivers/ata/libata-core.c:1843 [libata]ata_dev_read_id =pmflt "ata%u.%02u: both IDENTIFYs aborted,
> assuming NODEV\n"
> drivers/ata/libata-core.c:1811 [libata]ata_dev_read_id =pmflt "ata%u.%02u: NODEV after polling
> detection\n"
> drivers/ata/libata-core.c:1970 [libata]ata_read_log_page =pmflt "ata%u.%02u: read log page - log
> 0x%x, page 0x%x\n"
> drivers/ata/libata-core.c:4351 [libata]ata_dev_set_feature =pmflt "ata%u.%02u: set features\n"
> root@(none):/proc/dynamic_debug# grep ahci control
> drivers/ata/libahci.c:1313 [libahci]ahci_init_controller =pmflt "HOST_CTL 0x%x\n"
> drivers/ata/libahci.c:1310 [libahci]ahci_init_controller =pmflt "HOST_CTL 0x%x\n"
> drivers/ata/libahci.c:1279 [libahci]ahci_port_init =pmflt "PORT_IRQ_STAT 0x%x\n"
> drivers/ata/libahci.c:1274 [libahci]ahci_port_init =pmflt "PORT_SCR_ERR 0x%x\n"
> 
> I don't see any ahci_mvebu debug strings.
> 
> Kernel log:
> ---- Connect laptop HDD ----
> [ 195.229143][ T108] [108] libata:ata_port_classify:344: ata2: found ata device by sig
> [ 195.409141][ T108] [108] libata:ata_port_classify:344: ata2: found ata device by sig
> [ 195.417008][ T108] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [ 195.685415][ T108] [108] libata:ata_dev_configure:2596: ata2.00: ata_dev_configure: cfg 49:2f00
> 82:346b 83:7d09 84:6123 85:3469 86:bc09 87:6123 88:007f
> [ 195.699132][ T108] [108] libata:ata_dump_id:1363: ata2.00: 49==0x2f00 53==0x0007 63==0x0407
> 64==0x0003 75==0x001f
> [ 195.699132][ T108] 80==0x01f0 81==0x0029 82==0x346b 83==0x7d09 84==0x6123
> [ 195.699132][ T108] 88==0x007f 93==0x0000
> [ 195.721221][ T108] ata2.00: ATA-8: ST9500325AS, 0001SDM1, max UDMA/133
> [ 195.727865][ T108] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32)
> [ 195.735129][ T108] [108] libata:ata_dev_set_xfermode:4305: ata2.00: set features - xfer mode
> [ 195.745985][ T108] [108] libata:ata_dev_configure:2596: ata2.00: ata_dev_configure: cfg 49:2f00
> 82:346b 83:7d09 84:6123 85:3469 86:bc09 87:6123 88:407f
> [ 195.759699][ T108] [108] libata:ata_dump_id:1363: ata2.00: 49==0x2f00 53==0x0007 63==0x0007
> 64==0x0003 75==0x001f
> [ 195.759699][ T108] 80==0x01f0 81==0x0029 82==0x346b 83==0x7d09 84==0x6123
> [ 195.759699][ T108] 88==0x407f 93==0x0000
> [ 195.781791][ T108] [108] libata:ata_dev_set_mode:3344: ata2.00: xfer_shift=12, xfer_mode=0x46
> [ 195.790443][ T108] ata2.00: configured for UDMA/133
> [ 195.795640][ T87] scsi 1:0:0:0: Direct-Access ATA ST9500325AS SDM1 PQ: 0 ANSI: 5
> [ 195.804660][ T87] device: 'target1:0:0': device_add
> [ 195.809750][ T87] bus: 'scsi': add device target1:0:0
> [ 195.815024][ T87] device: '1:0:0:0': device_add
> [ 195.819805][ T87] bus: 'scsi': add device 1:0:0:0
> [ 195.825210][ T87] scsi 1:0:0:0: scheduling asynchronous probe
> [ 195.831480][ T28] bus: 'scsi': __driver_probe_device: matched device 1:0:0:0 with driver sd
> [ 195.831688][ T87] device: '1:0:0:0': device_add
> [ 195.840063][ T28] bus: 'scsi': really_probe: probing driver sd with device 1:0:0:0
> [ 195.852567][ T28] sd 1:0:0:0: no default pinctrl state
> [ 195.857932][ T28] device: '1:0:0:0': device_add
> [ 195.863018][ T28] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
> [ 195.871262][ T28] sd 1:0:0:0: [sdb] Write Protect is off
> [ 195.876774][ T28] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [ 195.882593][ T28] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
> [ 195.892422][ T28] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
> [ 195.899336][ T28] device: 'sdb': device_add
> [ 195.905171][ T28] device: '8:16': device_add
> [ 195.932431][ T28] sd 1:0:0:0: [sdb] Attached SCSI removable disk
> [ 195.938644][ T28] driver: 'sd': driver_bound: bound to device '1:0:0:0'
> [ 195.945486][ T28] bus: 'scsi': really_probe: bound device 1:0:0:0 to driver sd
> [ 195.952927][ T28] sd 1:0:0:0: async probe completed
> ---- Disconnect HDD ----
> [ 243.349142][ T108] ata2: SATA link down (SStatus 0 SControl 300)
> [ 248.750304][ T108] ata2: SATA link down (SStatus 0 SControl 300)
> [ 254.110303][ T108] ata2: SATA link down (SStatus 0 SControl 300)
> [ 254.116424][ T108] ata2.00: disable device
> [ 254.120641][ T87] ata2.00: detaching (SCSI 1:0:0:0)
> [ 254.125714][ T87] device: '1:0:0:0': device_unregister
> [ 254.131477][ T87] bus: 'scsi': remove device 1:0:0:0
> [ 254.136793][ T87] device: '8:16': device_unregister
> [ 254.141898][ T87] device: '8:16': device_create_release
> [ 254.199147][ T87] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
> [ 254.205047][ T87] sd 1:0:0:0: [sdb] Synchronize Cache(10) failed: Result: hostbyte=0x04
> driverbyte=DRIVER_OK
> [ 254.215099][ T87] sd 1:0:0:0: [sdb] Stopping disk
> [ 254.220012][ T87] sd 1:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=0x04
> driverbyte=DRIVER_OK
> [ 254.229591][ T87] bus: 'scsi': remove device target1:0:0
> ---- Connect Areca DAS ----
> [ 385.299142][ T108] ata2: SATA link down (SStatus 100 SControl 300)
> [ 386.979141][ T108] ata2: SATA link down (SStatus 100 SControl 300)
> [ 388.109141][ T108] ata2: SATA link down (SStatus 100 SControl 300)
> [ 389.999141][ T108] ata2: SATA link down (SStatus 100 SControl 300)
> [ 390.879141][ T108] ata2: SATA link down (SStatus 100 SControl 300)
> [ 390.885440][ T108] ata2: EH pending after 5 tries, giving up
> 
> No more messages appear after this. Not even when I unplug the cable. The laptop HDD that worked before is no longer detected. The port is dead.

This is likely because the adapter does not support or has a buggy
plug-an-play. The adapter needs to be power cycled/reset to detect changes
in drive connections. If you have libata & ahci drivers compiled as
modules, you could try rmmod them and then "modprobe ahci_mvebu".

> After hard reset, with the same dynamic_debug setup:> ---- Connect Areca DAS ----
> [ 548.949140][ T108] ata2: COMRESET failed (errno=-32)
> [ 548.954221][ T108] ata2: reset failed (errno=-32), retrying in 8 secs

Hmmm... No clue. This comes from sata_link_hardreset(). Would be good to
add messages in that function to see what fails causing the jump to the
error message print. Looking at ahci_mvebu_stop_engine() comments, there
seem to be issues (errata) with this controller.

> [ 559.089139][ T108] ata2: COMRESET failed (errno=-32)
> [ 559.094212][ T108] ata2: reset failed (errno=-32), retrying in 8 secs
> [ 569.289139][ T108] ata2: COMRESET failed (errno=-32)
> [ 569.294211][ T108] ata2: reset failed (errno=-32), retrying in 33 secs
> [ 604.339139][ T108] ata2: COMRESET failed (errno=-32)
> [ 604.344212][ T108] ata2: reset failed, giving up
> [ 606.599139][ T108] ata2: COMRESET failed (errno=-32)
> [ 606.604211][ T108] ata2: reset failed (errno=-32), retrying in 8 secs
> [ 615.799142][ T108] ata2: SATA link down (SStatus 100 SControl 300)
> [ 616.999142][ T108] ata2: SATA link down (SStatus 100 SControl 300)
> [ 619.459139][ T108] ata2: COMRESET failed (errno=-32)
> [ 619.464211][ T108] ata2: reset failed (errno=-32), retrying in 8 secs
> [ 628.809141][ T108] ata2: SATA link down (SStatus 101 SControl 300)
> [ 631.059139][ T108] ata2: COMRESET failed (errno=-32)
> [ 631.064211][ T108] ata2: reset failed (errno=-32), retrying in 8 secs
> [ 641.579139][ T108] ata2: COMRESET failed (errno=-32)
> [ 641.584211][ T108] ata2: reset failed (errno=-32), retrying in 8 secs
> [ 651.779139][ T108] ata2: COMRESET failed (errno=-32)
> [ 651.784211][ T108] ata2: reset failed (errno=-32), retrying in 33 secs
> [ 685.399141][ T108] ata2: SATA link down (SStatus 100 SControl 300)
> [ 685.405439][ T108] ata2: EH pending after 5 tries, giving up
> 
> After this, the port is dead again. No more messages appear.
> Notice there is no COMRESET error if I connect the laptop HDD first.

Given that I do not have access to the hardware, I cannot do much. Try to
see if adding error messages in sata_link_hardreset() for anything that
fails in that function can help. This may give some hints.

> 
> Marius Dinu
> 

-- 
Damien Le Moal
Western Digital Research

