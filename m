From: Adko Branil <adkobranil@yahoo.com>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Sat, 8 Sep 2012 10:22:43 -0700 (PDT)
Message-ID: <1347124963.91847.YahooMailNeo@web124701.mail.ne1.yahoo.com>
References: <1345901771.8871.YahooMailNeo@web124706.mail.ne1.yahoo.com> <20120826130152.GA20021@liondog.tnic> <1346086872.65665.YahooMailNeo@web124704.mail.ne1.yahoo.com> <20120827215952.GA18719@liondog.tnic> <1346259574.81504.YahooMailNeo@web124706.mail.ne1.yahoo.com> <20120830095808.GB24680@liondog.tnic> <1346325007.23643.YahooMailNeo@web124706.mail.ne1.yahoo.com> <20547.48101.900727.735398@pilspetsen.it.uu.se> <1347017576.44763.YahooMailNeo@web124703.mail.ne1.yahoo.com> <20555.29361.138287.766030@pilspetsen.it.uu.se>
Reply-To: Adko Branil <adkobranil@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm28.bullet.mail.ne1.yahoo.com ([98.138.90.91]:33879 "EHLO
	nm28.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751119Ab2IHRWp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2012 13:22:45 -0400
In-Reply-To: <20555.29361.138287.766030@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Borislav Petkov <bp@alien8.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Dan Merillat <dan.merillat@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

>Please try the patch below, which implements the fix I described a

>week ago. It's for 3.6-rc4 but should work in any recent kernel.
>Without this patch one of my test machines always throws a lockdep
>warning involving pdc_sata_hardreset and pdc_interrupt during bootup,
>but with the patch the warning is gone, as expected.

>If it works for you I'll add your Tested-by: and submit it properly.

>/Mikael


I will be able to try it no sooner than next week.


Thanks !

Regards
Adko.

