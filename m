From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH #upstream] libata: enhance command parsing
Date: Fri, 21 Aug 2009 23:57:06 -0600
Message-ID: <4A8F88B2.6050900@gmail.com>
References: <4A72105F.40704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:62901 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932867AbZHVF5J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Aug 2009 01:57:09 -0400
Received: by yxe5 with SMTP id 5so673674yxe.33
        for <linux-ide@vger.kernel.org>; Fri, 21 Aug 2009 22:57:10 -0700 (PDT)
In-Reply-To: <4A72105F.40704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>

On 07/30/2009 03:27 PM, Robert Hancock wrote:
> This patch enhances libata's command name output (used for error
> handling and
> ACPI command execution status) to include more commands from the latest
> ACS-2 spec draft, and to support parsing sub-commands based on the feature
> and nsect registers instead of just the command code. To support this, the
> ata_get_cmd_descript function now takes the entire taskfile as input.
> The function has been changed to use a switch statement instead of a data
> array for more efficiency and compile-time checking for duplicate entries.
>
> Also, the ATA_CMD_PMP_READ and ATA_CMD_PMP_WRITE constants have been
> renamed
> to ATA_CMD_READ_BUFFER and ATA_CMD_WRITE_BUFFER to reflect the actual
> name of
> the corresponding ATA command.
>
> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

Any comment on this one, guys?

