From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: Re: [PATCH] Intel device IDs SATA
Date: Fri, 6 Nov 2015 15:56:54 -0800
Message-ID: <563D3E46.6020708@linux.intel.com>
References: <1446577791-3087-1-git-send-email-alexandra.yates@linux.intel.com>
 <CAHp75VfMHS7nRGUtS=rDeviH9CRR43+nhMjU5O6VbC9NL3ZeUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21054 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbbKFXyG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Nov 2015 18:54:06 -0500
In-Reply-To: <CAHp75VfMHS7nRGUtS=rDeviH9CRR43+nhMjU5O6VbC9NL3ZeUw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Tejun,


On 11/06/2015 10:42 AM, Andy Shevchenko wrote:
> On Tue, Nov 3, 2015 at 9:09 PM, Alexandra Yates
> <alexandra.yates@linux.intel.com> wrote:
>> Adding Intel codename Lewisburg platform device IDs for SATA.
>>
>> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
>> ---
>>   drivers/ata/ahci.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index a466602..8c7a04a 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -68,6 +68,7 @@ enum board_ids {
>>          board_ahci_yes_fbs,
>>
>>          /* board IDs for specific chipsets in alphabetical order */
>> +       board_ahci_lbg,
>>          board_ahci_avn,
>>          board_ahci_mcp65,
>>          board_ahci_mcp77,
>> @@ -161,6 +162,13 @@ static const struct ata_port_info ahci_port_info[] = {
>>                  .port_ops       = &ahci_ops,
>>          },
>>          /* by chipsets */
>> +       [board_ahci_lbg] = {
>> +               .flags          = AHCI_FLAG_COMMON,
>> +               .pio_mask       = ATA_PIO4,
>> +               .udma_mask      = ATA_UDMA6,
>> +               .port_ops       = &ahci_ops,
>> +       },
>> +
>>          [board_ahci_avn] = {
>>                  .flags          = AHCI_FLAG_COMMON,
>>                  .pio_mask       = ATA_PIO4,
>> @@ -314,6 +322,16 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>          { PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
>>          { PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
>>          { PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
>> +       { PCI_VDEVICE(INTEL, 0xa182), board_ahci_lbg }, /* Lewisburg AHCI*/
>> +       { PCI_VDEVICE(INTEL, 0xa202), board_ahci_lbg }, /* Lewisburg AHCI*/
>> +       { PCI_VDEVICE(INTEL, 0xa184), board_ahci_lbg }, /* Lewisburg RAID*/
>> +       { PCI_VDEVICE(INTEL, 0xa204), board_ahci_lbg }, /* Lewisburg RAID*/
>> +       { PCI_VDEVICE(INTEL, 0xa186), board_ahci_lbg }, /* Lewisburg RAID*/
>
> I think it makes sense to keep IDs ordered at least in range of one group

Since this patch was already accepted I'm sending you a separate patch 
to correct the order as suggested by Andy.

>
>> +       { PCI_VDEVICE(INTEL, 0xa206), board_ahci_lbg }, /* Lewisburg RAID*/
>> +       { PCI_VDEVICE(INTEL, 0x2822), board_ahci_lbg }, /* Lewisburg RAID*/
>> +       { PCI_VDEVICE(INTEL, 0x2826), board_ahci_lbg }, /* Lewisburg RAID*/
>> +       { PCI_VDEVICE(INTEL, 0xa18e), board_ahci_lbg }, /* Lewisburg RAID*/
>> +       { PCI_VDEVICE(INTEL, 0xa20e), board_ahci_lbg }, /* Lewisburg RAID*/
>>          { PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg RAID */
>>          { PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg RAID */
>>          { PCI_VDEVICE(INTEL, 0x8d02), board_ahci }, /* Wellsburg AHCI */
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>

-- 
Thank you,
<Alexandra>
