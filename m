From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: Change Libata Error Handling for Drive Testing
Date: Thu, 22 Mar 2007 09:49:36 -0700
Message-ID: <8202f4270703220949m2617f0ecyf2528e7243d8ac36@mail.gmail.com>
References: <8202f4270703182216r33860cbdha404865d05a03b81@mail.gmail.com>
	 <45FE3F17.4010500@gmail.com>
	 <8202f4270703190927p4fd7098at5d0f4706d66009cf@mail.gmail.com>
	 <8202f4270703191001l50250d2fndb7403e41c39fa1@mail.gmail.com>
	 <8202f4270703191007i1874a6c9y781bd52885390ab6@mail.gmail.com>
	 <45FF5A7B.2010101@gmail.com>
	 <8202f4270703192214w12121970lf466be39e0f20fb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:3282 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934119AbXCVQtj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 12:49:39 -0400
Received: by nz-out-0506.google.com with SMTP id s1so646405nze
        for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 09:49:38 -0700 (PDT)
In-Reply-To: <8202f4270703192214w12121970lf466be39e0f20fb1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Tejun,

JFYI, it turns out that spurious interrupts was caused by User Scan
before drive is ready.  I wait for 2 seconds after drive is powered on
which is not sufficient for some drives.  Alt status should be checked
first but there's no good way to check it in user space. Does User
Scan related code check alt status before drive is touched?

Thanks,
Fajun

