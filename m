From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: libata/sata_sil24 cache alignment problem?
Date: Tue, 12 Feb 2008 20:32:55 -0600
Message-ID: <1202869975.3137.186.camel@localhost.localdomain>
References: <20080212180254.GA28237@postdiluvian.org>
	 <20080212221257.12eeab13@core>
	 <1202859388.3137.164.camel@localhost.localdomain>
	 <20080213021338.6946650e@core>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:34757 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754268AbYBMCdA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 21:33:00 -0500
In-Reply-To: <20080213021338.6946650e@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Mason <mason@postdiluvian.org>, linux-ide@vger.kernel.org, jgarzik@pobox.com


On Wed, 2008-02-13 at 02:13 +0000, Alan Cox wrote:
> > I tell you what ... find me a parisc box that actually has IDE and we
> > might have told you ...
> 
> The NS87415 variant IDE has been tested on parisc and didn't blow up -
> must just be lucky.

Actually, it's only a specific class of machines: the PCX (that's most
of the 715,725 series) that are fully incoherent.  PCXL hack around this
by making the page uncacheable and the 64 bit machines have coherence
index handling which fixes this up (mostly).

> > (actually, the pa8800's have IDE CD's on a cmd640 chip, but that oopses
> > on boot for no reason we've tracked yet).
> 
> With libata, old IDE or both ? and what does the oops look like ?

Unfortunately, there's no oops; we get a high priority machine check
which means something has gone wrong somewhere and it's not pretty.
It's on my todo list to track down ... I just don't have one of these
boxes and CDs are hard to play with remotely.

James


