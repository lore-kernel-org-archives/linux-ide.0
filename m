From: Borislav Petkov <bp@amd64.org>
Subject: Re: Machine check exception
Date: Sun, 31 Jul 2011 14:09:44 +0200
Message-ID: <20110731120944.GA17348@aftab>
References: <4E2FF0EC.2020704@gmail.com>
 <20110727130319.GA26923@gere.osrc.amd.com>
 <4E302F6C.3@gmail.com>
 <20110727170309.GB26923@gere.osrc.amd.com>
 <4E307AF3.40109@gmail.com>
 <4E308360.8080302@gmail.com>
 <20110728074719.GA16261@liondog.tnic>
 <4E3510D1.8010703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s15228384.onlinehome-server.info ([87.106.30.177]:60277 "EHLO
	mail.x86-64.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab1GaMJx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Jul 2011 08:09:53 -0400
Content-Disposition: inline
In-Reply-To: <4E3510D1.8010703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "F. P. Beekhof" <fpbeekhof@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@amd64.org>, Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi,

On Sun, Jul 31, 2011 at 04:22:41AM -0400, F. P. Beekhof wrote:
> I've used the hooks to call a script, the value is 100008 after
> resume, and I'm booting the system by going onto 'recovery console',
> running the script to set msr 0xc001001f to 100008, then completing
> the normal boot procedure.

Hmm, there has a to be a way to automate that. Maybe push
/etc/init.d/rc.local up in the call prio so that it gets run as early as
possible?

> So far, it seems to have fixed the issue, in the sense that there have
> been no MCEs yet. There was some call trace after a suspend/resume
> (see below), but that's it.

Yeah, its on resume. This warning fires because it took the system
17880 msecs to resume and the test was expecting something under 10000.
It could be unstable RTC clock or something. You could disable it by
turning CONFIG_PM_TEST_SUSPEND off for your kernel if there's no other
issues with suspend/resume beside that warning firing.

> I found that one can enable ECC on ram in the bios, which I did. As
> far as I know, this is non-ECC ram, so frankly I'm at a loss about

Maybe the BIOS is not properly detecting whether DRAM is ECC or not.
Normally, if it is not, it should simply remove the option to enable ECC
from the menu.

To check what the hw says, do

$ setpci -s 18.3 0x44.l

as root and send me the result pls.

> To provoke MCEs, I've added a firewire card, that I had pulled out
> before. Removing that thing had reduced the number of MCEs, but not
> eliminated them. With a regular boot sequence (no msr setting), the
> radeon driver complained of something and the system froze within 5
> minutes. I then rebooted and followed your instructions, so far the
> system is working perfectly fine.

good.

> I've also switched two eSATA on and off a few times, they are detected
> fine now with no crash, and let banshee run. That has frequently
> proven to be too much, but now it is fine.

good.

> All of this is no definite proof that all is well, but it certainly
> seems more stable.

I'd suggest you run your system at full swing and watch it for signs of
trouble a couple of days longer just in case.

> Are there any conclusions that can be drawn from this experiment ?

Yeah, it means that your BIOS doesn't seem to have the fix for erratum
#131: http://support.amd.com/us/Processor_TechDocs/25759.pdf, page 83.

I don't know whether there is BIOS for your ancient CPU :-) and if there
were, whether upgrading it won't break something else.

If I were you, I'd run the automated script hooks and don't care about
upgrade... provided we don't see any other hickups that is and provided
we manage to automate them so that you don't have to boot into recovery
console every time.

Let me know how it all plays out.

HTH.

-- 
Regards/Gruss,
Boris.

Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach
GM: Alberto Bozzo
Reg: Dornach, Landkreis Muenchen
HRB Nr. 43632 WEEE Registernr: 129 19551
