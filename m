From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] ahci: don't use MSI when PCI is disabled
Date: Fri, 4 Dec 2015 08:37:05 -0800
Message-ID: <CAPcyv4iooKQKYwFnpd7tg0mis=Y3C-P4z4obrwS7m=4jMN5rvQ@mail.gmail.com>
References: <4754092.OYovO36g28@wuerfel>
	<CAPcyv4gSjWZ7OPqp9fwtc9yGV9g5AKkkCLDnU-F71XsHBgYUQA@mail.gmail.com>
	<6160865.VIglm5oKj3@wuerfel>
	<2230814.fGlctTNBzj@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33702 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbbLDQhH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Dec 2015 11:37:07 -0500
Received: by ykdv3 with SMTP id v3so130057448ykd.0
        for <linux-ide@vger.kernel.org>; Fri, 04 Dec 2015 08:37:05 -0800 (PST)
In-Reply-To: <2230814.fGlctTNBzj@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Ricardo Neri <ricardo.neri@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>

On Fri, Dec 4, 2015 at 8:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 23 November 2015 20:34:30 Arnd Bergmann wrote:
>> On Monday 23 November 2015 09:25:38 Dan Williams wrote:
>> >
>> > If we had an "static inline ahci_irq_vector(int port)"  helper to
>> > compile out the struct msix_entry de-reference would that be
>> > sufficient?
>>
>> Yes, that is probably a nicer way to do it. We should then also do
>> something like this:
>>
>> @@ -2510,7 +2513,8 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
>>         int irq = hpriv->irq;
>>         int rc;
>>
>> -       if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
>> +       if (IS_ENABLED(CONFIG_PCI_MSI) && \
>> +           hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
>>                 rc = ahci_host_activate_multi_irqs(host, sht);
>>         else if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ)
>>                 rc = ata_host_activate(host, irq, ahci_single_edge_irq_intr,
>>
>> which will let gcc leave out the entire ahci_host_activate_multi_irqs()
>> function but still flag compile errors in it even if CONFIG_PCI is
>> disabled.
>>
>
> Dan, are you going to do the ahci_irq_vector patch, or should we use my
> original patch to fix up the build error?

Ah, I was about to ask you the same question.  No worries, I'll send
out a patch with the above approach today.
