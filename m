From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH]ata:ahci.c Fix warning: comparison between 'enum <anonymous>'
 and 'enum <anonymous>'
Date: Wed, 14 Jul 2010 06:35:00 -0700
Message-ID: <4C3DBD04.7020908@gmail.com>
References: <1278167365-16011-1-git-send-email-justinmattock@gmail.com> <4C3D6C9D.7070708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64566 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0GNNfG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jul 2010 09:35:06 -0400
Received: by pvc7 with SMTP id 7so2724493pvc.19
        for <linux-ide@vger.kernel.org>; Wed, 14 Jul 2010 06:35:05 -0700 (PDT)
In-Reply-To: <4C3D6C9D.7070708@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, tj@kernel.org

On 07/14/2010 12:51 AM, Jeff Garzik wrote:
> On 07/03/2010 10:29 AM, Justin P. Mattock wrote:
>> The below patch casts ATA_MAX_QUEUE to int because GCC will
>> give a warning message about the two different enum blocks:
>> CC drivers/ata/ahci.o
>> drivers/ata/ahci.c: In function 'ahci_init_one':
>> drivers/ata/ahci.c:1045:2: warning: comparison between
>> 'enum<anonymous>' and 'enum<anonymous>'
>>
>> Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>>
>> ---
>> drivers/ata/ahci.c | 2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index f252253..fe75d8b 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -1042,7 +1042,7 @@ static int ahci_init_one(struct pci_dev *pdev,
>> const struct pci_device_id *ent)
>>
>> VPRINTK("ENTER\n");
>>
>> - WARN_ON(ATA_MAX_QUEUE> AHCI_MAX_CMDS);
>> + WARN_ON((int)ATA_MAX_QUEUE> AHCI_MAX_CMDS);
>>
>
> applied
>
>
>

o.k. cool..

Justin P. Mattock
