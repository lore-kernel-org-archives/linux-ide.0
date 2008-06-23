From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_svw data corruption, strange problems
Date: Mon, 23 Jun 2008 10:42:21 +0100
Message-ID: <20080623104221.3b4fb350@lxorguk.ukuu.org.uk>
References: <20080617093602.GA28140@elf.ucw.cz>
	<485EF061.3010601@kernel.org>
	<20080623082055.GB1850@elf.ucw.cz>
	<je63s0sfxv.fsf@sykes.suse.de>
	<20080623085338.GE1850@elf.ucw.cz>
	<485F6540.6000907@kernel.org>
	<20080623090130.GF1850@elf.ucw.cz>
	<1214211859.8011.250.camel@pasglop>
	<485F7184.1030907@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50698 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753504AbYFWKAM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2008 06:00:12 -0400
In-Reply-To: <485F7184.1030907@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: benh@kernel.crashing.org, Pavel Machek <pavel@suse.cz>, Andreas Schwab <schwab@suse.de>, kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Trivial patch monkey <trivial@kernel.org>

> > BTW. Tejun, I suppose that usually starting DMA after issuing the
> > command is a standard practice of legacy/sff type controllers ? Or it's
> > just because that's how linux did it until now ?
> 
> It's how the standard says it should be programmed.  Please take a look
> at section 3 of the following document.
> 
> http://www.centrillium-it.com/Projects/idems100.pdf
> 
> It's a non-issue for PATA ones as the host is responsible for running

It's very much an issue for PATA. If you start the DMA before time things
go wrong. The DMA has to start after the command is issued (or for ATAPI
after the command and the cdb are issued). Various ATAPI devices get
quite cross if you mess this up.

In some cases the driver code also depends upon this as we software drive
the data clocks so have to reprogram them after command issue and before
data transfer begins.
