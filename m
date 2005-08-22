From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata:upstream] sil: apply M15W quirk selectively
Date: Mon, 22 Aug 2005 15:36:57 -0400
Message-ID: <430A2959.300@pobox.com>
References: <1121894035.4885.15.camel@drevil.aslab.com> <20050728141242.GA10010@htj.dyndns.org> <4308D3D0.50504@pobox.com> <4308E7F4.3000509@gmail.com> <4308EDB5.6060102@pobox.com> <4308F5CD.7060001@gmail.com> <58cb370e05082203194cf1f424@mail.gmail.com> <20050822114639.GA26607@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:40326 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750718AbVHVThF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 15:37:05 -0400
In-Reply-To: <20050822114639.GA26607@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Michael Madore <Michael.Madore@aslab.com>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
>  Hello, Jeff & Bartlomiej & all.
> 
> 
>>What about fixing 3114 for a start? :-)
> 
> 
>  Yeap, why not?  Here it is.
> --
> 
>  This patch adds chipset mask to sil_blacklist such that quirks can be
> applied selectively depending on chipset.  And add sil_3112_m15w
> chipset which is identical to sil_3112 except that mod15write quirk is
> applied.  As we don't know which PCI IDs are affected yet, I've
> changed all 3112's to sil_3112_m15w.  Later when we know which PCI IDs
> are affected, we can just change them to sil_3112 later.
> 
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Thanks for tackling this.  I would approach it in a different manner:

1) add to the enum at the top,
+	SIL_FLAG_M15W		= (1 << 30),

2) do
         sil_3112                = 0,
-       sil_3114                = 1,
+	sil_3112_m15w		= 1,
+	sil_3114		= 2,


3) in sil_pci_tbl[], change all the sil_3112 entries to sil_3112_m15w, 
EXCEPT for PCI ID 0x1095, 0x3512, which should remain sil_3112.



4) in sil_port_info[], duplicate sil_3112 entry to new entry 
sil_3112_m15w.  make sure order in sil_port_info[] array matches the 
values in step #2.


5) add SIL_FLAG_M15W to the list of host_flags in the new sil_3112_m15w 
entry created in step #4.


6) in sil_dev_config(), change
        if (quirks & SIL_QUIRK_MOD15WRITE) {
test to also test (ap->flags & SIL_FLAG_M15W)


Check over these steps to see if I missing anything...  at the very 
least, I have illustrated the approach that should be taken.

	Jeff


