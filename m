From: Gene Heskett <gheskett@wdtv.com>
Subject: Re: 64 bit kernel won't mount /
Date: Fri, 23 Jan 2015 00:06:36 -0500
Message-ID: <201501230006.36907.gheskett@wdtv.com>
References: <201501191145.41492.gheskett@wdtv.com> <201501211421.35532.gheskett@wdtv.com> <20150122153458.6493d3fd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.wdtv.com ([66.118.69.84]:45743 "EHLO mail.wdtv.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314AbbAWFGj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jan 2015 00:06:39 -0500
In-Reply-To: <20150122153458.6493d3fd@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Thursday 22 January 2015 10:34:58 One Thousand Gnomes did opine
And Gene did reply:
> > I am convinced ATM that this boot stall is an artifact of the fact
> > that none of the linux installers used, knows a thing about
> > 4k/sector disks, and that somehow in my configuring a .config, I
> > have crippled the kernels ability to deal with a miss-aligned disk
> > partition, and none of the installers is smart enough to align its
> > partitions.  The net results of course are 15M/sec write speeds on a
> > disk that can do 120M/sec when it does work. But first, it has to
> > boot.
> 
> Unlikely. Apart from fdisk the setup is basically invisible. The drive
> reports a block size and an offset. The firmware offset is chosen so
> that the chassic DOS alignments in fdisk happen to just fall nicely on
> 4K boundaries for partition starts.
> 
> There is nothing special the OS does to deal with ATA/SATA 4K sectors.
> 
> Alan

Good to know Alan, thanks. I'll turn my flashlight in a different 
direction then.

Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
US V Castleman, SCOTUS, Mar 2014 is grounds for Impeaching SCOTUS
