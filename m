From: "Anand Kulkarni" <anandkulkarni@gmail.com>
Subject: [PATCH 2.6.20] libata: Support HDIO_DRIVE_TASKFILE ioctl
Date: Wed, 21 Feb 2007 18:13:38 -0800
Message-ID: <31e4e9500702211813g6d3d6431oda1f6191f056a02e@mail.gmail.com>
Reply-To: anand.kulkarni.remove.this@banashankari.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:38400 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbXBVCNm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 21:13:42 -0500
Received: by ug-out-1314.google.com with SMTP id 44so19233uga
        for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 18:13:40 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Anand.Kulkarni@hitachigst.com

Hi,

Attached is a patch to allow HDIO_DRIVE_TASKFILE ioctl calls to libata
devices so that arbitrary ATA commands that need PIO data transfers in
either direction can be issued. I have tested it with linux kernel
2.6.20. The format of the input arguments is the same as for the
regular ATA HDIO_DRIVE_TASKFILE ioctl : Code that makes ioctl calls to
ATA devices on /dev/hda can be sent as is to SATA devices on /dev/sda.

Since this is the first time I am sending a patch, please let me know
if I should do anything differently.

Regards,
Anand.

Anand Kulkarni
SJRC 3403 Yerba Buena Road
San Jose, CA 95135
Ph : 408 717 5128
Fax : 408 717 9065

From: Anand Kulkarni <Anand.Kulkarni@hitachigst.com>

Add support for the HDIO_DRIVE_TASKFILE ioctl to libata devices. This
permits sending
arbitrary ATA commands to the device. Currently only non-data and PIO
commands
are supported. Based on the ide_taskfile_ioctl function in
drivers/ide/ide-taskfile.c

Signed-off: Anand Kulkarni <Anand.Kulkarni@hitachigst.com>
---

--- linux-2.6.20_taskfile10/drivers/ata/libata-scsi.c.orig      2007-02-12
17:29:21.000000000 -0800
+++ linux-2.6.20_taskfile10/drivers/ata/libata-scsi.c   2007-02-15
14:32:46.000000000 -0800
@@ -45,6 +45,7 @@
 #include <scsi/scsi_transport.h>
 #include <linux/libata.h>
 #include <linux/hdreg.h>
+#include <linux/ide.h>
 #include <asm/uaccess.h>

 #include "libata.h"
