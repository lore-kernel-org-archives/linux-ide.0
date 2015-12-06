From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] ahci: compile out msi/msix infrastructure
Date: Sat, 5 Dec 2015 16:05:49 -0800
Message-ID: <CAPcyv4ihdGDKuLQ+BfN6XKpRwhP_c2-Kv42oyJjnCT=Nvub+4g@mail.gmail.com>
References: <20151204195830.2300.48789.stgit@dwillia2-desk3.jf.intel.com>
	<1540836.svMP4lTcYC@wuerfel>
	<1693285.M8jQWtVTWx@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35815 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbbLFAFu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Dec 2015 19:05:50 -0500
Received: by ykba77 with SMTP id a77so160320932ykb.2
        for <linux-ide@vger.kernel.org>; Sat, 05 Dec 2015 16:05:50 -0800 (PST)
In-Reply-To: <1693285.M8jQWtVTWx@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tejun Heo <tj@kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Sat, Dec 5, 2015 at 2:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 05 December 2015 23:22:49 Arnd Bergmann wrote:
>> On Friday 04 December 2015 11:58:30 Dan Williams wrote:
>> > +#ifdef CONFIG_PCI_MSI
>> > +static inline int ahci_irq_vector(struct ahci_host_priv *hpriv, int port)
>> > +{
>> > +       if (hpriv->flags & AHCI_HFLAG_MULTI_MSIX)
>> > +               return hpriv->msix[i].vector;
>> > +       else
>> > +               return hpriv->irq + i;
>> > +}
>> >
>>
>> My randconfig tests now noticed that 'i' is undeclared here. I suppose it
>> should be 'port' instead of 'i'?
>>
>
> and one more:
>
> In file included from /git/arm-soc/drivers/ata/ahci_platform.c:25:0:
> /git/arm-soc/drivers/ata/ahci.h: In function 'ahci_irq_vector':
> /git/arm-soc/drivers/ata/ahci.h:368:3: error: invalid use of undefined type 'struct msix_entry'
>    return hpriv->msix[port].vector;
>    ^
> /git/arm-soc/drivers/ata/ahci.h:368:21: error: dereferencing pointer to incomplete type 'struct msix_entry'
>    return hpriv->msix[port].vector;
>
>
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index c450b8a914eb..dfbd033706bb 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -37,6 +37,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/libata.h>
> +#include <linux/pci.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regulator/consumer.h>
>

I'll resend, sloppy on my part.
