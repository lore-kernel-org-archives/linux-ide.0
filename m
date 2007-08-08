From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Wed, 08 Aug 2007 22:40:54 +0900
Message-ID: <46B9C7E6.8050300@gmail.com>
References: <20070807054250.GQ13674@htj.dyndns.org>	<20070807162529.1781b21c@the-village.bc.nu>	<46B89177.2040209@gmail.com>	<20070807175844.6818ffc9@the-village.bc.nu>	<46B92894.8060502@gmail.com> <20070808102309.7fc792e0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.226]:48463 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbXHHNlB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 09:41:01 -0400
Received: by qb-out-0506.google.com with SMTP id o24so1946859qba
        for <linux-ide@vger.kernel.org>; Wed, 08 Aug 2007 06:41:00 -0700 (PDT)
In-Reply-To: <20070808102309.7fc792e0@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net

Luiz Fernando N. Capitulino wrote:
> Em Wed, 08 Aug 2007 11:21:08 +0900
> Tejun Heo <htejun@gmail.com> escreveu:
> 
> | Alan Cox wrote:
> | >>> I'd rather know what is going on here. A drive can legitimately
> | >>> support LBA48 and HPA and refuse READ_NATIVE_MAX_EXT.
> | >> READ_NATIVE_MAX_EXT is mandatory if HPA && LBA48, no
> | > 
> | > Ok the report in that thread is different. The offending Maxtor simply
> | > aborts the read_native_max_ext
> | 
> | I'll resend sans ata_id_has_hpa() change.  Does that sound okay?  I
> | don't really think we can do anything other than blacklisting it.
> 
>  Does that make your patch invalid or is it still ok?

You controller being ICH ahci, I don't think the chance of the
controller messing things up is pretty slim but, just in case, do you
have another SATA controller to cross check?  If not, can you put the
controller into IDE mode so that ata_piix can drive it and test whether
the problem persists?

Thanks.

-- 
tejun
