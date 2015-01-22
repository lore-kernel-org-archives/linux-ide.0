From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: 64 bit kernel won't mount /
Date: Thu, 22 Jan 2015 15:34:58 +0000
Message-ID: <20150122153458.6493d3fd@lxorguk.ukuu.org.uk>
References: <201501191145.41492.gheskett@wdtv.com>
	<20150121172326.040dd702@lxorguk.ukuu.org.uk>
	<201501211421.35532.gheskett@wdtv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:55300 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbbAVPfG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2015 10:35:06 -0500
In-Reply-To: <201501211421.35532.gheskett@wdtv.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gheskett@wdtv.com>
Cc: linux-ide@vger.kernel.org

> I am convinced ATM that this boot stall is an artifact of the fact that 
> none of the linux installers used, knows a thing about 4k/sector disks, 
> and that somehow in my configuring a .config, I have crippled the kernels 
> ability to deal with a miss-aligned disk partition, and none of the 
> installers is smart enough to align its partitions.  The net results of 
> course are 15M/sec write speeds on a disk that can do 120M/sec when it 
> does work. But first, it has to boot.

Unlikely. Apart from fdisk the setup is basically invisible. The drive
reports a block size and an offset. The firmware offset is chosen so that
the chassic DOS alignments in fdisk happen to just fall nicely on 4K
boundaries for partition starts.

There is nothing special the OS does to deal with ATA/SATA 4K sectors.

Alan
