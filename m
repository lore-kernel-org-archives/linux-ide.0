From: Mark Lord <liml@rtr.ca>
Subject: Bug/exploit in ide_taskfile_ioctl() ??
Date: Wed, 13 Apr 2005 14:55:08 -0400
Message-ID: <425D6B0C.1080502@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:13201 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261201AbVDMSzO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Apr 2005 14:55:14 -0400
Received: from [10.0.0.3] (ibbm.localnet [10.0.0.3])
	by mail.rtr.ca (Postfix) with ESMTP id 9184983002C
	for <linux-ide@vger.kernel.org>; Wed, 13 Apr 2005 14:55:02 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

Hi,

I just noticed this code (below) in ide-taskfile.c.
In particular, the two lines that initialize argsptr and hobsptr
appear to be completely incorrect, and if this function is ever
invoked they stand a good chance of causing memory corruption

int ide_taskfile_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
{
         ide_task_request_t      *req_task;
         ide_task_t              args;
         u8 *outbuf              = NULL;
         u8 *inbuf               = NULL;
         task_ioreg_t *argsptr   = args.tfRegister;
         task_ioreg_t *hobsptr   = args.hobRegister;
         int err                 = 0;
   ...
         memcpy(argsptr, req_task->io_ports, HDIO_DRIVE_TASK_HDR_SIZE);
         memcpy(hobsptr, req_task->hob_ports, HDIO_DRIVE_HOB_HDR_SIZE);
   ...


I belive there's a missing '&' on both of the initialization lines.

Cheers
