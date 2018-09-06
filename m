From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
Date: Thu, 6 Sep 2018 14:54:43 +0200
Message-ID: <de4a935a-de63-fe81-ccbe-50edbd4ea098@redhat.com>
References: <1536208421-24867-1-git-send-email-stripathi@amperecomputing.com>
 <a1c6012f-3b50-0e5e-677c-41903b4ccf64@redhat.com>
 <MWHPR01MB233693C3A340055CC5CF3D40B3010@MWHPR01MB2336.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MWHPR01MB233693C3A340055CC5CF3D40B3010@MWHPR01MB2336.prod.exchangelabs.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Tripathi <stripathi@amperecomputing.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "tj@kernel.org" <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "joe@perches.com" <joe@perches.com>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Open Source Submission <patches@amperecomputing.com>, Rameshwar Sahu <Rameshwar.Sahu@amperecomputing.com>
List-Id: linux-ide@vger.kernel.org

Hi,

On 06-09-18 14:51, Suman Tripathi wrote:
> Hi Hans,
> 
> I ran checkpatch and see no error. I will check my git-send-email

Right, the problem is not with the patch, but with your email client
mangling the file.

git send-email will send the patch for you without damaging it.

Regards,

Hans



> 
> scripts/checkpatch.pl  0001-ata-Disable-AHCI-ALPM-feature-for-Ampere-Computing-e.patch total: 0 errors, 0 warnings, 39 lines checked
> 
> 0001-ata-Disable-AHCI-ALPM-feature-for-Ampere-Computing-e.patch has no obvious style problems and is ready for submission.
> 
> 
> With regards,
> Suman
> 
> 
> 
> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Thursday, September 6, 2018 12:32 AM
> To: Suman Tripathi <stripathi@amperecomputing.com>; axboe@kernel.dk; tj@kernel.org; linux-ide@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; joe@perches.com; arnd@arndb.de; gregkh@linuxfoundation.org
> Cc: Open Source Submission <patches@amperecomputing.com>; Rameshwar Sahu <Rameshwar.Sahu@amperecomputing.com>
> Subject: Re: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing eMAG SATA
> 
> [NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.] ________________________________________________________________________________________________________________________
> 
> Hi,
> 
> On 06-09-18 06:33, Suman Tripathi wrote:
>> Due to hardware errata, Ampere Computing eMAG SATA can't support AHCI
>> ALPM feature. This patch disables the AHCI ALPM feature for eMAG SATA.
>>
>> Changes for v2:
>>
>> * Introduce the new ata_port_info object which includes ATA_FLAG_NO_LPM.
>> * Include this object for eMAG SATA inside the acpi match table.
>> * Retrieve the ata_port_info from the acpi match table.
>>
>> Changes for v3:
>>
>> * Fix the indentation and whitespace warnings.
>>
>> Signed-off-by: Suman Trpathi <stripathi@amperecomputing.com>
>> Signed-off-by: Rameshwar Prasad Sahu
>> <rameshwar.sahu@amperecomputing.com>
> 
> Small remark, normally the changelog is put after the Signed-off-by messages like
> this:
> 
> """
> Signed-off-by: Suman Trpathi <stripathi@amperecomputing.com>
> Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
> ---
> Changes for v3:
> * Fix the indentation and whitespace warnings.
> 
> Changes for v2:
> 
> * Introduce the new ata_port_info object which includes ATA_FLAG_NO_LPM.
> * Include this object for eMAG SATA inside the acpi match table.
> * Retrieve the ata_port_info from the acpi match table.
> """
> 
> This will cause git am to remove it, so that the git history just has your original commit message.
> 
> By itself this would not be a reason to request a new version, but it seems you've copy and pasted the patch from "git format-patch" output into you mail client. I tried to run checkpatch myself to make sure you caught all whitespace issues and I got this:
> 
> [hans@shalem linux]$ scripts/checkpatch.pl ~/\[PATCH\ v3\]\ ata\:\ Disable\ AHCI\ ALPM\ feature\ for\ Ampere\ Computing\ eMAG\ SATA.eml
> ERROR: patch seems to be corrupt (line wrapped?)
> #177: FILE: drivers/ata/ahci_platform.c:34:
> 
> 
> ERROR: DOS line endings
> #178: FILE: drivers/ata/ahci_platform.c:35:
> +static const struct ata_port_info ahci_port_info_nolpm = {^M$
> 
> ERROR: DOS line endings
> #179: FILE: drivers/ata/ahci_platform.c:36:
> +^I.flags^I^I= AHCI_FLAG_COMMON | ATA_FLAG_NO_LPM,^M$
> 
> ERROR: DOS line endings
> #180: FILE: drivers/ata/ahci_platform.c:37:
> +^I.pio_mask^I= ATA_PIO4,^M$
> 
> ERROR: DOS line endings
> #181: FILE: drivers/ata/ahci_platform.c:38:
> +^I.udma_mask^I= ATA_UDMA6,^M$
> 
> Followed by lots more errors, line 177 of the email is empty, while it should contain a single space. This stripping of whitespace typically is the result of copy pasting or some other processing of the patch.
> 
> Please try to re-send v3 using the "git send-email" command, so that we get a patch which we can actually apply.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
>> ---
>>    drivers/ata/ahci_platform.c | 15 ++++++++++++++-
>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>> index 99f9a89..9ba283f 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -33,6 +33,13 @@ static const struct ata_port_info ahci_port_info = {
>>        .port_ops       = &ahci_platform_ops,
>>    };
>>
>> +static const struct ata_port_info ahci_port_info_nolpm = {
>> +     .flags          = AHCI_FLAG_COMMON | ATA_FLAG_NO_LPM,
>> +     .pio_mask       = ATA_PIO4,
>> +     .udma_mask      = ATA_UDMA6,
>> +     .port_ops       = &ahci_platform_ops,
>> +};
>> +
>>    static struct scsi_host_template ahci_platform_sht = {
>>        AHCI_SHT(DRV_NAME),
>>    };
>> @@ -41,6 +48,7 @@ static int ahci_probe(struct platform_device *pdev)
>>    {
>>        struct device *dev = &pdev->dev;
>>        struct ahci_host_priv *hpriv;
>> +     const struct ata_port_info *port;
>>        int rc;
>>
>>        hpriv = ahci_platform_get_resources(pdev);
>> @@ -57,7 +65,11 @@ static int ahci_probe(struct platform_device *pdev)
>>        if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>>                hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>>
>> -     rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
>> +     port = acpi_device_get_match_data(dev);
>> +     if (!port)
>> +             port = &ahci_port_info;
>> +
>> +     rc = ahci_platform_init_host(pdev, hpriv, port,
>>                                     &ahci_platform_sht);
>>        if (rc)
>>                goto disable_resources;
>> @@ -85,6 +97,7 @@ static const struct of_device_id ahci_of_match[] = {
>>    MODULE_DEVICE_TABLE(of, ahci_of_match);
>>
>>    static const struct acpi_device_id ahci_acpi_match[] = {
>> +     { "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
>>        { ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
>>        {},
>>    };
>> --
>> 2.7.4
>>
