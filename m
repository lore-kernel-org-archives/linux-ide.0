From: Borislav Petkov <bp@amd64.org>
Subject: Re: Machine check exception
Date: Mon, 1 Aug 2011 10:48:55 +0200
Message-ID: <20110801084855.GA24997@aftab>
References: <4E2FF0EC.2020704@gmail.com>
 <20110727130319.GA26923@gere.osrc.amd.com>
 <4E302F6C.3@gmail.com>
 <20110727170309.GB26923@gere.osrc.amd.com>
 <4E307AF3.40109@gmail.com>
 <4E308360.8080302@gmail.com>
 <20110728074719.GA16261@liondog.tnic>
 <4E3510D1.8010703@gmail.com>
 <20110731120944.GA17348@aftab>
 <4E357B31.8070906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s15228384.onlinehome-server.info ([87.106.30.177]:40410 "EHLO
	mail.x86-64.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab1HAItD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Aug 2011 04:49:03 -0400
Content-Disposition: inline
In-Reply-To: <4E357B31.8070906@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "F. P. Beekhof" <fpbeekhof@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Mikael Pettersson <mikpe@it.uu.se>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Jul 31, 2011 at 11:56:33AM -0400, F. P. Beekhof wrote:
> $ sudo setpci -s 18.3 0x44.l
> 00400040

Interesting, this says ECC is enabled on your machine. Do you know the
exact models of your DIMMs? Sometimes they can be found in dmidecode
output so can you do

dmidecode > dmidecode.out

and

lspci -s 18.3 -xxxx > f3.out

as root and send me both files pls?

..

> >> Are there any conclusions that can be drawn from this experiment ?
> >
> > Yeah, it means that your BIOS doesn't seem to have the fix for erratum
> > #131: http://support.amd.com/us/Processor_TechDocs/25759.pdf, page 83.
> 
> So, this is not a problem with the promise-sata driver as I originally 
> suspected. I guess then we can take this discussion off the linux-ide 
> list...

Yeah, looks like it.

-- 
Regards/Gruss,
Boris.

Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach
GM: Alberto Bozzo
Reg: Dornach, Landkreis Muenchen
HRB Nr. 43632 WEEE Registernr: 129 19551
