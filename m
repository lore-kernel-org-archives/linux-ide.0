From: tedheadster <tedheadster@gmail.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Thu, 22 Dec 2016 13:30:23 -0500
Message-ID: <CAP8WD_agt=peX28+d_oTXhEOd_9ogMScO7h8xd1hTTsHzWz_Vg@mail.gmail.com>
References: <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com>
 <20161130202201.GA15989@htj.duckdns.org> <CAP8WD_bZWeLBhLXqJG5uDwBe+zBubw+A+ecSuaihOuwvw9QoCQ@mail.gmail.com>
 <20161202170705.GB6033@htj.duckdns.org> <CAP8WD_bUW9cAAQpvenL73sxvpoxNYwZdRqpj92YWEyanK51+0g@mail.gmail.com>
 <20161205192310.GA30331@mtj.duckdns.org> <CAP8WD_becq+h2=-g7t-6Pp1psmkCCvdB0YUcg+wYPocUP4dYdw@mail.gmail.com>
 <20161212170154.GA13864@htj.duckdns.org> <CAP8WD_YMtnsuYmJHGz1eLmrQNemsB1Z6Soyb6f72brAfMNUNeg@mail.gmail.com>
 <CAP8WD_ZoJgrdsDZNR4uN8HWESO5MyuNc1xN_F2an8GfP8nKcLA@mail.gmail.com>
 <20161222163711.GB29161@htj.duckdns.org> <CAP8WD_ay1uKc0JLPr8MWQKT2N=rdqeH+hKkOCVMt76NcmK4hAA@mail.gmail.com>
Reply-To: whiteheadm@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34044 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbcLVSao (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 22 Dec 2016 13:30:44 -0500
Received: by mail-yb0-f194.google.com with SMTP id h184so3390305ybb.1
        for <linux-ide@vger.kernel.org>; Thu, 22 Dec 2016 10:30:44 -0800 (PST)
In-Reply-To: <CAP8WD_ay1uKc0JLPr8MWQKT2N=rdqeH+hKkOCVMt76NcmK4hAA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

Greg,
  when calling drivers/ata/pata_legacy.c, it grabs four irq's even
though those legacy device probes fail:

root@i486:~# cat /proc/interrupts
           CPU0
  0:      95630    XT-PIC  timer
  1:       1028    XT-PIC  i8042
...
 10:          0    XT-PIC  platform[pata_legacy.3]
 11:          0    XT-PIC  platform[pata_legacy.2]
 12:          0    XT-PIC  platform[pata_legacy.5]
 14:      66786    XT-PIC  platform[pata_legacy.0]
 15:          0    XT-PIC  platform[pata_legacy.1]

Tejun believes that platform_device_unregister() should free the irqs:

>>
>> The thing I'm puzzled about and can't reproduce here is that the
>> platform_device_unregister() call on the fail path should release the
>> irq resources without the explicit devres group operations.  I can
>> write up tracking each step but it'd probably be easier on your side
>> to track down why it's not getting called.
>>
>> So, pata_legacy doesn't need anything changed, but in the probe fail
>> path, platform_device_unregister() should trigger
>> driver/base/core.c::device_release() which calls devres_release_all()
>> and release the irqs.
>>
>

I ponder if the driver should instead release the irq's from the failed probe:

> It looks to me that when something is 'platform' it is not expected to
> ever go away, and that generally includes irqs. There are calls to
> platform_get_irq() but there isn't even a function called
> platform_put_irq() or platform_free_irq().
>
...
> I think this driver should either not be considered 'platform' or it
> should make a call to free_irq() on failures.
>

The question is: who is responsible to free an irq from a device
registered using platform_device_register_simple()? Is it the driver
or the platform code?

- Matthew
