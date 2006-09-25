From: David Howells <dhowells@redhat.com>
Subject: libata BUG
Date: Mon, 25 Sep 2006 15:14:03 +0100
Message-ID: <20201.1159193643@warthog.cambridge.redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:10204 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932165AbWIYOOh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Sep 2006 10:14:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


I'm seeing a 100% reproducible BUG in libata during boot. I'm using an FRV
board with an HPT371 interface plugged into it:

    pata_hpt37x: BIOS has not set timing clocks.
    hpt37x: HPT371: Bus clock 33MHz.
    ata1: PATA max UDMA7 cmd 0xE4000820 ctl 0xE400082A bmdma 0xE4000C00 irq 20
    ata2: PATA max UDMA7 cmd 0xE4000830 ctl 0xE400082E bmdma 0xE4000C08 irq 20
    scsi0 : pata_hpt37x
    ATA: abnormal status 0x7D on port 0xE4000827
    scsi1 : pata_hpt37x
    ATA: abnormal status 0x8 on port 0xE4000837
    ATA: abnormal status 0x8 on port 0xE4000837
    ata2.00: ATA-4, max UDMA/100, 44150400 sectors: LBA
    ata2.00: ata2: dev 0 multi count 0
    kernel BUG at drivers/ata/pata_hpt37x.c:346!

The "abnormal status" messages are worrying, but I'm not sure what they're
telling me.  Presumably 0x7D == { DRDY, DF, DSC, DRQ, CORR, ERR} and 0x8 == {
DRQ }.

The interface works fine with the old IDE driver:

    Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    HPT371: IDE controller at PCI slot 0000:00:11.0
    HPT371: chipset revision 1
    HPT371: 100% native mode on irq 20
	ide2: BM-DMA at 0xe4000c00-0xe4000c07, BIOS settings: hde:pio, hdf:pio
	ide3: BM-DMA at 0xe4000c08-0xe4000c0f, BIOS settings: hdg:pio, hdh:pio
    hdg: IBM-DJNA-372200, ATA DISK drive
    ide3 at 0xe4000830-0xe4000837,0xe400082e on irq 20
    hdg: max request size: 128KiB
    hdg: 44150400 sectors (22605 MB) w/1966KiB Cache, CHS=43800/16/63
    hdg: cache flushes not supported
     hdg: hdg1 hdg2 hdg3 hdg4

Getting a backtrace from the kernel at the BUG point shows:

Program received signal SIGABRT, Aborted.
0xc01859b0 in hpt37x_find_mode (ap=0x6, speed=0xc0f) at pata_hpt37x.c:346
(gdb) bt
#0  0xc01859b0 in hpt37x_find_mode (ap=0x6, speed=0xc0f) at pata_hpt37x.c:346
#1  0xc01863bc in hpt372_set_piomode (ap=0xc0a882ac, adev=0xc0a88434) at pata_hpt37x.c:685
#2  0xc01761d0 in ata_set_mode (ap=0xc0a882ac, r_failed_dev=0xc0a8fbe4) at libata-core.c:2250
#3  0xc01852c0 in ata_eh_recover (ap=0xc0a882ac, prereset=0xc0185c20 <hpt37x_pre_reset>, 
    softreset=0xc0176f80 <ata_std_softreset>, hardreset=0, 
    postreset=0xc0177240 <ata_std_postreset>) at libata-eh.c:1988
#4  0xc0185648 in ata_do_eh (ap=0xc0a882ac, prereset=0xc0185c20 <hpt37x_pre_reset>, 
    softreset=0xc0176f80 <ata_std_softreset>, hardreset=0, 
    postreset=0xc0177240 <ata_std_postreset>) at libata-eh.c:2127
#5  0xc0181cfc in ata_bmdma_drive_eh (ap=0xc0a882ac, prereset=0xc0185c20 <hpt37x_pre_reset>, 
    softreset=0xc0176f80 <ata_std_softreset>, hardreset=0, 
    postreset=0xc0177240 <ata_std_postreset>) at libata-sff.c:762
#6  0xc0185d64 in hpt37x_error_handler (ap=0x6) at pata_hpt37x.c:486
#7  0xc018284c in ata_scsi_error (host=0xc0a88000) at libata-eh.c:283
#8  0xc016a6a8 in scsi_error_handler (data=0x6) at scsi_error.c:1531
#9  0xc003e888 in kthread (_create=0xc088f9f8) at kthread.c:103
#10 0xc000edf8 in kernel_thread () at arch/frv/kernel/kernel_thread.S:54
#11 0xc000edf8 in kernel_thread () at arch/frv/kernel/kernel_thread.S:54

