From: Doug McLain <nostar@comcast.net>
Subject: Re: sata_sil data corruption
Date: Mon, 21 Feb 2005 11:47:48 +0000
Message-ID: <4219CA64.8020402@comcast.net>
References: <Pine.LNX.4.58.0412281319001.5054@rainstorm.org> <421778E4.8060705@pobox.com> <Pine.LNX.4.58.0502211219250.23186@rainstorm.org> <4219A3AD.1000002@comcast.net> <421A0990.7070506@pobox.com> <4219C543.8030903@comcast.net> <20050221162923.GA29621@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:31177 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262035AbVBUQrF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Feb 2005 11:47:05 -0500
In-Reply-To: <20050221162923.GA29621@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: PALFFY Daniel <dpalffy-lists@rainstorm.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
Been there done that, all on this list actually.  Bios upgrade, bios 
reset, new cable, different drive, correct functionality in windows, and 
now the drive and cable ahave found their home in my other PC, a kt600 
board using the sata_via driver, where it works flawlessly.  I'm not 
even interested in using the sata interface on this machine anymore, but 
I still try to make an effort whenever possible to contribute byt 
reporting bugs.  So many people with so many different hardware 
combinations, sometimes it takes the right combination of 
hardware/software to reveal a bug.  That being said, if you want to 
investigate further, I can provide any information you want. If you want 
to ignore it, thats fine too.  Evidence strongly leans towards a driver 
bug though.

I also noticed that I get oops now sometimes even with no drive 
attatched at all

What is a blacklist entry?  A combination of drive/controller that is 
determined to be incompatable together? I would assume for a drive to 
make it to a blacklists it would have to be incompatable regardless of 
OS right?  The drive in question is a WD2000JD

Doug
> 
> In this case, the bug _reports_ are hard to find.
> 
> Each case with sata_sil is either solved with a BIOS update, a
> blacklist entry, or new cables.  Just read through bugzilla.kernel.org.
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
http://nostar.net/
