From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Add support for Long Logical Sectors and Long
 Physical Sectors
Date: Wed, 6 Aug 2008 15:13:02 +0100
Message-ID: <20080806151302.1d282747@lxorguk.ukuu.org.uk>
References: <1217957207-23116-1-git-send-email-matthew@wil.cx>
	<1217957207-23116-3-git-send-email-matthew@wil.cx>
	<20080805214651.621263f5@lxorguk.ukuu.org.uk>
	<20080806022255.GC2055@parisc-linux.org>
	<20080806100647.21529284@lxorguk.ukuu.org.uk>
	<20080806131109.GH2055@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52204 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755038AbYHFOah (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 10:30:37 -0400
In-Reply-To: <20080806131109.GH2055@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, Matt_Domsch@dell.com, Matthew Wilcox <willy@linux.intel.com>

> Obviously it is going to change per command -- because different
> commands have different sizes.  I was thinking that we could call the
> driver to see if it can handle a particular sector size right after we
> get the IDENTIFY data.  

The drivers need to know if you are going to be using odd sizes regularly
so they can pick between

	-	I do this fine who cares (most chips)
	-	Er uh wtf its not 512 byts (some chip state machines)
	-	FIFO off (performance hit) for this disk
	-	FIFO managed for the odd command thats a funny size
	-	Various other levels of software managed controller
		thumping

It's not a passive thing and we'd want to do it post identify on the
drive pair as it'll often need per channel decisions (eg on FIFO)

Alan
