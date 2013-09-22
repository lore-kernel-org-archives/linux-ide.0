From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata_piix: minor typo fixes and threading fix
Date: Sun, 22 Sep 2013 19:10:01 +0400
Message-ID: <523F0849.8070000@cogentembedded.com>
References: <523EF645.7050808@linux.com> <523F0262.7070809@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:56277 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab3IVPKF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Sep 2013 11:10:05 -0400
Received: by mail-lb0-f176.google.com with SMTP id y6so1932182lbh.7
        for <linux-ide@vger.kernel.org>; Sun, 22 Sep 2013 08:10:04 -0700 (PDT)
In-Reply-To: <523F0262.7070809@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: levex@linux.com
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 22-09-2013 18:44, Sergei Shtylyov wrote:

>> Hi,

>> The following patch fixes a printk() call, which was originally used with
>> pr_cont, which will however fail. Fixed that with setting up a buffer to save
>> data to that first, and then printk() it. The patch also
>> fixes some minor typos and a comment, so that it better reflects the
>> documentation of ICH*.

>     Wrap your changelog lines at 80 columns (preferably less).

>> Regards,
>> Levente Kurusa

>     The patch changelog is not a place for greetings and regards.

>> Signed-off-by: Levente Kurusa <levex@linux.com>
>> ---
>> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
>> index 93cb092..b7bf3df 100644
>> --- a/drivers/ata/ata_piix.c
>> +++ b/drivers/ata/ata_piix.c
[...]
>> @@ -1368,34 +1368,53 @@ static const int *piix_init_sata_map(struct pci_dev
>> *pdev,
>>       pci_read_config_byte(pdev, ICH5_PMR, &map_value);
>>
>>       map = map_db->map[map_value & map_db->mask];
>> -
>> -    dev_info(&pdev->dev, "MAP [");
>> +    char* mapdata[4];

>     Don't mix declarations and data.

    Oops, I meant to type "code" instead of "data", of course.

WBR, Sergei

