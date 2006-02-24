From: Benjamin Livelsberger <livebe01@nist.gov>
Subject: HDIO_DRIVE_TASKFILE questions
Date: Fri, 24 Feb 2006 17:27:56 -0500
Message-ID: <751C3194-99DB-40D7-84EA-E3D93F763197@nist.gov>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rimp2.nist.gov ([129.6.16.227]:45293 "EHLO smtp.nist.gov")
	by vger.kernel.org with ESMTP id S932617AbWBXW20 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Feb 2006 17:28:26 -0500
Received: from postmark.nist.gov (pushme.nist.gov [129.6.16.92])
	by smtp.nist.gov (8.13.1/8.13.1) with ESMTP id k1OMSNbW030356
	for <linux-ide@vger.kernel.org>; Fri, 24 Feb 2006 17:28:23 -0500
Received: from [129.6.58.247] ([129.6.58.247])
	by postmark.nist.gov (8.12.5/8.12.5) with ESMTP id k1OMRvfH027249
	for <linux-ide@vger.kernel.org>; Fri, 24 Feb 2006 17:27:57 -0500 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have a question about the HDIO_DRIVE_TASKFILE ioctl.  My goal is to  
be able to send any command defined in the ATAPI-7 spec to a hard  
drive.  I am starting by trying to get the IDENTIFY DEVICE command to  
work and will move on to more advanced commands like READ DMA, READ  
SECTORS, WRITE DMA and WRITE SECTORS.

Can anyone suggest good resources for this endeavor?  I've been  
getting most of my information from  Documentation/ioctls/hdio.txt  
and the hdparm and smartmontools source code.

When I run my program the ioctl returns a -1 (indicating an error)  
and errno = EFAULT (14).

dmesg looks like:
Feb 24 16:54:29 kidd kernel: (in generic_ide_ioctl) IOCTL = 0x5325
Feb 24 16:54:30 kidd kernel: (in generic_ide_ioctl) IOCTL = 0x301
Feb 24 16:54:30 kidd kernel: (in generic_ide_ioctl) IOCTL = 0x30D
Feb 24 16:54:30 kidd kernel: (in generic_ide_ioctl) IOCTL = 0x31D
Feb 24 16:54:30 kidd kernel: hda: in/out command without data
Feb 24 16:54:31 kidd kernel: (in generic_ide_ioctl) IOCTL = 0x5326

I am running the 2.6.11-1.0 kernel.  Here's my code:

struct {
     ide_task_request_t req_task;
     int outbuf[0];
     int inbuf[512];
   } task;

   memset(&task, 0, sizeof(task));
   task_struct_t *taskfile = (task_struct_t *) task.req_task.io_ports;

   int code = 0;

   taskfile->data           = 0;
   taskfile->feature        = 0;
   taskfile->sector_count   = 0;
   taskfile->sector_number  = 0;
   taskfile->low_cylinder   = 0;
   taskfile->high_cylinder  = 0;
   taskfile->device_head    = 0x10;
   taskfile->command        = 0xEC;

   task.req_task.data_phase  = TASKFILE_OUT; /*  data phase (see  
hdio.txt for details)*/
   task.req_task.req_cmd     = IDE_DRIVE_TASK_IN; /* command type */

   task.req_task.out_size = sizeof(task.outbuf);
   task.req_task.in_size  = sizeof(task.inbuf);

   code = ioctl(dd->fd, HDIO_DRIVE_TASKFILE, &task);
   if (code){
     printf("ioctl(HDIO_DRIVE_TASKFILE) status\t= %d\nerrno\t= %d\n",  
code, errno);
     return 1;
   }

Ideas? Should I be using TASKFILE_IN and IDE_DRIVE_TASK_IN for the  
data_phase and req_cmd fields since IDENTIFY DEVICE does not write to  
the drive, but instead receives data from it?  When I tried this I  
lost access to the drive and dmesg kept giving me: "kernel: hda: lost  
interrupt."

thanks,

Benjamin Livelsberger
Computer Scientist
Information Technology Laboratory,
National Institute of Standards and Technology
301.975.4411


