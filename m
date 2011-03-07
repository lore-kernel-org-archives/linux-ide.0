From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] libata: Include WWN ID in inquiry VPD emulation
Date: Mon, 07 Mar 2011 08:57:44 +0100
Message-ID: <4D748FF8.1070903@suse.de>
References: <20110304085501.8B331F90E1@ochil.suse.de> <20110304170904.GW20499@htj.dyndns.org> <4D711FD7.6080507@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000501030705060704020301"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:34715 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab1CGHrf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Mar 2011 02:47:35 -0500
In-Reply-To: <4D711FD7.6080507@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000501030705060704020301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

On 03/04/2011 06:22 PM, Jeff Garzik wrote:
> On 03/04/2011 12:09 PM, Tejun Heo wrote:
>> Hello, Hannes.
>>
>> On Fri, Mar 04, 2011 at 09:55:01AM +0100, Hannes Reinecke wrote:
>>> +static inline int ata_id_has_wwn(const u16 *id)
>>> +{
>>> +    if ((id[ATA_ID_CSF_DEFAULT]&  0xC000) != 0x4000)
>>> +        return 0;
>>> +    return id[ATA_ID_CSF_DEFAULT]&  (1<<  8);
>>> +}
>>
>> Can you please make this return bool?  Otherwise,
> 
> And if you're highly motivated, a separate patch to update
> include/linux/ata.h to return bool for obvious ata_id_has_xxx functions
> would be nice too.
> 
> But yes, including WWN here is just fine.
> 
> 
Like this?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Markus Rex, HRB 16746 (AG Nürnberg)

--------------000501030705060704020301
Content-Type: text/x-patch;
 name="libata-Use-bool-return-value-for-ata_id_XXX.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libata-Use-bool-return-value-for-ata_id_XXX.patch"

>From 195fc330d401d426c316dccd77b22de097048b89 Mon Sep 17 00:00:00 2001
From: Hannes Reinecke <hare@suse.de>
Date: Mon, 7 Mar 2011 08:43:37 +0100
Subject: [PATCH] libata: Use 'bool' return value for ata_id_XXX

Most ata_id_XXX inlines are simple tests, so we should set
the return value to 'bool' here.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/ata.h |   60 +++++++++++++++++++++++++-------------------------
 1 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 198e1ea..7055d4c 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -600,21 +600,21 @@ static inline bool ata_id_has_dipm(const u16 *id)
 }
 
 
-static inline int ata_id_has_fua(const u16 *id)
+static inline bool ata_id_has_fua(const u16 *id)
 {
 	if ((id[ATA_ID_CFSSE] & 0xC000) != 0x4000)
 		return 0;
 	return id[ATA_ID_CFSSE] & (1 << 6);
 }
 
-static inline int ata_id_has_flush(const u16 *id)
+static inline bool ata_id_has_flush(const u16 *id)
 {
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
 		return 0;
 	return id[ATA_ID_COMMAND_SET_2] & (1 << 12);
 }
 
-static inline int ata_id_flush_enabled(const u16 *id)
+static inline bool ata_id_flush_enabled(const u16 *id)
 {
 	if (ata_id_has_flush(id) == 0)
 		return 0;
@@ -623,14 +623,14 @@ static inline int ata_id_flush_enabled(const u16 *id)
 	return id[ATA_ID_CFS_ENABLE_2] & (1 << 12);
 }
 
-static inline int ata_id_has_flush_ext(const u16 *id)
+static inline bool ata_id_has_flush_ext(const u16 *id)
 {
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
 		return 0;
 	return id[ATA_ID_COMMAND_SET_2] & (1 << 13);
 }
 
