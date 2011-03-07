From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] libata: Include WWN ID in inquiry VPD emulation
Date: Mon, 07 Mar 2011 09:53:14 +0100
Message-ID: <4D749CFA.3050104@suse.de>
References: <20110304085501.8B331F90E1@ochil.suse.de> <20110304170904.GW20499@htj.dyndns.org> <4D711FD7.6080507@pobox.com> <4D748FF8.1070903@suse.de> <4D7496FD.6040202@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040407050607000502010000"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35889 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650Ab1CGInG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Mar 2011 03:43:06 -0500
In-Reply-To: <4D7496FD.6040202@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040407050607000502010000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

On 03/07/2011 09:27 AM, Jeff Garzik wrote:
> On 03/07/2011 02:57 AM, Hannes Reinecke wrote:
>> On 03/04/2011 06:22 PM, Jeff Garzik wrote:
>>> And if you're highly motivated, a separate patch to update
>>> include/linux/ata.h to return bool for obvious ata_id_has_xxx functions
>>> would be nice too.
> 
>> Like this?
> 
>> -static inline int ata_id_has_fua(const u16 *id)
>> +static inline bool ata_id_has_fua(const u16 *id)
>>  {
>>      if ((id[ATA_ID_CFSSE] & 0xC000) != 0x4000)
>>          return 0;
>>      return id[ATA_ID_CFSSE] & (1 << 6);
>>  }
> 
> Not _quite_ that easy...  one must also s/0/false/ and s/1/true/ where
> the return value is explicit, rather than the result of an expression.
> 
Ok, there you go.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Markus Rex, HRB 16746 (AG Nürnberg)

--------------040407050607000502010000
Content-Type: text/x-patch;
 name="libata-Use-bool-return-value-for-ata_id_XXX.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libata-Use-bool-return-value-for-ata_id_XXX.patch"

>From 8504e96908fb272c53278b7845bc63679f238358 Mon Sep 17 00:00:00 2001
From: Hannes Reinecke <hare@suse.de>
Date: Mon, 7 Mar 2011 08:43:37 +0100
Subject: [PATCH] libata: Use 'bool' return value for ata_id_XXX

Most ata_id_XXX inlines are simple tests, so we should set
the return value to 'bool' here.

Signed-off-by: Hannes Reinecke <hare@suse.de>

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 198e1ea..1868213 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -600,42 +600,42 @@ static inline bool ata_id_has_dipm(const u16 *id)
 }
 
 
