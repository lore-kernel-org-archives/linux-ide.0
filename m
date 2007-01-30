From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Tue, 30 Jan 2007 04:25:22 +0100
Message-ID: <1170127522.6741.6.camel@Homer.simpson.net>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	 <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
	 <1170051963.6454.7.camel@Homer.simpson.net>
	 <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
	 <45BE5AF0.3030005@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:59035 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752108AbXA3DZa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 22:25:30 -0500
In-Reply-To: <45BE5AF0.3030005@cs.wisc.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>

On Mon, 2007-01-29 at 14:37 -0600, Mike Christie wrote:
> Linus Torvalds wrote:
> >>
> >> [ 4362.972995] hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> >> [ 4362.981475] ide: failed opcode was: unknown
> >> [ 4362.986183] hdd: drive not ready for command
> > 
> 
> What chipsets are you guys using?

ICH5 here.

