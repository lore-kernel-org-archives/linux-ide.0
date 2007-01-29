From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Sun, 28 Jan 2007 23:13:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701282310120.3611@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
 <20070127174230.GN6017@stusta.de> <20070128133344.214070@gmx.net>
 <1170051963.6454.7.camel@Homer.simpson.net>  <20070128224834.37482553.akpm@osdl.org>
 <1170054495.6521.1.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:52285 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933247AbXA2HYK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 02:24:10 -0500
In-Reply-To: <1170054495.6521.1.camel@Homer.simpson.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, rml@novell.com, ttb@tentacle.dhs.org, nickpiggin@yahoo.com.au, cijoml@volny.cz, linuxppc-dev@ozlabs.org, anton@samba.org, paulus@samba.org, livio@eecg.toronto.edu, petero2@telia.com, hch@lst.de, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org



On Mon, 29 Jan 2007, Mike Galbraith wrote:
> 
> Unfortunately, I'm git impaired.  I am rummaging as we speak though.

Ok, I'm personally heading to bed, but it rally should be as simple as

 - get the git tree in the first place
 - do

	git bisect good v2.6.19
	git bisect bad v2.6.20-rc2
	.. it will pick a point for you to try ..
	.. compile, boot, test ..

	"git bisect {good|bad}" depending on results

 - until (found)

(Of course, you should check that -rc2 really is bad to make sure. I think 
that's what Uwe reported, though. And I don't think we've done anything 
after -rc2 that could impact this, so I don't doubt it).

		Linus