On 3/19/07, Fajun Chen <fajunchen@gmail.com> wrote:
> On 3/19/07, Tejun Heo <htejun@gmail.com> wrote:
> > Fajun Chen wrote:
> > > Please ignore the changes to pata_sil680.c. The same failure happened
> > > to standard sil680 driver without my change as well.
> >
> > Does it also happen when the second port is empty?
> >
>
> Yes, it happens even when one of the port (either one) is powered off.
> It used to happen in the middle of our IO test application, now it
> happened much early in our test spinup process with debugging version
> of ata_host_intr() function. We boot up the target (ARM XScale
> processor) with hard drive powered off, then power up the drive and do
> test spinup. What test spinup does is to issue sysfs user scan on the
> port followed by Identify Device.
>
> Below is my debugging version of ata_host_intr() function with
> ATA_IRQ_TRAP enabled and hacked. What puzzled me is that none of the
> sub-counters (initial value is 1) get incremented in most failures?
> Please see dmesg log for details. I did see one failure (out of many)
> where "idle_irq_hsm_state" is incremented and matches "idle_irq"
> counter though.
>
> Thanks,
> Fajun
>
> inline unsigned int ata_host_intr (struct ata_port *ap,
>                                    struct ata_queued_cmd *qc)
> {
>         u8 status, host_stat = 0;
>
> /*      VPRINTK("ata%u: protocol %d task_state %d\n", */
> /*              ap->id, qc->tf.protocol, ap->hsm_task_state); */
> /*      printk(KERN_INFO "ata%u: protocol %d task_state %d\n",  */
> /*             ap->id, qc->tf.protocol, ap->hsm_task_state);  */
>
>         /* Check whether we are expecting interrupt in this state */
>         switch (ap->hsm_task_state) {
>         case HSM_ST_FIRST:
>                 /* Some pre-ATAPI-4 devices assert INTRQ
>                  * at this state when ready to receive CDB.
>                  */
>
>                 /* Check the ATA_DFLAG_CDB_INTR flag is enough here.
>                  * The flag was turned on only for atapi devices.
>                  * No need to check is_atapi_taskfile(&qc->tf) again.
>                  */
>                 if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
>                 {
>                         /* printk(KERN_INFO "ata%u: flags %lu\n",  */
> /*                             ap->id, qc->dev->flags); */
>                         ap->stats.idle_irq_non_atapi++;
>                         goto idle_irq;
>                 }
>                 break;
>         case HSM_ST_LAST:
>                 if (qc->tf.protocol == ATA_PROT_DMA ||
>                     qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
>                         /* check status of DMA engine */
>                         host_stat = ap->ops->bmdma_status(ap);
>                         VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
>
>                         /* if it's not our irq... */
>                         if (!(host_stat & ATA_DMA_INTR))
>                                 /* printk(KERN_INFO "ata%u: host_stat %d\n",  */
> /*                                     ap->id, host_stat); */
>                                 ap->stats.idle_irq_host_state++;
>                                 goto idle_irq;
>
>                         /* before we do anything else, clear DMA-Start bit */
>                         ap->ops->bmdma_stop(qc);
>
>                         if (unlikely(host_stat & ATA_DMA_ERR)) {
>                                 /* error when transfering data to/from memory */
>                                 qc->err_mask |= AC_ERR_HOST_BUS;
>                                 ap->hsm_task_state = HSM_ST_ERR;
>                         }
>                 }
>                 break;
>         case HSM_ST:
>                 break;
>         default:
>                 /* printk(KERN_INFO "ata%u: hsm_state %d\n",  */
> /*                     ap->id, ap->hsm_task_state); */
>                 ap->stats.idle_irq_hsm_state++;
>                 goto idle_irq;
>         }
>
>         /* check altstatus */
>         status = ata_altstatus(ap);
>         if (status & ATA_BUSY)
>         {
>                 /* printk(KERN_INFO "ata%u: altstatus %d\n",  */
> /*                     ap->id, status); */
>                 ap->stats.idle_irq_altstatus++;
>                 goto idle_irq;
>         }
>
>         /* check main status, clearing INTRQ */
>         status = ata_chk_status(ap);
>         if (unlikely(status & ATA_BUSY))
>         {
>                 /* printk(KERN_INFO "ata%u: status %d\n",  */
> /*                     ap->id, status); */
>                 ap->stats.idle_irq_status++;
>                 goto idle_irq;
>         }
>
>         /* ack bmdma irq events */
>         ap->ops->irq_clear(ap);
>
>         ata_hsm_move(ap, qc, status, 0);
>         return 1;       /* irq handled */
>
> idle_irq:
>         ap->stats.idle_irq++;
>
> #ifdef ATA_IRQ_TRAP
>         if ((ap->stats.idle_irq % 1000) == 0) {
>           /* ata_irq_ack(ap, 0); /\* debug trap *\/ */
>           ata_port_printk(ap, KERN_WARNING, "irq trap: %lu - %lu %lu
> %lu %lu %lu\n",
>                           ap->stats.idle_irq,
>                           ap->stats.idle_irq_non_atapi,
>                           ap->stats.idle_irq_hsm_state,
>                           ap->stats.idle_irq_host_state,
>                           ap->stats.idle_irq_altstatus,
>                           ap->stats.idle_irq_status);
>           return 0;   // 1
>         }
> #endif
>         return 0;       /* irq not handled */
> }
>
>
> ~ $ dmesg
> +0x0/0x20()
> [42949375.760000] Calling initcall 0xc001c930: init_sd+0x0/0x8c()
> [42949375.760000] Calling initcall 0xc001c9bc: init_sg+0x0/0x14c()
> [42949375.760000] Calling initcall 0xc001d03c: i2c_dev_init+0x0/0xa8()
> [42949375.760000] i2c /dev entries driver
> [42949375.760000] Calling initcall 0xc001d0e4: i2c_iop3xx_init+0x0/0x1c()
> [42949375.760000] Calling initcall 0xc001d100: hwmon_init+0x0/0x5c()
> [42949375.760000] Calling initcall 0xc001d74c: flow_cache_init+0x0/0x174()
> [42949375.760000] Calling initcall 0xc001eb74: xfrm4_transport_init+0x0/0x20()
> [42949375.760000] Calling initcall 0xc001eb94: xfrm4_tunnel_init+0x0/0x20()
> [42949375.760000] Calling initcall 0xc001ebb4: inet_diag_init+0x0/0x80()
> [42949375.760000] Calling initcall 0xc001ec34: tcp_diag_init+0x0/0x1c()
> [42949375.760000] Calling initcall 0xc001ec50: bictcp_register+0x0/0x1c()
> [42949375.760000] TCP bic registered
> [42949375.760000] Calling initcall 0xc001ee2c: af_unix_init+0x0/0x80()
> [42949375.760000] NET: Registered protocol family 1
> [42949375.760000] Calling initcall 0xc001eeac: packet_init+0x0/0x70()
> [42949375.760000] NET: Registered protocol family 17
> [42949375.760000] Calling initcall 0xc0012a88:
> clocksource_done_booting+0x0/0x24()
> [42949375.760000] Calling initcall 0xc0019ed4: seqgen_init+0x0/0x1c()
> [42949375.760000] Calling initcall 0xc001ba44:
> early_uart_console_switch+0x0/0x90()
> [42949375.760000] Calling initcall 0xc0139ffc: net_random_reseed+0x0/0x38()
> [42949375.760000] RAMDISK: Compressed image found at block 0
> [42949378.940000] VFS: Mounted root (ext2 filesystem).
> [42949378.940000] Freeing init memory: 104K
> [42949549.190000] ata1: soft resetting port
> [42949549.230000] ata1.00: ATA-6, max UDMA/100, 156301488 sectors: LBA48
> [42949549.230000] ata1.00: configured for UDMA/100
> [42949549.230000] ata1: EH complete
> [42949549.230000]   Vendor: ATA       Model: ST980815A         Rev: ALD2
> [42949549.230000]   Type:   Direct-Access                      ANSI
> SCSI revision: 05
> [42949549.240000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> [42949549.240000] sda: Write Protect is off
> [42949549.240000] sda: Mode Sense: 00 3a 00 00
> [42949549.240000] SCSI device sda: drive cache: write back
> [42949549.250000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> [42949549.250000] sda: Write Protect is off
> [42949549.250000] sda: Mode Sense: 00 3a 00 00
> [42949549.250000] SCSI device sda: drive cache: write back
> [42949549.250000]  sda:<4>ata1: irq trap: 1000 - 1 1 1 1 1
> [42949549.280000] ata1: irq trap: 2000 - 1 1 1 1 1
> [42949549.280000] ata1: irq trap: 3000 - 1 1 1 1 1
> [42949549.280000] ata1: irq trap: 4000 - 1 1 1 1 1
> [42949549.290000] ata1: irq trap: 5000 - 1 1 1 1 1
> [42949549.290000] ata1: irq trap: 6000 - 1 1 1 1 1
> [42949549.290000] ata1: irq trap: 7000 - 1 1 1 1 1
> [42949549.290000] ata1: irq trap: 8000 - 1 1 1 1 1
> [42949549.300000] ata1: irq trap: 9000 - 1 1 1 1 1
> [42949549.300000] ata1: irq trap: 10000 - 1 1 1 1 1
> [42949549.300000] ata1: irq trap: 11000 - 1 1 1 1 1
> [42949549.310000] ata1: irq trap: 12000 - 1 1 1 1 1
> [42949549.310000] ata1: irq trap: 13000 - 1 1 1 1 1
> [42949549.310000] ata1: irq trap: 14000 - 1 1 1 1 1
> [42949549.310000] ata1: irq trap: 15000 - 1 1 1 1 1
> [42949549.320000] ata1: irq trap: 16000 - 1 1 1 1 1
> [42949549.320000] ata1: irq trap: 17000 - 1 1 1 1 1
> [42949549.320000] ata1: irq trap: 18000 - 1 1 1 1 1
> [42949549.330000] ata1: irq trap: 19000 - 1 1 1 1 1
> [42949549.330000] ata1: irq trap: 20000 - 1 1 1 1 1
> [42949549.330000] ata1: irq trap: 21000 - 1 1 1 1 1
> [42949549.330000] ata1: irq trap: 22000 - 1 1 1 1 1
> [42949549.340000] ata1: irq trap: 23000 - 1 1 1 1 1
> [42949549.340000] ata1: irq trap: 24000 - 1 1 1 1 1
> [42949549.340000] ata1: irq trap: 25000 - 1 1 1 1 1
> [42949549.350000] ata1: irq trap: 26000 - 1 1 1 1 1
> [42949549.350000] ata1: irq trap: 27000 - 1 1 1 1 1
> [42949549.350000] ata1: irq trap: 28000 - 1 1 1 1 1
> [42949549.350000] ata1: irq trap: 29000 - 1 1 1 1 1
> [42949549.360000] ata1: irq trap: 30000 - 1 1 1 1 1
> [42949549.360000] ata1: irq trap: 31000 - 1 1 1 1 1
> [42949549.360000] ata1: irq trap: 32000 - 1 1 1 1 1
> [42949549.370000] ata1: irq trap: 33000 - 1 1 1 1 1
> [42949549.370000] ata1: irq trap: 34000 - 1 1 1 1 1
> [42949549.370000] ata1: irq trap: 35000 - 1 1 1 1 1
> [42949549.380000] ata1: irq trap: 36000 - 1 1 1 1 1
> [42949549.380000] ata1: irq trap: 37000 - 1 1 1 1 1
> [42949549.380000] ata1: irq trap: 38000 - 1 1 1 1 1
> [42949549.380000] ata1: irq trap: 39000 - 1 1 1 1 1
> [42949549.390000] ata1: irq trap: 40000 - 1 1 1 1 1
> [42949549.390000] ata1: irq trap: 41000 - 1 1 1 1 1
> [42949549.390000] ata1: irq trap: 42000 - 1 1 1 1 1
> [42949549.400000] ata1: irq trap: 43000 - 1 1 1 1 1
> [42949549.400000] ata1: irq trap: 44000 - 1 1 1 1 1
> [42949549.400000] ata1: irq trap: 45000 - 1 1 1 1 1
> [42949549.400000] ata1: irq trap: 46000 - 1 1 1 1 1
> [42949549.410000] ata1: irq trap: 47000 - 1 1 1 1 1
> [42949549.410000] ata1: irq trap: 48000 - 1 1 1 1 1
> [42949549.410000] ata1: irq trap: 49000 - 1 1 1 1 1
> [42949549.420000] ata1: irq trap: 50000 - 1 1 1 1 1
> [42949549.420000] ata1: irq trap: 51000 - 1 1 1 1 1
> [42949549.420000] ata1: irq trap: 52000 - 1 1 1 1 1
> [42949549.420000] ata1: irq trap: 53000 - 1 1 1 1 1
> [42949549.430000] ata1: irq trap: 54000 - 1 1 1 1 1
> [42949549.430000] ata1: irq trap: 55000 - 1 1 1 1 1
> [42949549.430000] ata1: irq trap: 56000 - 1 1 1 1 1
> [42949549.440000] ata1: irq trap: 57000 - 1 1 1 1 1
> [42949549.440000] ata1: irq trap: 58000 - 1 1 1 1 1
> [42949549.440000] ata1: irq trap: 59000 - 1 1 1 1 1
> [42949549.440000] ata1: irq trap: 60000 - 1 1 1 1 1
> [42949549.450000] ata1: irq trap: 61000 - 1 1 1 1 1
> [42949549.450000] ata1: irq trap: 62000 - 1 1 1 1 1
> [42949549.450000] ata1: irq trap: 63000 - 1 1 1 1 1
> [42949549.460000] ata1: irq trap: 64000 - 1 1 1 1 1
> [42949549.460000] ata1: irq trap: 65000 - 1 1 1 1 1
> [42949549.460000] ata1: irq trap: 66000 - 1 1 1 1 1
> [42949549.460000] ata1: irq trap: 67000 - 1 1 1 1 1
> [42949549.470000] ata1: irq trap: 68000 - 1 1 1 1 1
> [42949549.470000] ata1: irq trap: 69000 - 1 1 1 1 1
> [42949549.470000] ata1: irq trap: 70000 - 1 1 1 1 1
> [42949549.480000] ata1: irq trap: 71000 - 1 1 1 1 1
> [42949549.480000] ata1: irq trap: 72000 - 1 1 1 1 1
> [42949549.480000] ata1: irq trap: 73000 - 1 1 1 1 1
> [42949549.490000] ata1: irq trap: 74000 - 1 1 1 1 1
> [42949549.490000] ata1: irq trap: 75000 - 1 1 1 1 1
> [42949549.490000] ata1: irq trap: 76000 - 1 1 1 1 1
> [42949549.490000] ata1: irq trap: 77000 - 1 1 1 1 1
> [42949549.500000] ata1: irq trap: 78000 - 1 1 1 1 1
> [42949549.500000] ata1: irq trap: 79000 - 1 1 1 1 1
> [42949549.500000] ata1: irq trap: 80000 - 1 1 1 1 1
> [42949549.510000] ata1: irq trap: 81000 - 1 1 1 1 1
> [42949549.510000] ata1: irq trap: 82000 - 1 1 1 1 1
> [42949549.510000] ata1: irq trap: 83000 - 1 1 1 1 1
> [42949549.510000] ata1: irq trap: 84000 - 1 1 1 1 1
> [42949549.520000] ata1: irq trap: 85000 - 1 1 1 1 1
> [42949549.520000] ata1: irq trap: 86000 - 1 1 1 1 1
> [42949549.520000] ata1: irq trap: 87000 - 1 1 1 1 1
> [42949549.530000] ata1: irq trap: 88000 - 1 1 1 1 1
> [42949549.530000] ata1: irq trap: 89000 - 1 1 1 1 1
> [42949549.530000] ata1: irq trap: 90000 - 1 1 1 1 1
> [42949549.530000] ata1: irq trap: 91000 - 1 1 1 1 1
> [42949549.540000] ata1: irq trap: 92000 - 1 1 1 1 1
> [42949549.540000] ata1: irq trap: 93000 - 1 1 1 1 1
> [42949549.540000] ata1: irq trap: 94000 - 1 1 1 1 1
> [42949549.550000] ata1: irq trap: 95000 - 1 1 1 1 1
> [42949549.550000] ata1: irq trap: 96000 - 1 1 1 1 1
> [42949549.550000] ata1: irq trap: 97000 - 1 1 1 1 1
> [42949549.560000] ata1: irq trap: 98000 - 1 1 1 1 1
> [42949549.560000] ata1: irq trap: 99000 - 1 1 1 1 1
> [42949549.560000] irq 27: nobody cared (try booting with the "irqpoll" option)
> [42949549.560000] handlers:
> [42949549.560000] [<c010de2c>] (ata_interrupt+0x0/0x278)
> [42949549.560000] Disabling IRQ #27
> [42949579.250000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0
> action 0x2 frozen
> [42949579.250000] ata1.00: (BMDMA stat 0x4)
> [42949579.250000] ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
> [42949579.250000] ata1: soft resetting port
> [42949609.290000] ata1.00: qc timeout (cmd 0xec)
> [42949609.290000] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [42949609.290000] ata1.00: revalidation failed (errno=-5)
> [42949609.290000] ata1: failed to recover some devices, retrying in 5 secs
> [42949614.300000] ata1: soft resetting port
> [42949644.480000] ata1.00: qc timeout (cmd 0xec)
> [42949644.480000] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [42949644.480000] ata1.00: revalidation failed (errno=-5)
> [42949644.480000] ata1: failed to recover some devices, retrying in 5 secs
> [42949649.490000] ata1: soft resetting port
> [    6.690000] ata1.00: qc timeout (cmd 0xec)
> [    6.690000] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [    6.690000] ata1.00: revalidation failed (errno=-5)
> [    6.690000] ata1.00: disabled
> [    7.200000] ata1: soft resetting port
> [   37.360000] ata1.00: qc timeout (cmd 0xec)
> [   37.360000] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   37.870000] ata1: soft resetting port
> [   68.050000] ata1.00: qc timeout (cmd 0xec)
> [   68.050000] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   68.560000] ata1: soft resetting port
> [   98.740000] ata1.00: qc timeout (cmd 0xec)
> [   98.740000] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   99.250000] ata1: soft resetting port
> [   99.430000] ata1: no sense translation for status: 0x40
> [   99.430000] ata1: translated ATA stat/err 0x40/00 to SCSI
> SK/ASC/ASCQ 0xb/00/00
> [   99.430000] ata1: EH complete
> [   99.430000] sd 0:0:0:0: SCSI error: return code = 0x00040000
> [   99.430000] end_request: I/O error, dev sda, sector 0
> [   99.430000] Buffer I/O error on device sda, logical block 0
> [   99.430000] sd 0:0:0:0: SCSI error: return code = 0x00040000
> [   99.430000] end_request: I/O error, dev sda, sector 0
> [   99.430000] Buffer I/O error on device sda, logical block 0
> [   99.430000]  unable to read partition table
> [   99.430000] sd 0:0:0:0: Attached scsi disk sda
> [   99.430000] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [  634.970000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
> from 0001d308
> [  640.970000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
> from 0001d308
> [  706.970000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
> from 0001d308
> [  770.970000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
> from 0001d308
> [  836.970000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
> from 0001d308
> [  899.970000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
> from 0001d308
> [  963.970000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
> from 0001d308
> [ 1092.970000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
> from 0001d308
> [ 1221.960000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
> from 0001d308
> [ 1349.960000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
> from 0001d308
> [ 1477.960000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
> from 0001d308
> [ 1604.960000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
> from 0001d308
> [ 1859.950000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
> from 0001d308
>