>
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index 01964b6..dd89f0b 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -737,7 +737,7 @@ static int ata_acpi_run_tf(struct ata_device *dev,
> snprintf(msg, sizeof(msg), "filtered out");
> rc = 0;
> }
> - descr = ata_get_cmd_descript(tf.command);
> + descr = ata_get_cmd_descript(&tf);
>
> ata_dev_printk(dev, level,
> "ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x (%s) %s\n",
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index a04488f..06c62f1 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2114,109 +2114,200 @@ void ata_eh_autopsy(struct ata_port *ap)
>
> /**
> * ata_get_cmd_descript - get description for ATA command
> - * @command: ATA command code to get description for
> + * @tf: ATA taskfile to get description for
> *
> - * Return a textual description of the given command, or NULL if the
> + * Return a textual description of the given taskfile, or NULL if the
> * command is not known.
> *
> * LOCKING:
> * None
> */
> -const char *ata_get_cmd_descript(u8 command)
> +const char *ata_get_cmd_descript(const struct ata_taskfile* tf)
> {
> #ifdef CONFIG_ATA_VERBOSE_ERROR
> - static const struct
> - {
> - u8 command;
> - const char *text;
> - } cmd_descr[] = {
> - { ATA_CMD_DEV_RESET, "DEVICE RESET" },
> - { ATA_CMD_CHK_POWER, "CHECK POWER MODE" },
> - { ATA_CMD_STANDBY, "STANDBY" },
> - { ATA_CMD_IDLE, "IDLE" },
> - { ATA_CMD_EDD, "EXECUTE DEVICE DIAGNOSTIC" },
> - { ATA_CMD_DOWNLOAD_MICRO, "DOWNLOAD MICROCODE" },
> - { ATA_CMD_NOP, "NOP" },
> - { ATA_CMD_FLUSH, "FLUSH CACHE" },
> - { ATA_CMD_FLUSH_EXT, "FLUSH CACHE EXT" },
> - { ATA_CMD_ID_ATA, "IDENTIFY DEVICE" },
> - { ATA_CMD_ID_ATAPI, "IDENTIFY PACKET DEVICE" },
> - { ATA_CMD_SERVICE, "SERVICE" },
> - { ATA_CMD_READ, "READ DMA" },
> - { ATA_CMD_READ_EXT, "READ DMA EXT" },
> - { ATA_CMD_READ_QUEUED, "READ DMA QUEUED" },
> - { ATA_CMD_READ_STREAM_EXT, "READ STREAM EXT" },
> - { ATA_CMD_READ_STREAM_DMA_EXT, "READ STREAM DMA EXT" },
> - { ATA_CMD_WRITE, "WRITE DMA" },
> - { ATA_CMD_WRITE_EXT, "WRITE DMA EXT" },
> - { ATA_CMD_WRITE_QUEUED, "WRITE DMA QUEUED EXT" },
> - { ATA_CMD_WRITE_STREAM_EXT, "WRITE STREAM EXT" },
> - { ATA_CMD_WRITE_STREAM_DMA_EXT, "WRITE STREAM DMA EXT" },
> - { ATA_CMD_WRITE_FUA_EXT, "WRITE DMA FUA EXT" },
> - { ATA_CMD_WRITE_QUEUED_FUA_EXT, "WRITE DMA QUEUED FUA EXT" },
> - { ATA_CMD_FPDMA_READ, "READ FPDMA QUEUED" },
> - { ATA_CMD_FPDMA_WRITE, "WRITE FPDMA QUEUED" },
> - { ATA_CMD_PIO_READ, "READ SECTOR(S)" },
> - { ATA_CMD_PIO_READ_EXT, "READ SECTOR(S) EXT" },
> - { ATA_CMD_PIO_WRITE, "WRITE SECTOR(S)" },
> - { ATA_CMD_PIO_WRITE_EXT, "WRITE SECTOR(S) EXT" },
> - { ATA_CMD_READ_MULTI, "READ MULTIPLE" },
> - { ATA_CMD_READ_MULTI_EXT, "READ MULTIPLE EXT" },
> - { ATA_CMD_WRITE_MULTI, "WRITE MULTIPLE" },
> - { ATA_CMD_WRITE_MULTI_EXT, "WRITE MULTIPLE EXT" },
> - { ATA_CMD_WRITE_MULTI_FUA_EXT, "WRITE MULTIPLE FUA EXT" },
> - { ATA_CMD_SET_FEATURES, "SET FEATURES" },
> - { ATA_CMD_SET_MULTI, "SET MULTIPLE MODE" },
> - { ATA_CMD_VERIFY, "READ VERIFY SECTOR(S)" },
> - { ATA_CMD_VERIFY_EXT, "READ VERIFY SECTOR(S) EXT" },
> - { ATA_CMD_WRITE_UNCORR_EXT, "WRITE UNCORRECTABLE EXT" },
> - { ATA_CMD_STANDBYNOW1, "STANDBY IMMEDIATE" },
> - { ATA_CMD_IDLEIMMEDIATE, "IDLE IMMEDIATE" },
> - { ATA_CMD_SLEEP, "SLEEP" },
> - { ATA_CMD_INIT_DEV_PARAMS, "INITIALIZE DEVICE PARAMETERS" },
> - { ATA_CMD_READ_NATIVE_MAX, "READ NATIVE MAX ADDRESS" },
> - { ATA_CMD_READ_NATIVE_MAX_EXT, "READ NATIVE MAX ADDRESS EXT" },
> - { ATA_CMD_SET_MAX, "SET MAX ADDRESS" },
> - { ATA_CMD_SET_MAX_EXT, "SET MAX ADDRESS EXT" },
> - { ATA_CMD_READ_LOG_EXT, "READ LOG EXT" },
> - { ATA_CMD_WRITE_LOG_EXT, "WRITE LOG EXT" },
> - { ATA_CMD_READ_LOG_DMA_EXT, "READ LOG DMA EXT" },
> - { ATA_CMD_WRITE_LOG_DMA_EXT, "WRITE LOG DMA EXT" },
> - { ATA_CMD_TRUSTED_RCV, "TRUSTED RECEIVE" },
> - { ATA_CMD_TRUSTED_RCV_DMA, "TRUSTED RECEIVE DMA" },
> - { ATA_CMD_TRUSTED_SND, "TRUSTED SEND" },
> - { ATA_CMD_TRUSTED_SND_DMA, "TRUSTED SEND DMA" },
> - { ATA_CMD_PMP_READ, "READ BUFFER" },
> - { ATA_CMD_PMP_WRITE, "WRITE BUFFER" },
> - { ATA_CMD_CONF_OVERLAY, "DEVICE CONFIGURATION OVERLAY" },
> - { ATA_CMD_SEC_SET_PASS, "SECURITY SET PASSWORD" },
> - { ATA_CMD_SEC_UNLOCK, "SECURITY UNLOCK" },
> - { ATA_CMD_SEC_ERASE_PREP, "SECURITY ERASE PREPARE" },
> - { ATA_CMD_SEC_ERASE_UNIT, "SECURITY ERASE UNIT" },
> - { ATA_CMD_SEC_FREEZE_LOCK, "SECURITY FREEZE LOCK" },
> - { ATA_CMD_SEC_DISABLE_PASS, "SECURITY DISABLE PASSWORD" },
> - { ATA_CMD_CONFIG_STREAM, "CONFIGURE STREAM" },
> - { ATA_CMD_SMART, "SMART" },
> - { ATA_CMD_MEDIA_LOCK, "DOOR LOCK" },
> - { ATA_CMD_MEDIA_UNLOCK, "DOOR UNLOCK" },
> - { ATA_CMD_CHK_MED_CRD_TYP, "CHECK MEDIA CARD TYPE" },
> - { ATA_CMD_CFA_REQ_EXT_ERR, "CFA REQUEST EXTENDED ERROR" },
> - { ATA_CMD_CFA_WRITE_NE, "CFA WRITE SECTORS WITHOUT ERASE" },
> - { ATA_CMD_CFA_TRANS_SECT, "CFA TRANSLATE SECTOR" },
> - { ATA_CMD_CFA_ERASE, "CFA ERASE SECTORS" },
> - { ATA_CMD_CFA_WRITE_MULT_NE, "CFA WRITE MULTIPLE WITHOUT ERASE" },
> - { ATA_CMD_READ_LONG, "READ LONG (with retries)" },
> - { ATA_CMD_READ_LONG_ONCE, "READ LONG (without retries)" },
> - { ATA_CMD_WRITE_LONG, "WRITE LONG (with retries)" },
> - { ATA_CMD_WRITE_LONG_ONCE, "WRITE LONG (without retries)" },
> - { ATA_CMD_RESTORE, "RECALIBRATE" },
> - { 0, NULL } /* terminate list */
> - };
> -
> - unsigned int i;
> - for (i = 0; cmd_descr[i].text; i++)
> - if (cmd_descr[i].command == command)
> - return cmd_descr[i].text;
> + switch (tf->command) {
> + case ATA_CMD_CONF_OVERLAY:
> + switch (tf->feature) {
> + case ATA_DCO_RESTORE:
> + return "DEVICE CONFIGURATION RESTORE";
> + case ATA_DCO_FREEZE_LOCK:
> + return "DEVICE CONFIGURATION FREEZE LOCK";
> + case ATA_DCO_IDENTIFY:
> + return "DEVICE CONFIGURATION IDENTIFY";
> + case ATA_DCO_SET:
> + return "DEVICE CONFIGURATION SET";
> + case ATA_DCO_IDENTIFY_DMA:
> + return "DEVICE CONFIGURATION IDENTIFY DMA";
> + case ATA_DCO_SET_DMA:
> + return "DEVICE CONFIGURATION SET DMA";
> + default:
> + return "DEVICE CONFIGURATION OVERLAY (unknown feature)";
> + }
> + case ATA_CMD_SET_FEATURES:
> + switch (tf->feature) {
> + case SETFEATURES_XFER:
> + return "SET FEATURES - Set transfer mode";
> + case SETFEATURES_WC_ON:
> + return "SET FEATURES - Enable write cache";
> + case SETFEATURES_WC_OFF:
> + return "SET FEATURES - Disable write cache";
> + case SETFEATURES_AAM_ON:
> + return "SET FEATURES - Enable Automatic Acoustic Management";
> + case SETFEATURES_AAM_OFF:
> + return "SET FEATURES - Disable Automatic Acoustic Management";
> + case SETFEATURES_SPINUP:
> + return "SET FEATURES - Spinup";
> + case SETFEATURES_SATA_ENABLE:
> + switch (tf->nsect) {
> + case SATA_AN:
> + return "SET FEATURES - Enable SATA Asynchronous Notification";
> + case SATA_DIPM:
> + return "SET FEATURES - Enable Device-Initiated Power Management";
> + case SATA_FPDMA_AA:
> + return "SET FEATURES - Enable DMA Setup Auto-Activate";
> + default:
> + return "SET FEATURES - Enable SATA feature (unknown)";
> + }
> + case SETFEATURES_SATA_DISABLE:
> + switch (tf->nsect) {
> + case SATA_AN:
> + return "SET FEATURES - Disable SATA Asynchronous Notification";
> + case SATA_DIPM:
> + return "SET FEATURES - Disable Device-Initiated Power Management";
> + case SATA_FPDMA_AA:
> + return "SET FEATURES - Disable DMA Setup Auto-Activate";
> + default:
> + return "SET FEATURES - Disable SATA feature (unknown)";
> + }
> + default:
> + return "SET FEATURES (unknown feature)";
> + }
> + case ATA_CMD_SET_MAX:
> + switch (tf->feature) {
> + case ATA_SET_MAX_ADDR:
> + return "SET MAX ADDRESS";
> + case ATA_SET_MAX_PASSWD:
> + return "SET MAX SET PASSWORD";
> + case ATA_SET_MAX_LOCK:
> + return "SET MAX LOCK";
> + case ATA_SET_MAX_UNLOCK:
> + return "SET MAX UNLOCK";
> + case ATA_SET_MAX_FREEZE_LOCK:
> + return "SET MAX FREEZE LOCK";
> + case ATA_SET_MAX_PASSWD_DMA:
> + return "SET MAX SET PASSWORD DMA";
> + case ATA_SET_MAX_UNLOCK_DMA:
> + return "SET MAX UNLOCK DMA";
> + default:
> + return "SET MAX (unknown feature)";
> + }
> + case ATA_CMD_SMART:
> + switch (tf->feature) {
> + case ATA_SMART_ENABLE:
> + return "SMART ENABLE OPERATIONS";
> + case ATA_SMART_DISABLE:
> + return "SMART DISABLE OPERATIONS";
> + case ATA_SMART_READ_VALUES:
> + return "SMART READ VALUES";
> + case ATA_SMART_READ_THRESHOLDS:
> + return "SMART READ THRESHOLDS";
> + case ATA_SMART_AUTOSAVE:
> + return "SMART ENABLE/DISABLE ATTRIBUTE AUTOSAVE";
> + case ATA_SMART_OFFLINE_IMMED:
> + return "SMART EXECUTE OFF-LINE IMMEDIATE";
> + case ATA_SMART_READ_LOG:
> + return "SMART READ LOG";
> + case ATA_SMART_WRITE_LOG:
> + return "SMART WRITE LOG";
> + case ATA_SMART_RETURN_STATUS:
> + return "SMART RETURN STATUS";
> + default:
> + return "SMART (unknown feature)";
> + }
> + case ATA_CMD_DEV_RESET: return "DEVICE RESET";
> + case ATA_CMD_CHK_POWER: return "CHECK POWER MODE";
> + case ATA_CMD_STANDBY: return "STANDBY";
> + case ATA_CMD_IDLE: return "IDLE";
> + case ATA_CMD_EDD: return "EXECUTE DEVICE DIAGNOSTIC";
> + case ATA_CMD_DOWNLOAD_MICRO: return "DOWNLOAD MICROCODE";
> + case ATA_CMD_DOWNLOAD_MICRO_DMA:return "DOWNLOAD MICROCODE DMA";
> + case ATA_CMD_NOP: return "NOP";
> + case ATA_CMD_FLUSH: return "FLUSH CACHE";
> + case ATA_CMD_FLUSH_EXT: return "FLUSH CACHE EXT";
> + case ATA_CMD_ID_ATA: return "IDENTIFY DEVICE";
> + case ATA_CMD_ID_ATAPI: return "IDENTIFY PACKET DEVICE";
> + case ATA_CMD_SERVICE: return "SERVICE";
> + case ATA_CMD_READ: return "READ DMA";
> + case ATA_CMD_READ_EXT: return "READ DMA EXT";
> + case ATA_CMD_READ_QUEUED: return "READ DMA QUEUED";
> + case ATA_CMD_READ_STREAM_EXT: return "READ STREAM EXT";
> + case ATA_CMD_READ_STREAM_DMA_EXT: return "READ STREAM DMA EXT";
> + case ATA_CMD_WRITE: return "WRITE DMA";
> + case ATA_CMD_WRITE_EXT: return "WRITE DMA EXT";
> + case ATA_CMD_WRITE_QUEUED: return "WRITE DMA QUEUED EXT";
> + case ATA_CMD_WRITE_STREAM_EXT: return "WRITE STREAM EXT";
> + case ATA_CMD_WRITE_STREAM_DMA_EXT: return "WRITE STREAM DMA EXT";
> + case ATA_CMD_WRITE_FUA_EXT: return "WRITE DMA FUA EXT";
> + case ATA_CMD_WRITE_QUEUED_FUA_EXT: return "WRITE DMA QUEUED FUA EXT";
> + case ATA_CMD_FPDMA_READ: return "READ FPDMA QUEUED";
> + case ATA_CMD_FPDMA_WRITE: return "WRITE FPDMA QUEUED";
> + case ATA_CMD_PIO_READ: return "READ SECTOR(S)";
> + case ATA_CMD_PIO_READ_EXT: return "READ SECTOR(S) EXT";
> + case ATA_CMD_PIO_WRITE: return "WRITE SECTOR(S)";
> + case ATA_CMD_PIO_WRITE_EXT: return "WRITE SECTOR(S) EXT";
> + case ATA_CMD_READ_MULTI: return "READ MULTIPLE";
> + case ATA_CMD_READ_MULTI_EXT: return "READ MULTIPLE EXT";
> + case ATA_CMD_WRITE_MULTI: return "WRITE MULTIPLE";
> + case ATA_CMD_WRITE_MULTI_EXT: return "WRITE MULTIPLE EXT";
> + case ATA_CMD_WRITE_MULTI_FUA_EXT: return "WRITE MULTIPLE FUA EXT";
> + case ATA_CMD_SET_MULTI: return "SET MULTIPLE MODE";
> + case ATA_CMD_VERIFY: return "READ VERIFY SECTOR(S)";
> + case ATA_CMD_VERIFY_EXT: return "READ VERIFY SECTOR(S) EXT";
> + case ATA_CMD_WRITE_UNCORR_EXT: return "WRITE UNCORRECTABLE EXT";
> + case ATA_CMD_STANDBYNOW1: return "STANDBY IMMEDIATE";
> + case ATA_CMD_IDLEIMMEDIATE: return "IDLE IMMEDIATE";
> + case ATA_CMD_SLEEP: return "SLEEP";
> + case ATA_CMD_INIT_DEV_PARAMS: return "INITIALIZE DEVICE PARAMETERS";
> + case ATA_CMD_READ_NATIVE_MAX: return "READ NATIVE MAX ADDRESS";
> + case ATA_CMD_READ_NATIVE_MAX_EXT: return "READ NATIVE MAX ADDRESS EXT";
> + case ATA_CMD_SET_MAX_EXT: return "SET MAX ADDRESS EXT";
> + case ATA_CMD_READ_LOG_EXT: return "READ LOG EXT";
> + case ATA_CMD_WRITE_LOG_EXT: return "WRITE LOG EXT";
> + case ATA_CMD_READ_LOG_DMA_EXT: return "READ LOG DMA EXT";
> + case ATA_CMD_WRITE_LOG_DMA_EXT: return "WRITE LOG DMA EXT";
> + case ATA_CMD_TRUSTED_NONDATA: return "TRUSTED NON-DATA";
> + case ATA_CMD_TRUSTED_RCV: return "TRUSTED RECEIVE";
> + case ATA_CMD_TRUSTED_RCV_DMA: return "TRUSTED RECEIVE DMA";
> + case ATA_CMD_TRUSTED_SND: return "TRUSTED SEND";
> + case ATA_CMD_TRUSTED_SND_DMA: return "TRUSTED SEND DMA";
> + case ATA_CMD_READ_BUFFER: return "READ BUFFER";
> + case ATA_CMD_READ_BUFFER_DMA: return "READ BUFFER DMA";
> + case ATA_CMD_WRITE_BUFFER: return "WRITE BUFFER";
> + case ATA_CMD_WRITE_BUFFER_DMA: return "WRITE BUFFER DMA";
> + case ATA_CMD_SEC_SET_PASS: return "SECURITY SET PASSWORD";
> + case ATA_CMD_SEC_UNLOCK: return "SECURITY UNLOCK";
> + case ATA_CMD_SEC_ERASE_PREP: return "SECURITY ERASE PREPARE";
> + case ATA_CMD_SEC_ERASE_UNIT: return "SECURITY ERASE UNIT";
> + case ATA_CMD_SEC_FREEZE_LOCK: return "SECURITY FREEZE LOCK";
> + case ATA_CMD_SEC_DISABLE_PASS: return "SECURITY DISABLE PASSWORD";
> + case ATA_CMD_CONFIG_STREAM: return "CONFIGURE STREAM";
> + case ATA_CMD_MEDIA_LOCK: return "DOOR LOCK";
> + case ATA_CMD_MEDIA_UNLOCK: return "DOOR UNLOCK";
> + case ATA_CMD_CHK_MED_CRD_TYP: return "CHECK MEDIA CARD TYPE";
> + case ATA_CMD_CFA_REQ_EXT_ERR: return "CFA REQUEST EXTENDED ERROR";
> + case ATA_CMD_CFA_WRITE_NE: return "CFA WRITE SECTORS WITHOUT ERASE";
> + case ATA_CMD_CFA_TRANS_SECT: return "CFA TRANSLATE SECTOR";
> + case ATA_CMD_CFA_ERASE: return "CFA ERASE SECTORS";
> + case ATA_CMD_CFA_WRITE_MULT_NE: return "CFA WRITE MULTIPLE WITHOUT
> ERASE";
> + case ATA_CMD_READ_LONG: return "READ LONG (with retries)";
> + case ATA_CMD_READ_LONG_ONCE: return "READ LONG (without retries)";
> + case ATA_CMD_WRITE_LONG: return "WRITE LONG (with retries)";
> + case ATA_CMD_WRITE_LONG_ONCE: return "WRITE LONG (without retries)";
> + case ATA_CMD_RESTORE ... 0x1F: return "RECALIBRATE";
> + case ATA_CMD_DSM: return "DATA SET MANAGEMENT";
> + case ATA_CMD_REQ_SENSE_EXT: return "REQUEST SENSE DATA EXT";
> + case ATA_CMD_NV_CACHE: return "NV CACHE";
> + }
> #endif
>
> return NULL;
> @@ -2353,7 +2444,7 @@ static void ata_eh_link_report(struct ata_link *link)
> cdb[8], cdb[9], cdb[10], cdb[11],
> cdb[12], cdb[13], cdb[14], cdb[15]);
> } else {
> - const char *descr = ata_get_cmd_descript(cmd->command);
> + const char *descr = ata_get_cmd_descript(cmd);
> if (descr)
> ata_dev_printk(qc->dev, KERN_ERR,
> "failed command: %s\n", descr);
> diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index 619f2c3..2f987d6 100644
> --- a/drivers/ata/libata-pmp.c
> +++ b/drivers/ata/libata-pmp.c
> @@ -41,7 +41,7 @@ static unsigned int sata_pmp_read(struct ata_link
> *link, int reg, u32 *r_val)
> unsigned int err_mask;
>
> ata_tf_init(pmp_dev, &tf);
> - tf.command = ATA_CMD_PMP_READ;
> + tf.command = ATA_CMD_READ_BUFFER;
> tf.protocol = ATA_PROT_NODATA;
> tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48;
> tf.feature = reg;
> @@ -77,7 +77,7 @@ static unsigned int sata_pmp_write(struct ata_link
> *link, int reg, u32 val)
> struct ata_taskfile tf;
>
> ata_tf_init(pmp_dev, &tf);
> - tf.command = ATA_CMD_PMP_WRITE;
> + tf.command = ATA_CMD_WRITE_BUFFER;
> tf.protocol = ATA_PROT_NODATA;
> tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48;
> tf.feature = reg;
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index be8e262..2c19673 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -164,7 +164,7 @@ extern void ata_eh_about_to_do(struct ata_link
> *link, struct ata_device *dev,
> extern void ata_eh_done(struct ata_link *link, struct ata_device *dev,
> unsigned int action);
> extern void ata_eh_autopsy(struct ata_port *ap);
> -const char *ata_get_cmd_descript(u8 command);
> +const char *ata_get_cmd_descript(const struct ata_taskfile* tf);
> extern void ata_eh_report(struct ata_port *ap);
> extern int ata_eh_reset(struct ata_link *link, int classify,
> ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index 6299a25..8d5a9cc 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -211,6 +211,7 @@ enum {
> ATA_CMD_IDLE = 0xE3, /* place in idle power mode */
> ATA_CMD_EDD = 0x90, /* execute device diagnostic */
> ATA_CMD_DOWNLOAD_MICRO = 0x92,
> + ATA_CMD_DOWNLOAD_MICRO_DMA = 0x93,
> ATA_CMD_NOP = 0x00,
> ATA_CMD_FLUSH = 0xE7,
> ATA_CMD_FLUSH_EXT = 0xEA,
> @@ -258,12 +259,15 @@ enum {
> ATA_CMD_WRITE_LOG_EXT = 0x3F,
> ATA_CMD_READ_LOG_DMA_EXT = 0x47,
> ATA_CMD_WRITE_LOG_DMA_EXT = 0x57,
> + ATA_CMD_TRUSTED_NONDATA = 0x5B,
> ATA_CMD_TRUSTED_RCV = 0x5C,
> ATA_CMD_TRUSTED_RCV_DMA = 0x5D,
> ATA_CMD_TRUSTED_SND = 0x5E,
> ATA_CMD_TRUSTED_SND_DMA = 0x5F,
> - ATA_CMD_PMP_READ = 0xE4,
> - ATA_CMD_PMP_WRITE = 0xE8,
> + ATA_CMD_READ_BUFFER = 0xE4,
> + ATA_CMD_READ_BUFFER_DMA = 0xE9,
> + ATA_CMD_WRITE_BUFFER = 0xE8,
> + ATA_CMD_WRITE_BUFFER_DMA = 0xEB,
> ATA_CMD_CONF_OVERLAY = 0xB1,
> ATA_CMD_SEC_SET_PASS = 0xF1,
> ATA_CMD_SEC_UNLOCK = 0xF2,
> @@ -276,12 +280,14 @@ enum {
> ATA_CMD_MEDIA_LOCK = 0xDE,
> ATA_CMD_MEDIA_UNLOCK = 0xDF,
> ATA_CMD_DSM = 0x06,
> + ATA_CMD_REQ_SENSE_EXT = 0x0B,
> ATA_CMD_CHK_MED_CRD_TYP = 0xD1,
> ATA_CMD_CFA_REQ_EXT_ERR = 0x03,
> ATA_CMD_CFA_WRITE_NE = 0x38,
> ATA_CMD_CFA_TRANS_SECT = 0x87,
> ATA_CMD_CFA_ERASE = 0xC0,
> ATA_CMD_CFA_WRITE_MULT_NE = 0xCD,
> + ATA_CMD_NV_CACHE = 0xB6,
> /* marked obsolete in the ATA/ATAPI-7 spec */
> ATA_CMD_RESTORE = 0x10,
>
> @@ -344,17 +350,27 @@ enum {
> ATA_SET_MAX_LOCK = 0x02,
> ATA_SET_MAX_UNLOCK = 0x03,
> ATA_SET_MAX_FREEZE_LOCK = 0x04,
> + ATA_SET_MAX_PASSWD_DMA = 0x05,
> + ATA_SET_MAX_UNLOCK_DMA = 0x06,
>
> /* feature values for DEVICE CONFIGURATION OVERLAY */
> ATA_DCO_RESTORE = 0xC0,
> ATA_DCO_FREEZE_LOCK = 0xC1,
> ATA_DCO_IDENTIFY = 0xC2,
> ATA_DCO_SET = 0xC3,
> + ATA_DCO_IDENTIFY_DMA = 0xC4,
> + ATA_DCO_SET_DMA = 0xC5,
>
> /* feature values for SMART */
> ATA_SMART_ENABLE = 0xD8,
> + ATA_SMART_DISABLE = 0xD9,
> ATA_SMART_READ_VALUES = 0xD0,
> ATA_SMART_READ_THRESHOLDS = 0xD1,
> + ATA_SMART_AUTOSAVE = 0xD2,
> + ATA_SMART_OFFLINE_IMMED = 0xD4,
> + ATA_SMART_READ_LOG = 0xD5,
> + ATA_SMART_WRITE_LOG = 0xD6,
> + ATA_SMART_RETURN_STATUS = 0xDA,
>
> /* feature values for Data Set Management */
> ATA_DSM_TRIM = 0x01,

