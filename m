From: kelk1@comcast.net (Quel Qun)
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to HDS724040KLSA80
Date: Wed, 08 Aug 2007 16:50:39 +0000
Message-ID: <080820071650.11586.46B9F45F0005906600002D422200761438CE05040A05@comcast.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:63979 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbXHHQuv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 12:50:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org

 -------------- Original message ----------------------
From: Tejun Heo <htejun@gmail.com>
> Luiz Fernando N. Capitulino wrote:
> > Em Wed, 08 Aug 2007 11:21:08 +0900
> > Tejun Heo <htejun@gmail.com> escreveu:
> > 
> > | Alan Cox wrote:
> > | >>> I'd rather know what is going on here. A drive can legitimately
> > | >>> support LBA48 and HPA and refuse READ_NATIVE_MAX_EXT.
> > | >> READ_NATIVE_MAX_EXT is mandatory if HPA && LBA48, no
> > | > 
> > | > Ok the report in that thread is different. The offending Maxtor simply
> > | > aborts the read_native_max_ext
> > | 
> > | I'll resend sans ata_id_has_hpa() change.  Does that sound okay?  I
> > | don't really think we can do anything other than blacklisting it.
> > 
> >  Does that make your patch invalid or is it still ok?
> 
> You controller being ICH ahci, I don't think the chance of the
> controller messing things up is pretty slim but, just in case, do you
> have another SATA controller to cross check?  If not, can you put the
> controller into IDE mode so that ata_piix can drive it and test whether
> the problem persists?
>
Hi, 
Unfortunately, I do not have any machine with a different controller. Whichever 
I pick in the BIOS between ATA and AHCI, it seems that the drive is always 
handled by the ahci module, and the boot process goes the exact same way.
Is there a way to force the IDE mode?
--
kk1

