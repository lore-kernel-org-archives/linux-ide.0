From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ahci 0000:00:1f.2: DMA-API: device driver maps memory from stack
Date: Fri, 27 Feb 2009 23:21:47 -0600
Message-ID: <49A8C9EB.3080803@gmail.com>
References: <20090227184250.3dd6e7ce@dhcp-100-2-144.bos.redhat.com>	<49A8A3BB.9070903@gmail.com> <20090228125014J.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:20374 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbZB1FVw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Feb 2009 00:21:52 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1059058yxm.1
        for <linux-ide@vger.kernel.org>; Fri, 27 Feb 2009 21:21:49 -0800 (PST)
In-Reply-To: <20090228125014J.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org, cebbert@redhat.com

FUJITA Tomonori wrote:
>> One could print out where buf points in 
>> this function and see if that is the case. Sense buffer gets allocated 
>> by the SCSI layer..
> 
> I guess that SCSI-ml doesn't use a buffer on the stack for
> scmd->sense_buffer... atapi_eh_clear_ua() looks guilty?
> 
> 
> static int atapi_eh_clear_ua(struct ata_device *dev)
> {
> 	int i;
> 
> 	for (i = 0; i < ATA_EH_UA_TRIES; i++) {
> 		u8 sense_buffer[SCSI_SENSE_BUFFERSIZE];
> 		u8 sense_key = 0;
> 		unsigned int err_mask;
> 
> 		err_mask = atapi_eh_tur(dev, &sense_key);
> 		if (err_mask != 0 && err_mask != AC_ERR_DEV) {
> 			ata_dev_printk(dev, KERN_WARNING, "TEST_UNIT_READY "
> 				"failed (err_mask=0x%x)\n", err_mask);
> 			return -EIO;
> 		}
> 
> 		if (!err_mask || sense_key != UNIT_ATTENTION)
> 			return 0;
> 
> 		err_mask = atapi_eh_request_sense(dev, sense_buffer, sense_key);
> 

I don't think this is the path that Chuck's warning came through, that 
one looks like atapi_eh_request_sense. But yeah, this code does look 
bad, we DMA into that sense buffer so it can't be on the stack.