Setting a breakpoint in hpt37x_find_mode() shows it is entered as:

#0  hpt37x_find_mode (ap=0xc0228604, speed=0xd) at pata_hpt37x.c:344

The speed would appear to be XFER_PIO_5, judging by the contents of the timing
tables.  However, none of the HighPoint controllers seem to list that, and
looking into the ata_device structure, I see:

	(gdb) p ap->device->pio_mode
	$22 = 0xd
	(gdb) p ap->device->pio_mask
	$23 = 0x1f

Assuming pio_mask is arranged such that bit0 => PIO mode 0 is supported, bit1
=> PIO mode 1 is supported , etc., then it would seem to confirm that PIO mode
5 is *not* supported.  So why is pio_mode == XFER_PIO_5?

If someone can tell me where this comes from, I try to trace what's happening.

I've attached a dump of the ata_port struct should that be of use.

David

(gdb) p *ap
$20 = {
  scsi_host = 0xc0a88000, 
  ops = 0xc0257074, 
  lock = 0xc0a677dc, 
  flags = 0x11, 
  pflags = 0x52, 
  id = 0x2, 
  port_no = 0x1, 
  prd = 0xc0400880, 
  prd_dma = 0xc0400880, 
  pad = 0xc0401080, 
  pad_dma = 0xc0401080, 
  ioaddr = {
    cmd_addr = 0xe4000830, 
    data_addr = 0xe4000830, 
    error_addr = 0xe4000831, 
    feature_addr = 0xe4000831, 
    nsect_addr = 0xe4000832, 
    lbal_addr = 0xe4000833, 
    lbam_addr = 0xe4000834, 
    lbah_addr = 0xe4000835, 
    device_addr = 0xe4000836, 
    status_addr = 0xe4000837, 
    command_addr = 0xe4000837, 
    altstatus_addr = 0xe400082e, 
    ctl_addr = 0xe400082e, 
    bmdma_addr = 0xe4000c08, 
    scr_addr = 0x0
  }, 
  ctl = 0x8, 
  last_ctl = 0x8, 
  pio_mask = 0x1f, 
  mwdma_mask = 0x7, 
  udma_mask = 0x7f, 
  cbl = 0x1, 
  hw_sata_spd_limit = 0xffffffff, 
  sata_spd_limit = 0xffffffff, 
  eh_info = {
    dev = 0x0, 
    serror = 0x0, 
    err_mask = 0x0, 
    action = 0x0, 
    dev_action = {0x0, 0x0}, 
    flags = 0x0, 
    hotplug_timestamp = 0x0, 
    probe_mask = 0x0, 
    desc = '\0' <repeats 79 times>, 
    desc_len = 0x0
  }, 
  eh_context = {
    i = {
      dev = 0x0, 
      serror = 0x0, 
      err_mask = 0x0, 
      action = 0x1, 
      dev_action = {0x0, 0x0}, 
      flags = 0x1000c, 
      hotplug_timestamp = 0x0, 
      probe_mask = 0x3, 
      desc = '\0' <repeats 79 times>, 
      desc_len = 0x0
    }, 
    tries = {0x3, 0x3}, 
    classes = {0x1, 0x5}, 
    did_probe_mask = 0x3
  }, 
  device = {{
      ap = 0xc0a882ac, 
      devno = 0x0, 
      flags = 0x1, 
      sdev = 0x0, 
      n_sectors = 0x2a1ae80, 
      class = 0x1, 
      id = {0x45a, 0x3fff, 0x0, 0x10, 0x0, 0x0, 0x3f, 0x0, 0x0, 0x0, 0x2020, 0x2020, 0x2020, 
        0x2020, 0x2047, 0x5830, 0x4758, 0x4642, 0x3131, 0x3232, 0x3, 0xf5c, 0x22, 0x4a37, 0x314f, 
        0x4133, 0x304b, 0x4942, 0x4d2d, 0x444a, 0x4e41, 0x2d33, 0x3732, 0x3230, 0x3020, 
        0x2020 <repeats 12 times>, 0x8010, 0x0, 0x2f00, 0x4000, 0x200, 0x200, 0x7, 0x3fff, 0x10, 
        0x3f, 0xfc10, 0xfb, 0x100, 0xae80, 0x2a1, 0x0, 0x407, 0x3, 0x78, 0x78, 0xf0, 0x78, 0x0, 
        0x0, 0x0, 0x0, 0x0, 0x0, 0x1f, 0x0, 0x0, 0x0, 0x0, 0x1e, 0x17, 0x74eb, 0x4083, 0x4000, 
        0x7468, 0x3, 0x4000, 0x1f, 0xf, 0x0 <repeats 38 times>, 0x1, 0xb, 0x5b, 
        0x0 <repeats 125 times>}, 
      pio_mode = 0xd, 
      dma_mode = 0x43, 
      xfer_mode = 0xd, 
      xfer_shift = 0x0, 
      multi_count = 0x0, 
      max_sectors = 0x0, 
      cdb_len = 0x10, 
      pio_mask = 0x1f, 
      mwdma_mask = 0x7, 
      udma_mask = 0x7, 
      cylinders = 0x0, 
      heads = 0x0, 
      sectors = 0x0, 
      ering = {
        cursor = 0x0, 
        ring = {{
            is_io = 0x0, 
            err_mask = 0x0, 
            timestamp = 0x0
          } <repeats 32 times>}
      }, 
      horkage = 0x0
    }, {
      ap = 0xc0a882ac, 
      devno = 0x1, 
      flags = 0x0, 
      sdev = 0x0, 
      n_sectors = 0x0, 
      class = 0x0, 
      id = {0x0 <repeats 256 times>}, 
      pio_mode = 0x8, 
      dma_mode = 0x0, 
      xfer_mode = 0x0, 
      xfer_shift = 0x0, 
      multi_count = 0x0, 
      max_sectors = 0x0, 
      cdb_len = 0x0, 
      pio_mask = 0xffffffff, 
      mwdma_mask = 0xffffffff, 
      udma_mask = 0xffffffff, 
      cylinders = 0x0, 
      heads = 0x0, 
      sectors = 0x0, 
      ering = {
        cursor = 0x0, 
        ring = {{
            is_io = 0x0, 
            err_mask = 0x0, 
            timestamp = 0x0
          } <repeats 32 times>}
      }, 
      horkage = 0x0
    }}, 
  qcmd = {{
      ap = 0x0, 
      dev = 0x0, 
      scsicmd = 0x0, 
      scsidone = 0, 
      tf = {
        flags = 0x0, 
        protocol = 0x0, 
        ctl = 0x0, 
        hob_feature = 0x0, 
        hob_nsect = 0x0, 
        hob_lbal = 0x0, 
        hob_lbam = 0x0, 
        hob_lbah = 0x0, 
        feature = 0x0, 
        nsect = 0x0, 
        lbal = 0x0, 
        lbam = 0x0, 
        lbah = 0x0, 
        device = 0x0, 
        command = 0x0
      }, 
      cdb = '\0' <repeats 15 times>, 
      flags = 0x0, 
      tag = 0x0, 
      n_elem = 0x0, 
      orig_n_elem = 0x0, 
      dma_dir = 0x0, 
      pad_len = 0x0, 
      nsect = 0x0, 
      cursect = 0x0, 
      nbytes = 0x0, 
      curbytes = 0x0, 
      cursg = 0x0, 
      cursg_ofs = 0x0, 
      sgent = {
        page = 0x0, 
        offset = 0x0, 
        dma_address = 0x0, 
        length = 0x0
      }, 
      pad_sgent = {
        page = 0x0, 
        offset = 0x0, 
        dma_address = 0x0, 
        length = 0x0
      }, 
      buf_virt = 0x0, 
      __sg = 0x0, 
      err_mask = 0x0, 
      result_tf = {
        flags = 0x0, 
        protocol = 0x0, 
        ctl = 0x0, 
        hob_feature = 0x0, 
        hob_nsect = 0x0, 
        hob_lbal = 0x0, 
        hob_lbam = 0x0, 
        hob_lbah = 0x0, 
        feature = 0x0, 
        nsect = 0x0, 
        lbal = 0x0, 
        lbam = 0x0, 
        lbah = 0x0, 
        device = 0x0, 
        command = 0x0
      }, 
      complete_fn = 0, 
      private_data = 0x0
    } <repeats 31 times>, {
      ap = 0xc0a882ac, 
      dev = 0xc0a88434, 
      scsicmd = 0x0, 
      scsidone = 0, 
      tf = {
        flags = 0x0, 
        protocol = 0x2, 
        ctl = 0x8, 
        hob_feature = 0x0, 
        hob_nsect = 0x0, 
        hob_lbal = 0x0, 
        hob_lbam = 0x0, 
        hob_lbah = 0x0, 
        feature = 0x0, 
        nsect = 0x0, 
        lbal = 0x0, 
        lbam = 0x0, 
        lbah = 0x0, 
        device = 0xa0, 
        command = 0xec
      }, 
      cdb = '\0' <repeats 15 times>, 
      flags = 0x0, 
      tag = 0xfafbfcfd, 
      n_elem = 0x1, 
      orig_n_elem = 0x1, 
      dma_dir = 0x2, 
      pad_len = 0x0, 
      nsect = 0x1, 
      cursect = 0x1, 
      nbytes = 0x200, 
      curbytes = 0x0, 
      cursg = 0x1, 
      cursg_ofs = 0x0, 
      sgent = {
        page = 0xc0811440, 
        offset = 0x450, 
        dma_address = 0x0, 
        length = 0x200
      }, 
      pad_sgent = {
        page = 0x0, 
        offset = 0x0, 
        dma_address = 0x0, 
        length = 0x0
      }, 
      buf_virt = 0xc0a88450, 
      __sg = 0xc0a8a21c, 
      err_mask = 0x0, 
      result_tf = {
        flags = 0x0, 
        protocol = 0x0, 
        ctl = 0x0, 
        hob_feature = 0x0, 
        hob_nsect = 0x0, 
        hob_lbal = 0x0, 
        hob_lbam = 0x0, 
        hob_lbah = 0x0, 
        feature = 0x0, 
        nsect = 0x1, 
        lbal = 0x1, 
        lbam = 0x0, 
        lbah = 0x0, 
        device = 0xa0, 
        command = 0x50
      }, 
      complete_fn = 0xc0173df0 <ata_qc_complete_internal>, 
      private_data = 0xc0a8fb28
    }}, 
  qc_allocated = 0x0, 
  qc_active = 0x0, 
  active_tag = 0xfafbfcfd, 
  sactive = 0x0, 
  stats = {
    unhandled_irq = 0x0, 
    idle_irq = 0x0, 
    rw_reqbuf = 0x0
  }, 
  host = 0xc0a677dc, 
  dev = 0xc085a104, 
  port_task = {
    pending = 0x0, 
    entry = {
      next = 0xc0a8a28c, 
      prev = 0xc0a8a28c
    }, 
    func = 0, 
    data = 0x0, 
    wq_data = 0x0, 
    timer = {
      entry = {
        next = 0x0, 
        prev = 0x0
      }, 
      expires = 0x0, 
      function = 0, 
      data = 0x0, 
      base = 0xc027b4f4
    }
  }, 
  hotplug_task = {
    pending = 0x0, 
    entry = {
      next = 0xc0a8a2bc, 
      prev = 0xc0a8a2bc
    }, 
    func = 0xc0180280 <ata_scsi_hotplug>, 
    data = 0xc0a882ac, 
    wq_data = 0x0, 
    timer = {
      entry = {
        next = 0x0, 
        prev = 0x0
      }, 
      expires = 0x0, 
      function = 0, 
      data = 0x0, 
      base = 0xc027b4f4
    }
  }, 
  scsi_rescan_task = {
    pending = 0x0, 
    entry = {
      next = 0xc0a8a2ec, 
      prev = 0xc0a8a2ec
    }, 
    func = 0xc01804c0 <ata_scsi_dev_rescan>, 
    data = 0xc0a882ac, 
    wq_data = 0x0, 
    timer = {
      entry = {
        next = 0x0, 
        prev = 0x0
      }, 
      expires = 0x0, 
      function = 0, 
      data = 0x0, 
      base = 0xc027b4f4
    }
  }, 
  hsm_task_state = 0x1, 
  msg_enable = 0x89, 
  eh_done_q = {
    next = 0xc0a8a320, 
    prev = 0xc0a8a320
  }, 
  eh_wait_q = {
    lock = {
      raw_lock = <incomplete type>
    }, 
    task_list = {
      next = 0xc088fa6c, 
      prev = 0xc088fa6c
    }
  }, 
  pm_mesg = {
    event = 0x0
  }, 
  pm_result = 0x0, 
  private_data = 0x0, 
  sector_buf = '\0' <repeats 511 times>
}
