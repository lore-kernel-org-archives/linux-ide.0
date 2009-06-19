From: Christian Engelmayer <christian.engelmayer@frequentis.com>
Subject: potential memory overrun in ata_id_to_hd_driveid() on big endian
 machines
Date: Fri, 19 Jun 2009 08:41:05 +0200
Message-ID: <20090619084105.4cdf78be@frequentis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webmail.frequentis.com ([213.47.210.151]:22156 "EHLO
	webmail.frequentis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbZFSG4T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Jun 2009 02:56:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: christian.engelmayer@frequentis.com, linux-ide@vger.kernel.org

Please have a look at the usage of ata_id_to_hd_driveid() in ide-ioctls.c.

u16 array 'id' is allocated depending on the command, which might result in
142 byte. Indexing into the array at position 'ATA_ID_LBA_CAPACITY_2' in
ata_id_to_hd_driveid() would overrun the allocated memory in that case.

Regards,
 Christian

ide-ioctls.c:

	static int ide_get_identity_ioctl(ide_drive_t *drive, unsigned int cmd,
					  unsigned long arg)

	u16 *id = NULL;
	int size = (cmd == HDIO_GET_IDENTITY) ? (ATA_ID_WORDS * 2) : 142;

	..

	id = kmalloc(size, GFP_KERNEL);

	..

	ata_id_to_hd_driveid(id);

	..

ata.h:

	static inline void ata_id_to_hd_driveid(u16 *id)
	{
	#ifdef __BIG_ENDIAN

	..

	*(u64 *)&id[ATA_ID_LBA_CAPACITY_2] =
		ata_id_u64(id, ATA_ID_LBA_CAPACITY_2);
