From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 08:08:15 +0100
Message-ID: <1170054495.6521.1.camel@Homer.simpson.net>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	 <20070127174230.GN6017@stusta.de> <20070128133344.214070@gmx.net>
	 <1170051963.6454.7.camel@Homer.simpson.net>
	 <20070128224834.37482553.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42161 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933245AbXA2HI1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 02:08:27 -0500
In-Reply-To: <20070128224834.37482553.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, torvalds@linux-foundation.org, rml@novell.com, ttb@tentacle.dhs.org, nickpiggin@yahoo.com.au, cijoml@volny.cz, linuxppc-dev@ozlabs.org, anton@samba.org, paulus@samba.org, livio@eecg.toronto.edu, petero2@telia.com, hch@lst.de, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org

On Sun, 2007-01-28 at 22:48 -0800, Andrew Morton wrote:
> On Mon, 29 Jan 2007 07:26:03 +0100
> Mike Galbraith <efault@gmx.de> wrote:
> 
> > FWIW, I just tried it with 2.6.20-rc6, and can confirm.  Once nero is
> > run, the kernel never gives up retrying whatever command failed, so I
> > get...
> > 
> > [ 4362.972995] hdd: status error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > [ 4362.981475] ide: failed opcode was: unknown
> > [ 4362.986183] hdd: drive not ready for command
> > 
> > endlessly.
> 
> Do you have time to bisect it?

Unfortunately, I'm git impaired.  I am rummaging as we speak though.

	-Mike

