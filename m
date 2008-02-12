From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: libata/sata_sil24 cache alignment problem?
Date: Tue, 12 Feb 2008 17:36:28 -0600
Message-ID: <1202859388.3137.164.camel@localhost.localdomain>
References: <20080212180254.GA28237@postdiluvian.org>
	 <20080212221257.12eeab13@core>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:59947 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752053AbYBLXgf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 18:36:35 -0500
In-Reply-To: <20080212221257.12eeab13@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Mason <mason@postdiluvian.org>, linux-ide@vger.kernel.org, jgarzik@pobox.com


On Tue, 2008-02-12 at 22:12 +0000, Alan Cox wrote:
> > Has anyone else reported a problem like this?  It requires
> > non-coherent DMA, and a lack of a cache invalidate instruction, and
> > one of the drivers that has this problem (it looks like sata_qstor
> > does too, I haven't looked at others), so maybe that doesn't cover
> > any other architectures.
> 
> Nobody has, not even PA-RISC which is normally guaranteed to make life
> miserable in the caching area but I agree entirely with your diagnosis
> and that buffer should indeed be marked cache aligned

I tell you what ... find me a parisc box that actually has IDE and we
might have told you ...

(actually, the pa8800's have IDE CD's on a cmd640 chip, but that oopses
on boot for no reason we've tracked yet).

James


