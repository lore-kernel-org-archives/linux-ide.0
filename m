From: Roger Heflin <rheflin@atipa.com>
Subject: Re: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2
Date: Wed, 26 Apr 2006 09:42:26 -0500
Message-ID: <444F86D2.7030000@atipa.com>
References: <8E8F647D7835334B985D069AE964A4F7011B2606@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:52730 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932456AbWDZOm1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Apr 2006 10:42:27 -0400
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7011B2606@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Fortier,Vincent [Montreal] wrote:
> I think I might be having the "same type of bug" or something related using sata_via?
> Bug opened at bugzilla: http://bugzilla.kernel.org/show_bug.cgi?id=6317
> 
> This started appearing with 2.6.16.  It often does it using only one SATA HD.  It does not do it at every boot but often starts doing it after a little while (a few hours...) and finally hanging my PC.
> 
> - vin
> 
>

I can duplicate my problem everything, and I can make it stop a will.

doing "dd if=/dev/sda of=/dev/null bs=64k &"

and then

        "dd if=/dev/sdb of=/dev/null bs=64k &"

will cause the problem within a couple of seconds.

Doing "kill %1 %2" (assuming the dd's are %1 and %2) will
stop the machine from hanging on disk io within 30-60 seconds.

Once it hangs it does not appear to do any disk io until the
offending processes are killed.

                               Roger
