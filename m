From: Lionel Bouton <Lionel.Bouton@inet6.fr>
Subject: Re: SIS5513, 80pin cable detect, and notebook
Date: Fri, 03 Jun 2005 13:19:36 +0200
Message-ID: <42A03CC8.80006@inet6.fr>
References: <1117754292.8154.20.camel@doom>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www01.ies.inet6.fr ([62.210.153.201]:6835 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S261215AbVFCLTn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Jun 2005 07:19:43 -0400
In-Reply-To: <1117754292.8154.20.camel@doom>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Maynard <maynardp@shaw.ca>
Cc: Linux-IDE <linux-ide@vger.kernel.org>

Peter Maynard wrote the following on 06/03/05 01:18 :

>Sorry to bother you, but I could not find an answer anywhere and have
>searched for days.
>
>I have a Notebook with a sis5513 [sis963 southbridge] udma133 controller
>and a Hitachi IC25N060ATMR04 HD which supports ATA6.  However, as this
>is a notebook, the HD is directly connected to the motherboard without a
>cable.
>
>Using Kernel 2.6.10 the system boots and sets HD as udma2 (confirmed in
>both dmesg and hdparm -I) because it does not detect an 80pin cable.
>
>My question is:  should the cable detect circuitry of the sis5513
>recognize the fact there is no cable and setup as 80c?
>  
>

No, there is no reliable way to do this: the same chipsets can be used
in various configurations and the driver would have to check for all
existing hardware configurations which support reliable transfers even
if the controller<->drive interface isn't a 80-pin one (which would
probably involve a whole new kernel framework to guess which exact model
the computer is: far too much work for probably an incomplete result
involving an ever changing huge database).
Windows drivers can (temporarily) get around that because each vendor
can package its own driver tuned for the actual hardware configuration.
I guess these configurations on Windows eventually exhibit the same
problems without any available "ideX=ata66" workaround: when you upgrade
to a new Windows version, you are eventually forced to use Windows'
bundled drivers because the vendor doesn't support your hardware on the
new shiny Windows version : udma2 mode. I'm even wondering if all
vendors actually bother to tune the base Windows drivers: many notebooks
comes with cheap 4200rpm drives that don't benefit much if at all from
udma3+ (I had such a configuration not so long ago).

>If this the correct function of the ide/sis code, what is the best
>method to change the udma mode.  I am currently using the boot up
>option:  ide0=ata66  which works (udma100 shows in dmesg and hdparm show
>change to udma5) - but this is listed as an obsolete boot command that
>is to be removed....
>
>  
>

If this option were removed and not replaced by something else, I guess
it will reappear shortly after removal due to hordes of angry notebook
users (you are far from alone in this case) arrassing the IDE maintainers...

ideX=ata66 is the way to go (at least for now).

Regards,

Lionel
