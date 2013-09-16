From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] BIOS SATA legacy mode failure
Date: Sun, 15 Sep 2013 22:37:44 -0600
Message-ID: <CADLC3L3tGG4yGZKir2pPzMYeddPjSFuD77u87C=YYEqtVn908Q@mail.gmail.com>
References: <522C1AC5.4080105@linux.com>
	<522E9982.2060504@gmail.com>
	<52347C24.8060102@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:43269 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab3IPEhp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Sep 2013 00:37:45 -0400
Received: by mail-qa0-f53.google.com with SMTP id k4so813682qaq.5
        for <linux-ide@vger.kernel.org>; Sun, 15 Sep 2013 21:37:44 -0700 (PDT)
In-Reply-To: <52347C24.8060102@linux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: levex@linux.com
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sat, Sep 14, 2013 at 9:09 AM, Levente Kurusa <levex@linux.com> wrote=
:
> 2013-09-10 06:01 keltez=E9ssel, Robert Hancock =EDrta:
>
>> On 09/08/2013 12:35 AM, Levente Kurusa wrote:
>>>
>>> Hi,
>>>
>>> I have been testing the Linux Kernel on a two year Toshiba NB100
>>> netbook of mine, however when I enabled SATA compatibility/legacy m=
ode
>>> instead of AHCI mode in the BIOS, the kernel got stuck. I have past=
ed
>>> the relevant dmesg piece along with a patch that fixes it temporari=
ly.
>>> What I suspect to be the cause is that the BIOS sets the device int=
o
>>> IDE mode, but it will report it as a SATA device and hence libata t=
ries
>>> to send ATA commands to it, which obviously makes it go bad. The pa=
tch
>>
>>
>> No, the commands are the same whichever mode the controller is in. T=
he
>> problem is presumably something else, like maybe some kind of interr=
upt
>> routing problem when the controller is in legacy mode.
>>
> Yes, I see now.
>
>
>>> fixes it, by adding a new field to ata_device called exce_cnt, whic=
h
>>> counts how many exceptions have occured. After three exceptions, it
>>> automatically disables the device. Also, please note this is my fir=
st
>>> ever patch for the kernel :-)
>>>
>>> The following dmesg is stuck in an infinite loop.
>>> dmesg:
>>> ata3: lost interrupt (Status 0x50)
>>> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
>>> ata3.00: failed command: READ DMA
>>> ata3.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
>>>                res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
>>> (timeout)
>>> ata3.00: status: { DRDY }
>>> ata3: soft resetting link
>>> ata3.00: configured for UDMA/33 (no error)
>>> ata3.00: device reported invalid CHS sector 0
>>> ata3: EH complete
>>>
>>> Patch that fixes the infinite loop:
>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>> index f9476fb..eeedf80 100644
>>> --- a/drivers/ata/libata-eh.c
>>> +++ b/drivers/ata/libata-eh.c
>>> @@ -2437,6 +2437,14 @@ static void ata_eh_link_report(struct ata_li=
nk
>>> *link)
>>>                              ehc->i.action, frozen, tries_buf);
>>>                  if (desc)
>>>                          ata_dev_err(ehc->i.dev, "%s\n", desc);
>>> +               ehc->i.dev->exce_cnt ++;
>>> +               ata_dev_warn(ehc->i.dev, "Number of exceptions: %d\=
n",
>>> ehc->i.dev->exce_cnt);
>>> +               /**
>>> +                  * The device is failing terribly,
>>> +                 * disable it to prevent damage.
>>> +                 */
>>> +               if(ehc->i.dev->exce_cnt > 2)
>>> +                       ata_dev_disable(ehc->i.dev);
>>>          } else {
>>>                  ata_link_err(link, "exception Emask 0x%x "
>>>                               "SAct 0x%x SErr 0x%x action 0x%x%s%s\=
n",
>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>> index eae7a05..fa52ee6 100644
>>> --- a/include/linux/libata.h
>>> +++ b/include/linux/libata.h
>>> @@ -660,7 +660,8 @@ struct ata_device {
>>>          u8                      devslp_timing[ATA_LOG_DEVSLP_SIZE]=
;
>>>
>>>          /* error history */
>>> -       int                     spdn_cnt;
>>> +       int                     spdn_cnt; /* Number of speed_downs =
*/
>>> +       int                     exce_cnt; /* Number of exceptions t=
hat
>>> happenned */
>>>          /* ering is CLEAR_END, read comment above CLEAR_END */
>>>          struct ata_ering        ering;
>>>   };
>>>
>>
>> This doesn't seem like a very good fix. It may prevent the apparent
>> infinite loop but will just prevent that device from functioning at =
all.
>> It would be better if we could figure out what was actually going wr=
ong.
>>
>>
> I have tested the problem with three different computers, all switche=
d
> to legacy/IDE/compatibility mode, and they didn't have this problem. =
Of
> course, they could have been set to AHCI mode, and there the kernel w=
ould
> boot normally. Feels strange, but so far I was only able to reproduce=
 the
> problem with a Toshiba MK8052GSX. On the topic of my patch, I still d=
on't
> see why a device which fails so terribly that it reports 3 exceptions
> shouldn't be disabled. Like in this case, it could cause infinite loo=
ps.

The problem is that this could happen in some cases when you wouldn't
want to disable the device, like an error that just happens
sporadically and works on retry, or a device you're trying to recover
data from.
