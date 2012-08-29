From: Adko Branil <adkobranil@yahoo.com>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Wed, 29 Aug 2012 10:31:43 -0700 (PDT)
Message-ID: <1346261503.91611.YahooMailNeo@web124703.mail.ne1.yahoo.com>
References: <1345901771.8871.YahooMailNeo@web124706.mail.ne1.yahoo.com> <20120826130152.GA20021@liondog.tnic> <1346086872.65665.YahooMailNeo@web124704.mail.ne1.yahoo.com> <20120827215952.GA18719@liondog.tnic>
Reply-To: Adko Branil <adkobranil@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm14-vm3.bullet.mail.ne1.yahoo.com ([98.138.91.144]:46252 "HELO
	nm14-vm3.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753586Ab2H2Rbp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2012 13:31:45 -0400
In-Reply-To: <20120827215952.GA18719@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

And one more thing i forgot - during kernel compilation i noticed this:

WARNING: modpost: Found 1 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'



And when i compiled with "make CONFIG_DEBUG_SECTION_MISMATCH=y", somewhere at the end was:


WARNING: drivers/scsi/fcoe/libfcoe.o(.init.text+0x1f): Section mismatch in reference from the function libfcoe_init() to the function .exit.text:fcoe_transport_exit()
The function __init libfcoe_init() references
a function __exit fcoe_transport_exit().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __exit annotation of
fcoe_transport_exit() so it may be used outside an exit section.



It should not be related with the crash during "make modules_install", as the default slackware kernel 3.2.27 also crashes during it, but it may be important for any other things, i don't know.


Thanks !
Adko.

