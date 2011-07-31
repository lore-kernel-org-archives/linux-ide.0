From: "F. P. Beekhof" <fpbeekhof@gmail.com>
Subject: Re: Machine check exception
Date: Sun, 31 Jul 2011 17:56:33 +0200
Message-ID: <4E357B31.8070906@gmail.com>
References: <4E2FF0EC.2020704@gmail.com> <20110727130319.GA26923@gere.osrc.amd.com> <4E302F6C.3@gmail.com> <20110727170309.GB26923@gere.osrc.amd.com> <4E307AF3.40109@gmail.com> <4E308360.8080302@gmail.com> <20110728074719.GA16261@liondog.tnic> <4E3510D1.8010703@gmail.com> <20110731120944.GA17348@aftab>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51821 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab1GaP4i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Jul 2011 11:56:38 -0400
Received: by wyg8 with SMTP id 8so1090511wyg.19
        for <linux-ide@vger.kernel.org>; Sun, 31 Jul 2011 08:56:37 -0700 (PDT)
In-Reply-To: <20110731120944.GA17348@aftab>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@amd64.org>
Cc: Borislav Petkov <bp@alien8.de>, Mikael Pettersson <mikpe@it.uu.se>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


>> I found that one can enable ECC on ram in the bios, which I did. As
>> far as I know, this is non-ECC ram, so frankly I'm at a loss about
>
> Maybe the BIOS is not properly detecting whether DRAM is ECC or not.
> Normally, if it is not, it should simply remove the option to enable ECC
> from the menu.
>
> To check what the hw says, do
>
> $ setpci -s 18.3 0x44.l
>
> as root and send me the result pls.
>

$ sudo setpci -s 18.3 0x44.l
00400040

> I'd suggest you run your system at full swing and watch it for signs of
> trouble a couple of days longer just in case.

Ok.

>> Are there any conclusions that can be drawn from this experiment ?
>
> Yeah, it means that your BIOS doesn't seem to have the fix for erratum
> #131: http://support.amd.com/us/Processor_TechDocs/25759.pdf, page 83.

So, this is not a problem with the promise-sata driver as I originally 
suspected. I guess then we can take this discussion off the linux-ide 
list...

> I don't know whether there is BIOS for your ancient CPU :-) and if there
> were, whether upgrading it won't break something else.
>
> If I were you, I'd run the automated script hooks and don't care about
> upgrade... provided we don't see any other hickups that is and provided
> we manage to automate them so that you don't have to boot into recovery
> console every time.
>
> Let me know how it all plays out.

Will do! Many thanks!

> HTH.
>

