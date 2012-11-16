From: Simple Simon <tangouniform@sbcglobal.net>
Subject: Re: [PATCH] libata-acpi: Fix NULL ptr derference in ata_acpi_dev_handle
Date: Fri, 16 Nov 2012 03:40:44 +0000
Message-ID: <50A5B5BC.8060006@sbcglobal.net>
References: <5073D44C.7070101@intel.com> <CABZ+qqkv-iuAxs=DXnQzQn+j-BWaH5jwLsuv0nREFpz3gqHE=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CABZ+qqkv-iuAxs=DXnQzQn+j-BWaH5jwLsuv0nREFpz3gqHE=g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Cc: Aaron Lu <aaron.lu@intel.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 2012-10-11 08:27, Dan van der Ster wrote:
> On Tue, Oct 9, 2012 at 9:37 AM, Aaron Lu <aaron.lu@intel.com> wrote:
>> commit 6b66d95895c149cbc04d4fac5a2f5477c543a8ae didn't handle SATA PMP
>> case in ata_acpi_bind_device and will cause a NULL ptr dereference when
>> user attached a SATA drive to the PMP port. Fix this by checking PMP
>> support.
>>
>> This bug is reported by Dan van der Ster in the following bugzilla page:
>> https://bugzilla.kernel.org/show_bug.cgi?id=48211
>>
>> Reported-by: Dan van der Ster <dan@vanderster.com>
>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>> Cc: <stable@vger.kernel.org>
> Tested-by: Dan van der Ster <dan@vanderster.com>
Tested-by: Simon <tangouniform@sbcglobal.net>

There's a third successful patch test report attached to the bugzilla
entry (link above) 10 days ago.

I ran into this, with 3.6.6 failing to boot, I think because of an
esata-attached enclosure w/ port multiplier.


>> ---
>>  drivers/ata/libata-acpi.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
>> index fd9ecf7..5b0ba3f 100644
>> --- a/drivers/ata/libata-acpi.c
>> +++ b/drivers/ata/libata-acpi.c
>> @@ -1105,10 +1105,15 @@ static int ata_acpi_bind_device(struct ata_port *ap, struct scsi_device *sdev,
>>         struct acpi_device *acpi_dev;
>>         struct acpi_device_power_state *states;
>>
>> -       if (ap->flags & ATA_FLAG_ACPI_SATA)
>> -               ata_dev = &ap->link.device[sdev->channel];
>> -       else
>> +       if (ap->flags & ATA_FLAG_ACPI_SATA) {
>> +               if (!sata_pmp_attached(ap))
>> +                       ata_dev = &ap->link.device[sdev->id];
>> +               else
>> +                       ata_dev = &ap->pmp_link[sdev->channel].device[sdev->id];
>> +       }
>> +       else {
>>                 ata_dev = &ap->link.device[sdev->id];
>> +       }
>>
>>         *handle = ata_dev_acpi_handle(ata_dev);
>>
>> --
>> 1.7.12.21.g871e293
>>

