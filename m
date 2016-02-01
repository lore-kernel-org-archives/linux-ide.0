From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v2 2/3] libahci: Implement the capability to override the
 generic ahci interrupt handler.
Date: Mon, 1 Feb 2016 11:43:56 -0800
Message-ID: <CAOHikRBmZ2Nk5knH7_4X+ieTYN9ubWrEwhTNAvQzq5cxWmLDJA@mail.gmail.com>
References: <1453888197-11368-1-git-send-email-stripathi@apm.com>
	<1453888197-11368-3-git-send-email-stripathi@apm.com>
	<20160131113540.GX32380@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35383 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbcBATn5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2016 14:43:57 -0500
Received: by mail-yk0-f182.google.com with SMTP id r207so116189588ykd.2
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2016 11:43:56 -0800 (PST)
In-Reply-To: <20160131113540.GX32380@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>, patches <patches@apm.com>, Suman Tripathi <svtripathi@gmail.com>

On Sun, Jan 31, 2016 at 3:35 AM, Tejun Heo <htejun@gmail.com> wrote:
> On Wed, Jan 27, 2016 at 03:19:56PM +0530, Suman Tripathi wrote:
>> @@ -2466,13 +2467,19 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
>>  {
>>       struct ahci_host_priv *hpriv = host->private_data;
>>       int irq = hpriv->irq;
>> +     irqreturn_t (*ahci_irq_handler)(int irq, void *dev_instance);
>>       int rc;
>>
>>       if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
>>               rc = ahci_host_activate_multi_irqs(host, sht);
>
> You need to add { } to the if body too.  Please read CodingStyle.
>
>> -     else
>> -             rc = ata_host_activate(host, irq, ahci_single_level_irq_intr,
>> +     else {
>> +             ahci_irq_handler = hpriv->ahci_irq_intr ? hpriv->ahci_irq_intr :
>> +                                ahci_single_level_irq_intr;
>> +
>> +             rc = ata_host_activate(host, irq, ahci_irq_handler,
>>                                      IRQF_SHARED, sht);
>> +     }
>
> Can you please make this handled the same way as ->start_engine?
> Also, maybe print out a warning message if a driver specifies both
> AHCI_HFLAG_MULTI_MSI[X] and the irq handler override?

Ok Sure
>
> Thanks.
>
> --
> tejun



-- 
Thanks,
with regards,
Suman Tripathi