-static inline int ata_id_has_fua(const u16 *id)
+static inline bool ata_id_has_fua(const u16 *id)
 {
 	if ((id[ATA_ID_CFSSE] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	return id[ATA_ID_CFSSE] & (1 << 6);
 }
 
-static inline int ata_id_has_flush(const u16 *id)
+static inline bool ata_id_has_flush(const u16 *id)
 {
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	return id[ATA_ID_COMMAND_SET_2] & (1 << 12);
 }
 
-static inline int ata_id_flush_enabled(const u16 *id)
+static inline bool ata_id_flush_enabled(const u16 *id)
 {
 	if (ata_id_has_flush(id) == 0)
-		return 0;
+		return false;
 	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	return id[ATA_ID_CFS_ENABLE_2] & (1 << 12);
 }
 
-static inline int ata_id_has_flush_ext(const u16 *id)
+static inline bool ata_id_has_flush_ext(const u16 *id)
 {
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	return id[ATA_ID_COMMAND_SET_2] & (1 << 13);
 }
 
-static inline int ata_id_flush_ext_enabled(const u16 *id)
+static inline bool ata_id_flush_ext_enabled(const u16 *id)
 {
 	if (ata_id_has_flush_ext(id) == 0)
-		return 0;
+		return false;
 	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	/*
 	 * some Maxtor disks have bit 13 defined incorrectly
 	 * so check bit 10 too
@@ -688,64 +688,64 @@ static inline u16 ata_id_logical_sector_offset(const u16 *id,
 	return 0;
 }
 
-static inline int ata_id_has_lba48(const u16 *id)
+static inline bool ata_id_has_lba48(const u16 *id)
 {
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	if (!ata_id_u64(id, ATA_ID_LBA_CAPACITY_2))
-		return 0;
+		return false;
 	return id[ATA_ID_COMMAND_SET_2] & (1 << 10);
 }
 
-static inline int ata_id_lba48_enabled(const u16 *id)
+static inline bool ata_id_lba48_enabled(const u16 *id)
 {
 	if (ata_id_has_lba48(id) == 0)
-		return 0;
+		return false;
 	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	return id[ATA_ID_CFS_ENABLE_2] & (1 << 10);
 }
 
-static inline int ata_id_hpa_enabled(const u16 *id)
+static inline bool ata_id_hpa_enabled(const u16 *id)
 {
 	/* Yes children, word 83 valid bits cover word 82 data */
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	/* And 87 covers 85-87 */
 	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	/* Check command sets enabled as well as supported */
 	if ((id[ATA_ID_CFS_ENABLE_1] & (1 << 10)) == 0)
-		return 0;
+		return false;
 	return id[ATA_ID_COMMAND_SET_1] & (1 << 10);
 }
 
-static inline int ata_id_has_wcache(const u16 *id)
+static inline bool ata_id_has_wcache(const u16 *id)
 {
 	/* Yes children, word 83 valid bits cover word 82 data */
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	return id[ATA_ID_COMMAND_SET_1] & (1 << 5);
 }
 
-static inline int ata_id_has_pm(const u16 *id)
+static inline bool ata_id_has_pm(const u16 *id)
 {
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	return id[ATA_ID_COMMAND_SET_1] & (1 << 3);
 }
 
-static inline int ata_id_rahead_enabled(const u16 *id)
+static inline bool ata_id_rahead_enabled(const u16 *id)
 {
 	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	return id[ATA_ID_CFS_ENABLE_1] & (1 << 6);
 }
 
-static inline int ata_id_wcache_enabled(const u16 *id)
+static inline bool ata_id_wcache_enabled(const u16 *id)
 {
 	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	return id[ATA_ID_CFS_ENABLE_1] & (1 << 5);
 }
 
@@ -775,7 +775,7 @@ static inline unsigned int ata_id_major_version(const u16 *id)
 	return mver;
 }
 
-static inline int ata_id_is_sata(const u16 *id)
+static inline bool ata_id_is_sata(const u16 *id)
 {
 	/*
 	 * See if word 93 is 0 AND drive is at least ATA-5 compatible
@@ -784,37 +784,35 @@ static inline int ata_id_is_sata(const u16 *id)
 	 * 0x0000 and 0xffff along with the earlier ATA revisions...
 	 */
 	if (id[ATA_ID_HW_CONFIG] == 0 && (short)id[ATA_ID_MAJOR_VER] >= 0x0020)
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
-static inline int ata_id_has_tpm(const u16 *id)
+static inline bool ata_id_has_tpm(const u16 *id)
 {
 	/* The TPM bits are only valid on ATA8 */
 	if (ata_id_major_version(id) < 8)
-		return 0;
+		return false;
 	if ((id[48] & 0xC000) != 0x4000)
-		return 0;
+		return false;
 	return id[48] & (1 << 0);
 }
 
-static inline int ata_id_has_dword_io(const u16 *id)
+static inline bool ata_id_has_dword_io(const u16 *id)
 {
 	/* ATA 8 reuses this flag for "trusted" computing */
 	if (ata_id_major_version(id) > 7)
-		return 0;
-	if (id[ATA_ID_DWORD_IO] & (1 << 0))
-		return 1;
-	return 0;
+		return false;
+	return id[ATA_ID_DWORD_IO] & (1 << 0);
 }
 
-static inline int ata_id_has_unload(const u16 *id)
+static inline bool ata_id_has_unload(const u16 *id)
 {
 	if (ata_id_major_version(id) >= 7 &&
 	    (id[ATA_ID_CFSSE] & 0xC000) == 0x4000 &&
 	    id[ATA_ID_CFSSE] & (1 << 13))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 static inline bool ata_id_has_wwn(const u16 *id)
@@ -850,25 +848,25 @@ static inline int ata_id_rotation_rate(const u16 *id)
 	return val;
 }
 
-static inline int ata_id_has_trim(const u16 *id)
+static inline bool ata_id_has_trim(const u16 *id)
 {
 	if (ata_id_major_version(id) >= 7 &&
 	    (id[ATA_ID_DATA_SET_MGMT] & 1))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
-static inline int ata_id_has_zero_after_trim(const u16 *id)
+static inline bool ata_id_has_zero_after_trim(const u16 *id)
 {
 	/* DSM supported, deterministic read, and read zero after trim set */
 	if (ata_id_has_trim(id) &&
 	    (id[ATA_ID_ADDITIONAL_SUPP] & 0x4020) == 0x4020)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
-static inline int ata_id_current_chs_valid(const u16 *id)
+static inline bool ata_id_current_chs_valid(const u16 *id)
 {
 	/* For ATA-1 devices, if the INITIALIZE DEVICE PARAMETERS command
 	   has not been issued to the device then the values of
@@ -880,11 +878,11 @@ static inline int ata_id_current_chs_valid(const u16 *id)
 		id[ATA_ID_CUR_SECTORS];    /* sectors in current translation */
 }
 
-static inline int ata_id_is_cfa(const u16 *id)
+static inline bool ata_id_is_cfa(const u16 *id)
 {
 	if ((id[ATA_ID_CONFIG] == 0x848A) ||	/* Traditional CF */
 	    (id[ATA_ID_CONFIG] == 0x844A))	/* Delkin Devices CF */
-		return 1;
+		return true;
 	/*
 	 * CF specs don't require specific value in the word 0 anymore and yet
 	 * they forbid to report the ATA version in the word 80 and require the
@@ -893,44 +891,40 @@ static inline int ata_id_is_cfa(const u16 *id)
 	 * and while those that don't indicate CFA feature support need some
 	 * sort of quirk list, it seems impractical for the ones that do...
 	 */
-	if ((id[ATA_ID_COMMAND_SET_2] & 0xC004) == 0x4004)
-		return 1;
-	return 0;
+	return (id[ATA_ID_COMMAND_SET_2] & 0xC004) == 0x4004;
 }
 
-static inline int ata_id_is_ssd(const u16 *id)
+static inline bool ata_id_is_ssd(const u16 *id)
 {
 	return id[ATA_ID_ROT_SPEED] == 0x01;
 }
 
-static inline int ata_id_pio_need_iordy(const u16 *id, const u8 pio)
+static inline bool ata_id_pio_need_iordy(const u16 *id, const u8 pio)
 {
 	/* CF spec. r4.1 Table 22 says no IORDY on PIO5 and PIO6. */
 	if (pio > 4 && ata_id_is_cfa(id))
-		return 0;
+		return false;
 	/* For PIO3 and higher it is mandatory. */
 	if (pio > 2)
-		return 1;
+		return true;
 	/* Turn it on when possible. */
-	if (ata_id_has_iordy(id))
-		return 1;
-	return 0;
+	return ata_id_has_iordy(id);
 }
 
-static inline int ata_drive_40wire(const u16 *dev_id)
+static inline bool ata_drive_40wire(const u16 *dev_id)
 {
 	if (ata_id_is_sata(dev_id))
-		return 0;	/* SATA */
-	if ((dev_id[ATA_ID_HW_CONFIG] & 0xE000) == 0x6000)
-		return 0;	/* 80 wire */
-	return 1;
+		return false;	/* SATA */
+	if (dev_id[ATA_ID_HW_CONFIG] & 0xE000) == 0x6000;
+		return false;	/* 80 wire */
+	return true;
 }
 
-static inline int ata_drive_40wire_relaxed(const u16 *dev_id)
+static inline bool ata_drive_40wire_relaxed(const u16 *dev_id)
 {
 	if ((dev_id[ATA_ID_HW_CONFIG] & 0x2000) == 0x2000)
-		return 0;	/* 80 wire */
-	return 1;
+		return false;	/* 80 wire */
+	return true;
 }
 
 static inline int atapi_cdb_len(const u16 *dev_id)
@@ -943,12 +937,12 @@ static inline int atapi_cdb_len(const u16 *dev_id)
 	}
 }
 
-static inline int atapi_command_packet_set(const u16 *dev_id)
+static inline bool atapi_command_packet_set(const u16 *dev_id)
 {
 	return (dev_id[ATA_ID_CONFIG] >> 8) & 0x1f;
 }
 
-static inline int atapi_id_dmadir(const u16 *dev_id)
+static inline bool atapi_id_dmadir(const u16 *dev_id)
 {
 	return ata_id_major_version(dev_id) >= 7 && (dev_id[62] & 0x8000);
 }
@@ -961,13 +955,13 @@ static inline int atapi_id_dmadir(const u16 *dev_id)
  *
  * It is called only once for each device.
  */
-static inline int ata_id_is_lba_capacity_ok(u16 *id)
+static inline bool ata_id_is_lba_capacity_ok(u16 *id)
 {
 	unsigned long lba_sects, chs_sects, head, tail;
 
 	/* No non-LBA info .. so valid! */
 	if (id[ATA_ID_CYLS] == 0)
-		return 1;
+		return true;
 
 	lba_sects = ata_id_u32(id, ATA_ID_LBA_CAPACITY);
 
@@ -982,13 +976,13 @@ static inline int ata_id_is_lba_capacity_ok(u16 *id)
 	    id[ATA_ID_SECTORS] == 63 &&
 	    (id[ATA_ID_HEADS] == 15 || id[ATA_ID_HEADS] == 16) &&
 	    (lba_sects >= 16383 * 63 * id[ATA_ID_HEADS]))
-		return 1;
+		return true;
 
 	chs_sects = id[ATA_ID_CYLS] * id[ATA_ID_HEADS] * id[ATA_ID_SECTORS];
 
 	/* perform a rough sanity check on lba_sects: within 10% is OK */
 	if (lba_sects - chs_sects < chs_sects/10)
-		return 1;
+		return true;
 
 	/* some drives have the word order reversed */
 	head = (lba_sects >> 16) & 0xffff;
@@ -997,10 +991,10 @@ static inline int ata_id_is_lba_capacity_ok(u16 *id)
 
 	if (lba_sects - chs_sects < chs_sects/10) {
 		*(__le32 *)&id[ATA_ID_LBA_CAPACITY] = __cpu_to_le32(lba_sects);
-		return 1;	/* LBA capacity is (now) good */
+		return true;	/* LBA capacity is (now) good */
 	}
 
-	return 0;	/* LBA capacity value may be bad */
+	return false;	/* LBA capacity value may be bad */
 }
 
 static inline void ata_id_to_hd_driveid(u16 *id)
@@ -1058,19 +1052,19 @@ static inline int is_multi_taskfile(struct ata_taskfile *tf)
 	       (tf->command == ATA_CMD_WRITE_MULTI_FUA_EXT);
 }
 
-static inline int ata_ok(u8 status)
+static inline bool ata_ok(u8 status)
 {
 	return ((status & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ | ATA_ERR))
 			== ATA_DRDY);
 }
 
-static inline int lba_28_ok(u64 block, u32 n_block)
+static inline bool lba_28_ok(u64 block, u32 n_block)
 {
 	/* check the ending block number: must be LESS THAN 0x0fffffff */
 	return ((block + n_block) < ((1 << 28) - 1)) && (n_block <= 256);
 }
 
-static inline int lba_48_ok(u64 block, u32 n_block)
+static inline bool lba_48_ok(u64 block, u32 n_block)
 {
 	/* check the ending block number */
 	return ((block + n_block - 1) < ((u64)1 << 48)) && (n_block <= 65536);

--------------040407050607000502010000--
