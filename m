From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: ATAPI tape drives broken with libata
Date: Fri, 21 Sep 2007 11:07:19 +0800
Message-ID: <46F33567.9090103@tw.ibm.com>
References: <46D5F97B.3050808@redhat.com>	<20070830005006.6951265a@the-village.bc.nu>	<46D6EC3B.8090306@redhat.com> <20070831151903.37a60ba9@the-village.bc.nu> <46E966C2.1050405@rtr.ca> <46E97FE8.5090304@rtr.ca> <46E9848E.2000704@rtr.ca>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:57264 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbXIUDHa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 23:07:30 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8L37TgL023436
	for <linux-ide@vger.kernel.org>; Thu, 20 Sep 2007 23:07:29 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8L37Tpf464132
	for <linux-ide@vger.kernel.org>; Thu, 20 Sep 2007 21:07:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8L37Skh017847
	for <linux-ide@vger.kernel.org>; Thu, 20 Sep 2007 21:07:28 -0600
In-Reply-To: <46E9848E.2000704@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chuck Ebbert <cebbert@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, craig48@swbell.net, Jeff Garzik <jeff@garzik.org>

Mark Lord wrote:
> 
> I can read and write the tape successfully, and the written data matches
> what is later read back from it.
> 
> Here's the hack I used.  Not ready for mainline, but perhaps it will
> help Alan or whomever come up with something nice for Jeff.
> 
> --- 2.6.23-rc6/drivers/ata/libata-core.c  2007-09-13 09:49:16.000000000
> -0400
> +++ linux/drivers/ata/libata-core.c     2007-09-13 14:15:57.000000000 -0400
> @@ -4932,9 +4932,9 @@
>                if (unlikely(status & (ATA_ERR | ATA_DF))) {
>                        ata_port_printk(ap, KERN_WARNING, "DRQ=1 with
> device "
>                                        "error, dev_stat 0x%X\n", status);
> -                       qc->err_mask |= AC_ERR_HSM;
> -                       ap->hsm_task_state = HSM_ST_ERR;
> -                       goto fsm_start;
> +                       //qc->err_mask |= AC_ERR_HSM;
> +                       //ap->hsm_task_state = HSM_ST_ERR;
> +                       //goto fsm_start;
>                }
> 
>                /* Send the CDB (atapi) or the first data block (ata pio
> out).
> 

It's strange that the device reports DRQ + ERR at this point since if
it knows something wrong, asking to transfer the CDB doesn't help...

Is the device configured to MWDMA? If yes, maybe it's ATAPI DMA of
the previous command makes the device state machine confused...

Could you please try if the attached debug patch helps? Thanks.
--
albert


diff -Nrup 00_libata-dev/drivers/ata/libata-core.c 01_atapi_dma/drivers/ata/libata-core.c
--- 00_libata-dev/drivers/ata/libata-core.c	2007-09-21 10:35:54.000000000 +0800
+++ 01_atapi_dma/drivers/ata/libata-core.c	2007-09-21 10:49:20.000000000 +0800
@@ -4193,6 +4193,8 @@ static void ata_fill_sg_dumb(struct ata_
 int ata_check_atapi_dma(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	u8 *scsicmd = cmd->cmnd;
 
 	/* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
 	 * few ATAPI devices choke on such DMA requests.
@@ -4200,6 +4202,21 @@ int ata_check_atapi_dma(struct ata_queue
 	if (unlikely(qc->nbytes & 15))
 		return 1;
 
+	switch (scsicmd[0]) {
+	case READ_10:
+	case WRITE_10:
+	case READ_12:
+	case WRITE_12:
+	case READ_6:
+	case WRITE_6:
+	case 0xad: /* READ_DVD_STRUCTURE */
+	case 0xbe: /* READ_CD */
+		/* ATAPI DMA maybe ok */
+		break;
+	default:
+		return 1;
+	}
+
 	if (ap->ops->check_atapi_dma)
 		return ap->ops->check_atapi_dma(qc);
 

