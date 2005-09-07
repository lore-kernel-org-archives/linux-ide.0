From: Tejun Heo <htejun@gmail.com>
Subject: Re: RE :sata_sil + UDMA CRC errors
Date: Wed, 07 Sep 2005 18:56:44 +0900
Message-ID: <431EB95C.3070801@gmail.com>
References: <200509070730.j877UxgA022401@ns.isp.nsc.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:11803 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932093AbVIGJ4u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2005 05:56:50 -0400
Received: by zproxy.gmail.com with SMTP id r28so962534nza
        for <linux-ide@vger.kernel.org>; Wed, 07 Sep 2005 02:56:50 -0700 (PDT)
In-Reply-To: <200509070730.j877UxgA022401@ns.isp.nsc.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: 'Jeff Garzik' <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com, Paul.Taylor@siliconimage.com, lbattraw@insightbb.com, 'Yuri Kirsanov' <flash@rccb.ru>, 'Jeremy Smith' <alceste@xmission.com>, shaposh@isp.nsc.ru


  Hello, Alexander & Jeremy.

Alexander Shaposhnikov wrote:
> Hellow Tejun
> 
> I tried your patch (by the way, it cannot be applied by patch utility -it
> complains about malformed expression on line 19 and so on)
> Default reads in 500mv. With 600mv, I am starting to get CRC errors for
> Seagate drive (no errors with 2.6.13-git4). Samsung drive produces so many
> errors, that it is unusable both with and without patch.

  Ugh... that's ugly. :-/

  Jeremy, apparantly my little patch doesn't do any good.  Please ignore it.

> Concerning K8N-DL motherboard -current BIOS 1004 is very buggy. It has
> screwed up ACPI APIC table. To use onboard lan and usb, I have to boot with 
> pci=noacpi boot option. And I cannot use 1003, as I have DualCore Opterons, 
> and 1004 the only one which supports them!
> 
> There is long problem with Nvidia CK804 southbridge sata under Linux.
> Despite that the board was released some 8 month ago, it still cannot be
> used! And nobody seems to care about this. ASUS in the least. 
> I was able to boot from NVidia SATA with latest kernel and irqpoll option.
> At first I thought that all my problems are gone at last, but the god
> decided differently. It works at light disk load, but havy load lead to
> system freeze. No errors, just dead freeze. I returned to silicon3114 sata.
> At least, I have one working drive now:)
> 

  I fear that there's nothing much else I can do about this K8N-DL sil 
CRC error.  I've read the hw doc but couldn't find anything which seems 
helpful.  Let's hope something (BIOS update?) comes up soon.

  Sorry.

-- 
tejun
