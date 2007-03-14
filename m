From: Tejun Heo <htejun@gmail.com>
Subject: Re: [3/6] 2.6.21-rc2: known regressions
Date: Wed, 14 Mar 2007 15:07:08 +0900
Message-ID: <45F7910C.6060502@gmail.com>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org> <20070305015036.GH3441@stusta.de> <45EE9E39.3010800@garzik.org> <45F20541.9090208@crans.org> <45F53B60.8020908@gmail.com> <45F69989.70702@crans.org> <45F69C02.2020206@gmail.com> <45F71003.4030003@crans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <45F71003.4030003@crans.org>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?B?TWF0aGlldSBCw6lyYXJk?= <Mathieu.Berard@crans.org>
Cc: Jeff Garzik <jeff@garzik.org>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Michal Jaegermann <michal@ellpspace.math.ualberta.ca>, Fabio Comolli <fabio.comolli@gmail.com>, Janosch Machowinski <jmachowinski@gmx.de>, Lukas Hejtmanek <xhejtman@fi.muni.cz>, Meelis Roos <mroos@linux.ee>, Olivier Mondoloni <darkcore71@yahoo.fr>, Thomas Renninger <trenn@suse.de>, Robert Moore <robert.moore@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

Mathieu B=C3=A9rard wrote:
> [   15.031823] ata1.00: taskfile_load_raw: (0x1f1-1f7): hex: 10 03 00=
 00
> 00 a0 ef

Okay, this is interesting.  This is Enable Device-Initiated Interface
Power State Transitions.  So, after this command is executed the device
will try to transit to partial/slumber SATA PHY power states at its
discretion, which is all cool and dandy in theory but depending on
controller and drive firmware can cause all sorts of problems.

The NCQ problem you're seeing probably is some side effect of device
initiated link PS.  Can't tell whether the controller or the drive's
firmware is problem without further info.  Due to blacklisting, NCQ
won't be turned on your drive in future kernels and link PS doesn't see=
m
to cause any problem no non-NCQ, so your case is taken care of here but
this leaves me a bit worried about what _GTF feeds us.

I don't think we can reliably filter out command TFs as it might even
contain vendor-specific commands but it might be better to always log
TFs executed for _GTF such that we at least know what's going on with
the drive.

Thanks.

--=20
tejun
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
