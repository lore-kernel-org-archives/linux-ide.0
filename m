From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] libata updates for 3.3
Date: Mon, 16 Jan 2012 23:54:27 +0000
Message-ID: <20120116235427.168e13f2@pyramind.ukuu.org.uk>
References: <20120109003255.GA6598@havoc.gtf.org>
	<CA+55aFwcBQSoWfqdT9CxV=GAr5ex0=RnqtBDFty+=_Lua2VXGw@mail.gmail.com>
	<4F12E57E.3090805@garzik.org>
	<1326676534.13517.3.camel@minggr>
	<1326691403.13517.21.camel@minggr>
	<CA+55aFzqECJjbtgyOXy_H1smh09SsfgrAuVY7hK2sC-xj1GZHg@mail.gmail.com>
	<20120116194211.2cd09fb3@pyramind.ukuu.org.uk>
	<CA+55aFxNcAtCmzEejS=3+_L_rp-MOBS0yLS061YgiCsFw_Mt5Q@mail.gmail.com>
	<20120116195427.64edd96f@pyramind.ukuu.org.uk>
	<CA+55aFzXFyHTUv=8NtSmXA2UY_qO5P=HXdGnhUmF9YoA5vpX1g@mail.gmail.com>
	<CA+55aFxUyBvkAhQZFKDuiJrMx9sR2Nb3s5F3P8wDLa4eNspJ1Q@mail.gmail.com>
	<4F14881C.8040601@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:45930 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab2APXx3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2012 18:53:29 -0500
In-Reply-To: <4F14881C.8040601@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Lin Ming <ming.m.lin@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

> Part of the problem with force-enable is that the MMIO BAR may need a 
> value, and not have it.  That, and an expectations mismatch between BIOS 

That's fine - we can happily assign one at boot time.

Alan
