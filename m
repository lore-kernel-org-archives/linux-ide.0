From: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Fri, 04 May 2007 10:45:38 -0300
Message-ID: <463B3902.3050903@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com> <460896D8.8040203@gmail.com> <460899D4.6070708@gmail.com> <4608A0BD.2010209@gmail.com> <463B019E.7010700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:50067 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbXEDNpo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 09:45:44 -0400
Received: by an-out-0708.google.com with SMTP id b33so832283ana
        for <linux-ide@vger.kernel.org>; Fri, 04 May 2007 06:45:44 -0700 (PDT)
In-Reply-To: <463B019E.7010700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo escribi=F3:
> Mat=ED=ADas Alejandro Torres wrote:
>  =20
>> CORRECTION:
>>
>> I tried with the irqpoll parameter (used in the right way) and the s=
ata
>> disk is detected but lots of "unexpected IRQ trap at vector a0" are
>> displayed. When the pci=3Dnomsi flag is set, no warning/error is sho=
wn and
>> the SATA disk is detected properly.
>>
>>
>> This is for kernel version 2.6.17, I must be falling asleep.
>>    =20
>
> Matias, are you still there?  If so, can you please test the attached
> patch and see whether it fixes your problem - ie. boots okay without
> 'pci=3Dnomsi'?
>
>  =20
> ---------------------------------------------------------------------=
---
>
> Index: tree0/drivers/pci/quirks.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- tree0.orig/drivers/pci/quirks.c
> +++ tree0/drivers/pci/quirks.c
> @@ -1761,6 +1761,7 @@ static void __devinit quirk_disable_msi(
>  	}
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BR=
IDGE, quirk_disable_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x5a3f, quirk_disable_msi=
); /* RS480 PCI bridge */
> =20
>  /* Go through the list of Hypertransport capabilities and
>   * return 1 if a HT MSI capability is found and enabled */
>  =20
Okey, I'll try the patch and let you know how it goes. I'm sorry for no=
t=20
having test it but I'm been studing a lot these last few days. Tonight=20
I'll test it. Thanks!
