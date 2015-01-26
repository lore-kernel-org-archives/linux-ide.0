From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: 64 bit kernel won't mount /
Date: Mon, 26 Jan 2015 21:38:30 +0000
Message-ID: <20150126213830.3f9f38f5@lxorguk.ukuu.org.uk>
References: <201501191145.41492.gheskett@wdtv.com>
	<20150121172326.040dd702@lxorguk.ukuu.org.uk>
	<201501211421.35532.gheskett@wdtv.com>
	<20150122153458.6493d3fd@lxorguk.ukuu.org.uk>
	<54C55DA3.4050400@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:60280 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbbAZWGW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2015 17:06:22 -0500
In-Reply-To: <54C55DA3.4050400@ubuntu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: Gene Heskett <gheskett@wdtv.com>, linux-ide@vger.kernel.org

On Sun, 25 Jan 2015 16:18:27 -0500
Phillip Susi <psusi@ubuntu.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> On 01/22/2015 10:34 AM, One Thousand Gnomes wrote:
> > Unlikely. Apart from fdisk the setup is basically invisible. The
> > drive reports a block size and an offset. The firmware offset is
> > chosen so that the chassic DOS alignments in fdisk happen to just
> > fall nicely on 4K boundaries for partition starts.
> > 
> > There is nothing special the OS does to deal with ATA/SATA 4K
> > sectors.
> 
> Incorrect: the kernel bogus/synthetic "geometry" is the maximum
> allowed of 63 sectors per track, and the old dos default alignment for
> the first partition on the disk places its start at sector 63, which
> is not 4k aligned.  The special thing that partitioning tools 

I guess if you count partitioning tools as the "OS" this is true, but by
the OS I meant "system call layer and below".

Alan