@@ -259,6 +260,235 @@ error:
 }

 /**
+ *     ata_taskfile_ioctl - Handler for HDIO_DRIVE_TASKFILE ioctl
+ *     @scsidev: Device to which we are issuing command
+ *     @arg: User provided data for issuing command
+ *
+ *     LOCKING:
+ *     Defined by the SCSI layer.  We don't really care.
+ *
+ *     @arg is pointer to type ide_task_request_t
+ *             Following fields are mandotory
+ *             arg->io_ports[8];
+ *                     task_ioreg_t feature;           Feature
+ *                     task_ioreg_t sector_count;      NumSectors
+ *                     task_ioreg_t sector_number;     Sector / LBA_L
+ *                     task_ioreg_t low_cylinder;      LCyl /  LBA_M
+ *                     task_ioreg_t high_cylinder;     HCyl /  LBA_H
+ *                     task_ioreg_t device_head;       Select Device/Head
+ *                     task_ioreg_t command;           Command
+ *             arg->hob_ports[8];
+ *             arg->data_phase;  --- TASKFILE_NO_DATA | TASKFILE_IN |
TASKFILE_OUT
+ *             arg->req_cmd;     --- not used
+ *             arg->out_size;
+ *             arg->in_size;
+ *
+ *     RETURNS:
+ *     Zero on success, negative errno on error.
+ */
+
+int ata_taskfile_ioctl(struct scsi_device *scsidev, void __user *arg)
+{
+       ide_task_request_t      * req_task;
+       task_struct_t           * iop_ptr;
+       task_struct_t           * hob_ptr;
+
+       u8 *outbuf      = NULL;
+       u8 *inbuf       = NULL;
+       u8 *argbuf      = NULL;
+       int argsize     = 0;
+
+       int tasksize    = sizeof(struct ide_task_request_s);
+       int taskin      = 0;
+       int taskout     = 0;
+
+       int err         = 0;
+
+       u8 scsi_cmd[MAX_COMMAND_SIZE];
+       struct scsi_sense_hdr sshdr;
+       enum dma_data_direction data_dir = DMA_NONE;
+
+       if (NULL == (void *)arg)
+               return -EINVAL;
+
+       req_task = kzalloc(tasksize, GFP_KERNEL);
+       if (req_task == NULL) return -ENOMEM;
+
+       if (copy_from_user(req_task, arg, tasksize)) {
+               kfree(req_task);
+               return -EFAULT;
+       }
+
+       iop_ptr = (task_struct_t *)(req_task->io_ports);
+       hob_ptr = (task_struct_t *)(req_task->hob_ports);
+
+       taskout = (int) req_task->out_size;
+       taskin  = (int) req_task->in_size;
+
+       if (taskout) {
+               int outtotal = tasksize;
+               outbuf = kzalloc(taskout, GFP_KERNEL);
+               if (outbuf == NULL) {
+                       err = -ENOMEM;
+                       goto abort;
+               }
+               if (copy_from_user(outbuf, arg + outtotal, taskout)) {
+                       err = -EFAULT;
+                       goto abort;
+               }
+       }
+
+       if (taskin) {
+               int intotal = tasksize + taskout;
+               inbuf = kzalloc(taskin, GFP_KERNEL);
+               if (inbuf == NULL) {
+                       err = -ENOMEM;
+                       goto abort;
+               }
+               if (copy_from_user(inbuf, arg + intotal, taskin)) {
+                       err = -EFAULT;
+                       goto abort;
+               }
+       }
+
+       /* Setup scsi_cmd for ATA passthrough command */
+       memset(scsi_cmd, 0, sizeof(scsi_cmd));
+       scsi_cmd[0] = ATA_16;
+
+       // Format for Byte 1 and Byte 2 of scsi_cmd for ATA_16/ ATA_12 (as
per T10/04-262r7)
+       // Byte 1 :
+       //      Bit 7-5 : For PIO transfers, log(number of sectors
transferred per interrupt) base2
+       //      Bit 4-1 : Protocol : HardReset, SRST, Idle. Non-data,
+       //                           PIO DataIn, PIO Dataout, DMA, DMAQ,
+       //                           DevDiag, DevReset, UDMA_DataIn,
UDMA_DataOut,
+       //                           FPDMA, rsvd, rsvd, rsvd
+       //      Bit 0   :  0 -->28bit, 1 => 48bit command
+       // Byte 2 :
+       //      Bit 7-6 : OffLine :Indicate if Device expected to tristate
bus for this command
+       //      Bit 5   : Force Check condition and read task registers at
command completion.
+       //      Bit 4   : Reserved
+       //      Bit 3   : T_Dir : 0=>Host to Device, 1 => Device to host
+       //      Bit 2   : BB : 0=> TransferLength is in bytes, 1 =>
TransferLength is in blocks
+       //      Bit 1-0 : source for Transfer_Length : 0=non-data, 1
Feature reg, 2 SectorCount, 3 Transport Specific IU
+       //
+       // scsi_cmd[2]: Transferlength avail in SectorCount register, in
block
+
+       switch (req_task->data_phase) {
+
+       case TASKFILE_NO_DATA:
+               scsi_cmd[1] = 3 << 1;
+               scsi_cmd[2]  = 0;
+               data_dir = DMA_NONE;
+               argsize = 0;
+               argbuf = NULL;
+               break;
+       case TASKFILE_IN:
+               scsi_cmd[1] = 4 << 1;
+               scsi_cmd[2]  = 0x0e;
+               data_dir = DMA_FROM_DEVICE;
+               argsize = taskin;
+               argbuf = inbuf;
+               break;
+       case TASKFILE_OUT:
+               scsi_cmd[1] = 5 << 1;
+               scsi_cmd[2]  = 0x06;
+               data_dir = DMA_TO_DEVICE;
+               argsize = taskout;
+               argbuf = outbuf;
+               break;
+
+       /* currently unsupported transfer modes */
+       case TASKFILE_MULTI_IN:
+       case TASKFILE_MULTI_OUT:
+       case TASKFILE_IN_OUT:
+       case TASKFILE_IN_DMA:
+       case TASKFILE_OUT_DMA:
+       case TASKFILE_IN_DMAQ:
+       case TASKFILE_OUT_DMAQ:
+               err = -EINVAL;
+               goto abort;
+       }
+
+       scsi_cmd[2]  |= 0x20;  // Generate a check condition after every
command
+
+       scsi_cmd[4]  = iop_ptr->feature;   // Feature
+       scsi_cmd[6]  = iop_ptr->sector_count;   // NSector SectorCount
+       scsi_cmd[8]  = iop_ptr->sector_number;   // LBA_L
+       scsi_cmd[10] = iop_ptr->low_cylinder;   // LBA_M
+       scsi_cmd[12] = iop_ptr->high_cylinder;   // LBA_H
+       scsi_cmd[13] = iop_ptr->device_head;   // Device/Head : Device is
overwritten by actual device (Master/Slave)
+
+       scsi_cmd[3]  = hob_ptr->feature;  // Feature_ext
+       scsi_cmd[5]  = hob_ptr->sector_count;  // NSector_ext
+       scsi_cmd[7]  = hob_ptr->sector_number;  // LBA_L_ext
+       scsi_cmd[9]  = hob_ptr->low_cylinder;  // LBA_M_ext
+       scsi_cmd[11] = hob_ptr->high_cylinder;  // LBA_H_ext
+
+       scsi_cmd[14] = iop_ptr->command;   // Command
+
+       if (taskout) {
+               printk(KERN_INFO "DMA_TO_DEVICE %d bytes fr outbuf 0x%.8X
Cmd %2x %2x %2x %2x %2x %2x %2x  \n",
+                               taskout, (int) outbuf,
+                               iop_ptr->command, iop_ptr->feature,
+                               iop_ptr->sector_count,
iop_ptr->sector_number,
+                               iop_ptr->low_cylinder,
iop_ptr->high_cylinder,
+                               iop_ptr->device_head);
+       } else if (taskin) {
+               printk(KERN_INFO "DMA_FROM_DEVICE %d bytes to inbuf 0x%.8X
  Cmd %2x %2x %2x %2x %2x %2x %2x  \n",
+                               taskin, (int) inbuf,
+                               iop_ptr->command, iop_ptr->feature,
+                               iop_ptr->sector_count,
iop_ptr->sector_number,
+                               iop_ptr->low_cylinder,
iop_ptr->high_cylinder,
+                               iop_ptr->device_head);
+       } else {
+               printk(KERN_INFO "NON_DATA    Cmd %2x %2x %2x %2x %2x %2x
%2x  \n",
+                               iop_ptr->command, iop_ptr->feature,
+                               iop_ptr->sector_count,
iop_ptr->sector_number,
+                               iop_ptr->low_cylinder,
iop_ptr->high_cylinder,
+                               iop_ptr->device_head);
+       }
+
+       /* Good values for timeout and retries?  Values below
+          from scsi_ioctl_send_command() for default case... */
+       if (scsi_execute_req(scsidev, scsi_cmd, data_dir, argbuf, argsize,
+                            &sshdr, (10*HZ), 0)) {
+               if (sshdr.sense_key != 0) {
+                   printk(KERN_INFO "Err Sense  %2x %2x %2x %2x\n",
sshdr.response_code, sshdr.sense_key, sshdr.asc, sshdr.ascq);
+                   err = -EIO;
+                   goto abort;
+               }
+       }
+
+       /* Need code to retrieve data from check condition? */
+       if (copy_to_user(arg, req_task, tasksize)) {
+               err = -EFAULT;
+               goto abort;
+       }
+       if (taskout) {
+               int outtotal = tasksize;
+               if (copy_to_user(arg + outtotal, outbuf, taskout)) {
+                       err = -EFAULT;
+                       goto abort;
+               }
+       }
+
+       if (taskin) {
+               int intotal = tasksize + taskout;
+               if (copy_to_user(arg + intotal, inbuf, taskin)) {
+                       err = -EFAULT;
+                       goto abort;
+               }
+       }
+
+abort:
+       if(req_task) kfree(req_task);
+       if(outbuf)   kfree(outbuf);
+       if(inbuf)    kfree(inbuf);
+
+       return err;
+}
+
+/**
  *     ata_task_ioctl - Handler for HDIO_DRIVE_TASK ioctl
  *     @scsidev: Device to which we are issuing command
  *     @arg: User provided data for issuing command
@@ -369,6 +599,11 @@ int ata_scsi_ioctl(struct scsi_device *s
                        return -EACCES;
                return ata_task_ioctl(scsidev, arg);

+       case HDIO_DRIVE_TASKFILE:
+               if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+                       return -EACCES;
+               return ata_taskfile_ioctl(scsidev, arg);
+
        default:
                rc = -ENOTTY;
                break;
