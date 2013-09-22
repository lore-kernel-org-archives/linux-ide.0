From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH] ata_piix: minor typo fixes and threading fix
Date: Sun, 22 Sep 2013 17:05:51 +0200
Message-ID: <523F074F.5080107@linux.com>
References: <523EF645.7050808@linux.com> <523F0262.7070809@cogentembedded.com>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:43502 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab3IVPFy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Sep 2013 11:05:54 -0400
Received: by mail-ea0-f169.google.com with SMTP id k11so1220979eaj.0
        for <linux-ide@vger.kernel.org>; Sun, 22 Sep 2013 08:05:53 -0700 (PDT)
In-Reply-To: <523F0262.7070809@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

2013-09-22 16:44 keltez=E9ssel, Sergei Shtylyov =EDrta:
> Hello.
>
> On 22.09.2013 17:53, Levente Kurusa wrote:
>
>> Hi,
>
>> The following patch fixes a printk() call, which was originally used=
 with
>> pr_cont, which will however fail. Fixed that with setting up a buffe=
r
>> to save
>> data to that first, and then printk() it. The patch also
>> fixes some minor typos and a comment, so that it better reflects the
>> documentation of ICH*.
>
>     Wrap your changelog lines at 80 columns (preferably less).
>
>> Regards,
>> Levente Kurusa
>
>     The patch changelog is not a place for greetings and regards.
Sorry for that.
>
>> Signed-off-by: Levente Kurusa <levex@linux.com>
>> ---
>> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
>> index 93cb092..b7bf3df 100644
>> --- a/drivers/ata/ata_piix.c
>> +++ b/drivers/ata/ata_piix.c
>> @@ -100,7 +100,7 @@
>>
>>   enum {
>
>     Your patch is whitespace damaged, there was no space on previous
> line, and there are two spaces starting this line (instead of one).
>
>> @@ -1368,34 +1368,53 @@ static const int *piix_init_sata_map(struct
>> pci_dev
>> *pdev,
>>       pci_read_config_byte(pdev, ICH5_PMR, &map_value);
>>
>>       map =3D map_db->map[map_value & map_db->mask];
>> -
>> -    dev_info(&pdev->dev, "MAP [");
>> +    char* mapdata[4];
>
>     Don't mix declarations and data.
>
>>       for (i =3D 0; i < 4; i++) {
>>           switch (map[i]) {
>>           case RV:
>>               invalid_map =3D 1;
>> -            pr_cont(" XX");
>> +            mapdata[i] =3D" XX";
>>               break;
>>
>>           case NA:
>> -            pr_cont(" --");
>> +            mapdata[i] =3D " --";
>>               break;
>>
>>           case IDE:
>>               WARN_ON((i & 1) || map[i + 1] !=3D IDE);
>>               pinfo[i / 2] =3D piix_port_info[ich_pata_100];
>>               i++;
>> -            pr_cont(" IDE IDE");
>> +            mapdata[i] =3D " IDE IDE";
>> +            break;
>> +        case P0:
>> +            mapdata[i] =3D " P0";
>> +            if (i & 1)
>> +                pinfo[i / 2].flags |=3D ATA_FLAG_SLAVE_POSS;
>> +            break;
>> +        case P1:
>> +            mapdata[i] =3D " P1";
>> +            if (i & 1)
>> +                pinfo[i / 2].flags |=3D ATA_FLAG_SLAVE_POSS;
>> +            break;
>> +        case P2:
>> +            mapdata[i] =3D " P2";
>> +            if (i & 1)
>> +                pinfo[i / 2].flags |=3D ATA_FLAG_SLAVE_POSS;
>> +            break;
>> +        case P3:
>> +            mapdata[i] =3D " P3";
>> +            pinfo[i / 2].flags |=3D ATA_FLAG_SLAVE_POSS;
>> +            if (i & 1)
>> +                pinfo[i / 2].flags |=3D ATA_FLAG_SLAVE_POSS;
>>               break;
>
>     I don't think the code repeating 4 times is a good idea.
I did this to prevent a goto, but changing that back then.
>
>> -
>>           default:
>> -            pr_cont(" P%d", map[i]);
>> +            mapdata[i] =3D " INV";
>>               if (i & 1)
>>                   pinfo[i / 2].flags |=3D ATA_FLAG_SLAVE_POSS;
>>               break;
>>           }
>>       }
>> -    pr_cont(" ]\n");
>> +    dev_info(&pdev->dev, "MAP [%s%s%s%s ]\n", mapdata[0], mapdata[1=
],
>> mapdata[2], mapdata[3], map_value, map_db->mask);
That was from my former debug mechanism, overlooked that. Sorry.
>
>     You didn't specify the formats for the last 2 arguments and your
> line is longer than 80 columns, please wrap it.
>
>> @@ -1718,18 +1741,17 @@ static int piix_init_one(struct pci_dev *pde=
v,
>> const
>> struct pci_device_id *ent)
>>           if (host->ports[0]->ops =3D=3D &piix_sidpr_sata_ops)
>>               sht =3D &piix_sidpr_sht;
>>       }
>> -
>
>     Why?
>
>>       /* apply IOCFG bit18 quirk */
>>       piix_iocfg_bit18_quirk(host);
>>
>> -    /* On ICH5, some BIOSen disable the interrupt using the
>> +    /* On ICH5, some BIOSes disable the interrupt using the
>
>     Why? "BIOSen" is not a typo, it's a jargon.
>
> WBR, Sergei
>
>
Thank you for all your comments, I am not
a native writer of english, and hence I didn't have knowledge
of that jargon. I am fixing the issues, as per checkpatch.pl and
your guidelines. Once finished, I will repost it.

--=20
Regards,
Levente Kurusa
