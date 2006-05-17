From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 10/22] libata: use preallocated buffers
Date: Wed, 17 May 2006 13:34:35 +0800
Message-ID: <446AB5EB.5050603@tw.ibm.com>
References: <11473487902895-git-send-email-htejun@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:57506 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932141AbWEQFeg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 01:34:36 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4H5YZA7027145
	for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 01:34:35 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4H5YZKh248638
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 23:34:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4H5YYeb023781
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 23:34:35 -0600
In-Reply-To: <11473487902895-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> It's not a very good idea to allocate memory during EH.  Use
> statically allocated buffer for dev->id[] and add 512byte buffer
> ap->sector_buf.  This buffer is owned by EH (or probing) and to be
> used as temporary buffer for various purposes (IDENTIFY, NCQ log page
> 10h, PM GSCR block).
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> <snip>
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 9c2d4bb..a117ca2 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -360,7 +360,7 @@ struct ata_device {
>  	unsigned long		flags;		/* ATA_DFLAG_xxx */
>  	unsigned int		class;		/* ATA_DEV_xxx */
>  	unsigned int		devno;		/* 0 or 1 */
> -	u16			*id;		/* IDENTIFY xxx DEVICE data */
> +	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
>  	u8			pio_mode;
>  	u8			dma_mode;
>  	u8			xfer_mode;
> @@ -425,6 +425,8 @@ struct ata_port {
>  	struct list_head	eh_done_q;
>  
>  	void			*private_data;
> +
> +	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
>  };
>  
>  struct ata_port_operations {

Reorder ata_host_set->private_data and ata_port->private_data.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Just a minor fix.
Maybe we can make the ->private_data the last one for easier allocation.

--- upstream/include/linux/libata.h	2006-05-16 11:08:54.000000000 +0800
+++ upstream1/include/linux/libata.h	2006-05-17 13:25:24.000000000 +0800
@@ -330,12 +330,12 @@ struct ata_host_set {
 	unsigned long		irq;
 	void __iomem		*mmio_base;
 	unsigned int		n_ports;
-	void			*private_data;
 	const struct ata_port_operations *ops;
 	unsigned long		flags;
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
 	struct ata_port *	ports[0];
+	void			*private_data;
 };
 
 struct ata_queued_cmd {
@@ -492,9 +492,8 @@ struct ata_port {
 	u32			msg_enable;
 	struct list_head	eh_done_q;
 
-	void			*private_data;
-
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
+	void			*private_data;
 };
 
 struct ata_port_operations {



