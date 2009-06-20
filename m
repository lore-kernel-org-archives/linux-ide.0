From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: potential memory overrun in ata_id_to_hd_driveid() on big endian
   machines
Date: Sat, 20 Jun 2009 15:05:49 -0600
Message-ID: <4A3D4F2D.7030906@gmail.com>
References: <20090619084105.4cdf78be@frequentis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f176.google.com ([209.85.210.176]:56184 "EHLO
	mail-yx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbZFTVLf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Jun 2009 17:11:35 -0400
Received: by yxe6 with SMTP id 6so81465yxe.33
        for <linux-ide@vger.kernel.org>; Sat, 20 Jun 2009 14:11:37 -0700 (PDT)
In-Reply-To: <20090619084105.4cdf78be@frequentis.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Engelmayer <christian.engelmayer@frequentis.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

On 06/19/2009 12:41 AM, Christian Engelmayer wrote:
> Please have a look at the usage of ata_id_to_hd_driveid() in ide-ioctls.c.
>
> u16 array 'id' is allocated depending on the command, which might result in
> 142 byte. Indexing into the array at position 'ATA_ID_LBA_CAPACITY_2' in
> ata_id_to_hd_driveid() would overrun the allocated memory in that case.

Looks like ata_id_to_hd_driveid assumes the id memory is fully 
allocated, which seems a reasonable assumption. ide_get_identity_ioctl 
should likely allocate the full ATA_ID_WORDS * 2 unconditionally even if 
only part of it is used.

>
> Regards,
>   Christian
>
> ide-ioctls.c:
>
> 	static int ide_get_identity_ioctl(ide_drive_t *drive, unsigned int cmd,
> 					  unsigned long arg)
>
> 	u16 *id = NULL;
> 	int size = (cmd == HDIO_GET_IDENTITY) ? (ATA_ID_WORDS * 2) : 142;
>
> 	..
>
> 	id = kmalloc(size, GFP_KERNEL);
>
> 	..
>
> 	ata_id_to_hd_driveid(id);
>
> 	..
>
> ata.h:
>
> 	static inline void ata_id_to_hd_driveid(u16 *id)
> 	{
> 	#ifdef __BIG_ENDIAN
>
> 	..
>
> 	*(u64 *)&id[ATA_ID_LBA_CAPACITY_2] =
> 		ata_id_u64(id, ATA_ID_LBA_CAPACITY_2);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

