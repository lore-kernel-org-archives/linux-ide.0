From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream] libata: enhance command parsing
Date: Sat, 22 Aug 2009 10:02:03 -0400
Message-ID: <4A8FFA5B.30209@rtr.ca>
References: <4A72105F.40704@gmail.com> <4A8F88B2.6050900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:57811 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932104AbZHVOCA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Aug 2009 10:02:00 -0400
In-Reply-To: <4A8F88B2.6050900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>

Robert Hancock wrote:
> On 07/30/2009 03:27 PM, Robert Hancock wrote:
>> This patch enhances libata's command name output (used for error
>> handling and
>> ACPI command execution status) to include more commands from the latest
>> ACS-2 spec draft, and to support parsing sub-commands based on the feature
>> and nsect registers instead of just the command code. To support this, the
>> ata_get_cmd_descript function now takes the entire taskfile as input.
>> The function has been changed to use a switch statement instead of a data
>> array for more efficiency and compile-time checking for duplicate entries.
>>
>> Also, the ATA_CMD_PMP_READ and ATA_CMD_PMP_WRITE constants have been
>> renamed
>> to ATA_CMD_READ_BUFFER and ATA_CMD_WRITE_BUFFER to reflect the actual
>> name of
>> the corresponding ATA command.
>>
>> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>
>
> Any comment on this one, guys?
>
>>
>> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
>> index 01964b6..dd89f0b 100644
>> --- a/drivers/ata/libata-acpi.c
>> +++ b/drivers/ata/libata-acpi.c
>> @@ -737,7 +737,7 @@ static int ata_acpi_run_tf(struct ata_device *dev,
>> snprintf(msg, sizeof(msg), "filtered out");
>> rc = 0;
>> }
>> - descr = ata_get_cmd_descript(tf.command);
>> + descr = ata_get_cmd_descript(&tf);
>>
>> ata_dev_printk(dev, level,
>> "ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x (%s) %s\n",
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index a04488f..06c62f1 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -2114,109 +2114,200 @@ void ata_eh_autopsy(struct ata_port *ap)
>>
>> /**
>> * ata_get_cmd_descript - get description for ATA command
>> - * @command: ATA command code to get description for
>> + * @tf: ATA taskfile to get description for
>> *
>> - * Return a textual description of the given command, or NULL if the
>> + * Return a textual description of the given taskfile, or NULL if the
>> * command is not known.
>> *
>> * LOCKING:
>> * None
>> */
>> -const char *ata_get_cmd_descript(u8 command)
>> +const char *ata_get_cmd_descript(const struct ata_taskfile* tf)
>> {
>> #ifdef CONFIG_ATA_VERBOSE_ERROR
>> - static const struct
>> - {
>> - u8 command;
>> - const char *text;
>> - } cmd_descr[] = {
>> - { ATA_CMD_DEV_RESET, "DEVICE RESET" },
>> - { ATA_CMD_CHK_POWER, "CHECK POWER MODE" },
...
>> + switch (tf->command) {
>> + case ATA_CMD_CONF_OVERLAY:
>> + switch (tf->feature) {
>> + case ATA_DCO_RESTORE:
>> + return "DEVICE CONFIGURATION RESTORE";
>> + case ATA_DCO_FREEZE_LOCK:
...
>> + case ATA_SET_MAX_ADDR:
>> + return "SET MAX ADDRESS";

I really think that this is begging for a smarter
data structure, with a lot less code as a result.
One should be able to get the overall compiled
size of this down to about half of the current
implementation.