-static inline int ata_id_flush_ext_enabled(const u16 *id)
+static inline bool ata_id_flush_ext_enabled(const u16 *id)
 {
 	if (ata_id_has_flush_ext(id) == 0)
 		return 0;
@@ -688,7 +688,7 @@ static inline u16 ata_id_logical_sector_offset(const u16 *id,
 	return 0;
 }
 
-static inline int ata_id_has_lba48(const u16 *id)
+static inline bool ata_id_has_lba48(const u16 *id)
 {
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
 		return 0;
@@ -697,7 +697,7 @@ static inline int ata_id_has_lba48(const u16 *id)
 	return id[ATA_ID_COMMAND_SET_2] & (1 << 10);
 }
 
-static inline int ata_id_lba48_enabled(const u16 *id)
+static inline bool ata_id_lba48_enabled(const u16 *id)
 {
 	if (ata_id_has_lba48(id) == 0)
 		return 0;
@@ -706,7 +706,7 @@ static inline int ata_id_lba48_enabled(const u16 *id)
 	return id[ATA_ID_CFS_ENABLE_2] & (1 << 10);
 }
 
-static inline int ata_id_hpa_enabled(const u16 *id)
+static inline bool ata_id_hpa_enabled(const u16 *id)
 {
 	/* Yes children, word 83 valid bits cover word 82 data */
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
@@ -720,7 +720,7 @@ static inline int ata_id_hpa_enabled(const u16 *id)
 	return id[ATA_ID_COMMAND_SET_1] & (1 << 10);
 }
 
-static inline int ata_id_has_wcache(const u16 *id)
+static inline bool ata_id_has_wcache(const u16 *id)
 {
 	/* Yes children, word 83 valid bits cover word 82 data */
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
@@ -728,21 +728,21 @@ static inline int ata_id_has_wcache(const u16 *id)
 	return id[ATA_ID_COMMAND_SET_1] & (1 << 5);
 }
 
-static inline int ata_id_has_pm(const u16 *id)
+static inline bool ata_id_has_pm(const u16 *id)
 {
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
 		return 0;
 	return id[ATA_ID_COMMAND_SET_1] & (1 << 3);
 }
 
-static inline int ata_id_rahead_enabled(const u16 *id)
+static inline bool ata_id_rahead_enabled(const u16 *id)
 {
 	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
 		return 0;
 	return id[ATA_ID_CFS_ENABLE_1] & (1 << 6);
 }
 
-static inline int ata_id_wcache_enabled(const u16 *id)
+static inline bool ata_id_wcache_enabled(const u16 *id)
 {
 	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
 		return 0;
@@ -775,7 +775,7 @@ static inline unsigned int ata_id_major_version(const u16 *id)
 	return mver;
 }
 
-static inline int ata_id_is_sata(const u16 *id)
+static inline bool ata_id_is_sata(const u16 *id)
 {
 	/*
 	 * See if word 93 is 0 AND drive is at least ATA-5 compatible
@@ -788,7 +788,7 @@ static inline int ata_id_is_sata(const u16 *id)
 	return 0;
 }
 
-static inline int ata_id_has_tpm(const u16 *id)
+static inline bool ata_id_has_tpm(const u16 *id)
 {
 	/* The TPM bits are only valid on ATA8 */
 	if (ata_id_major_version(id) < 8)
@@ -798,7 +798,7 @@ static inline int ata_id_has_tpm(const u16 *id)
 	return id[48] & (1 << 0);
 }
 
-static inline int ata_id_has_dword_io(const u16 *id)
+static inline bool ata_id_has_dword_io(const u16 *id)
 {
 	/* ATA 8 reuses this flag for "trusted" computing */
 	if (ata_id_major_version(id) > 7)
@@ -808,7 +808,7 @@ static inline int ata_id_has_dword_io(const u16 *id)
 	return 0;
 }
 
-static inline int ata_id_has_unload(const u16 *id)
+static inline bool ata_id_has_unload(const u16 *id)
 {
 	if (ata_id_major_version(id) >= 7 &&
 	    (id[ATA_ID_CFSSE] & 0xC000) == 0x4000 &&
@@ -850,7 +850,7 @@ static inline int ata_id_rotation_rate(const u16 *id)
 	return val;
 }
 
-static inline int ata_id_has_trim(const u16 *id)
+static inline bool ata_id_has_trim(const u16 *id)
 {
 	if (ata_id_major_version(id) >= 7 &&
 	    (id[ATA_ID_DATA_SET_MGMT] & 1))
@@ -858,7 +858,7 @@ static inline int ata_id_has_trim(const u16 *id)
 	return 0;
 }
 
-static inline int ata_id_has_zero_after_trim(const u16 *id)
+static inline bool ata_id_has_zero_after_trim(const u16 *id)
 {
 	/* DSM supported, deterministic read, and read zero after trim set */
 	if (ata_id_has_trim(id) &&
@@ -868,7 +868,7 @@ static inline int ata_id_has_zero_after_trim(const u16 *id)
 	return 0;
 }
 
-static inline int ata_id_current_chs_valid(const u16 *id)
+static inline bool ata_id_current_chs_valid(const u16 *id)
 {
 	/* For ATA-1 devices, if the INITIALIZE DEVICE PARAMETERS command
 	   has not been issued to the device then the values of
@@ -880,7 +880,7 @@ static inline int ata_id_current_chs_valid(const u16 *id)
 		id[ATA_ID_CUR_SECTORS];    /* sectors in current translation */
 }
 
-static inline int ata_id_is_cfa(const u16 *id)
+static inline bool ata_id_is_cfa(const u16 *id)
 {
 	if ((id[ATA_ID_CONFIG] == 0x848A) ||	/* Traditional CF */
 	    (id[ATA_ID_CONFIG] == 0x844A))	/* Delkin Devices CF */
@@ -898,12 +898,12 @@ static inline int ata_id_is_cfa(const u16 *id)
 	return 0;
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
@@ -917,7 +917,7 @@ static inline int ata_id_pio_need_iordy(const u16 *id, const u8 pio)
 	return 0;
 }
 
-static inline int ata_drive_40wire(const u16 *dev_id)
+static inline bool ata_drive_40wire(const u16 *dev_id)
 {
 	if (ata_id_is_sata(dev_id))
 		return 0;	/* SATA */
@@ -926,7 +926,7 @@ static inline int ata_drive_40wire(const u16 *dev_id)
 	return 1;
 }
 
-static inline int ata_drive_40wire_relaxed(const u16 *dev_id)
+static inline bool ata_drive_40wire_relaxed(const u16 *dev_id)
 {
 	if ((dev_id[ATA_ID_HW_CONFIG] & 0x2000) == 0x2000)
 		return 0;	/* 80 wire */
@@ -943,12 +943,12 @@ static inline int atapi_cdb_len(const u16 *dev_id)
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
@@ -961,7 +961,7 @@ static inline int atapi_id_dmadir(const u16 *dev_id)
  *
  * It is called only once for each device.
  */
-static inline int ata_id_is_lba_capacity_ok(u16 *id)
+static inline bool ata_id_is_lba_capacity_ok(u16 *id)
 {
 	unsigned long lba_sects, chs_sects, head, tail;
 
@@ -1058,19 +1058,19 @@ static inline int is_multi_taskfile(struct ata_taskfile *tf)
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
-- 
1.6.0.2


--------------000501030705060704020301--
