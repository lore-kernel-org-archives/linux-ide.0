From: ha haha <hahaha_30k@yahoo.com>
Subject: another question -- RE: Promise SATAII150 TX4: strange disk ordering
Date: Thu, 25 Aug 2005 20:51:01 -0700 (PDT)
Message-ID: <20050826035101.97723.qmail@web30213.mail.mud.yahoo.com>
References: <EC70EFBFB6977A478BEB386684E8A7420CE728@pwfsbs01.pwf.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web30213.mail.mud.yahoo.com ([68.142.201.226]:36192 "HELO
	web30213.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751455AbVHZDvE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Aug 2005 23:51:04 -0400
In-Reply-To: <EC70EFBFB6977A478BEB386684E8A7420CE728@pwfsbs01.pwf.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Allen Bolderoff <allen@gist.net.au>, linux-ide@vger.kernel.org
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, jgarzik@pobox.com

Allen,

  How about another Promise Fasttrack S150 TX4 SATA
card, its PCIID is 0x105a:0x3319? Does this card also
has similar problem? 

# lspci -n
...
05:09.0 Class 0104: 105a:3319 (rev 02)
...

 From my experience, the 2 SATA hard disks connected
through Promise SATA card (0x105a:0x3319) fails much
more often than another 2 SATA hard disks directly
connected to motherboard, as often as 4 times! I just
don't know why for a while.

 Please advice. Thanks a lot.



--- Allen Bolderoff <allen@gist.net.au> wrote:

> > driver" and introducing driver options to manually
> order the ports?
> > 
> > How can I ensure stable device names (/dev/sd*)?
> > 
> 
> I use LVM.
> 
> However - this card/driver is known to break when
> using more than 1
> drive at a time (ie accessing 2 or 3 drives at once)
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
