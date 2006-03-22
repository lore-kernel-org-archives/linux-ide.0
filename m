From: Bryan Fink <bfink@eventmonitor.com>
Subject: Re: Gigabyte i-Ram cards
Date: Wed, 22 Mar 2006 08:22:26 -0500
Message-ID: <44214F92.1080901@eventmonitor.com>
References: <441F63E6.2090204@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rs27.luxsci.com ([66.216.127.24]:36799 "EHLO rs27.luxsci.com")
	by vger.kernel.org with ESMTP id S1751225AbWCVNWi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2006 08:22:38 -0500
In-Reply-To: <441F63E6.2090204@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:

> I'm impressed.  I ordered one to help debug BZ#6163, but I think these 
> cards will help expose bugs in libata due to their high speed.  With 
> these cards, we can push more data through libata than would normally 
> be possible with a standard disk drive.


Hi.  I tried to respond on this topic about a week ago, but I haven't 
seen my response show up on any of the mirrors, so I think it must have 
not made it through.

Anyway, I just wanted to add that I am also fiddling with the Gigabyte 
i-Ram.  I haven't tried modifying and recompiling the kernel yet, but I 
did have some success another way:

My desktop is a Dell Dimension 5150.  In the BIOS, I can set the "SATA 
Operation" to either "SATA" or "RAID".  If I set it to RAID, linux will 
see the i-RAM just fine (under Ubuntu 5.10 Live CD).  It loads ahci, and 
just takes off.  If I have the setting on SATA, then linux does not load 
ahci, and does not talk to the i-RAM.

Of note is also the fact that Windows has no issue with talking to the 
i-RAM when my system is in SATA-mode.

So, I guess the question is, are Windows and my BIOS ignoring this 
"invalid" feature query reply, or are the prodding the card in some way 
other than how linux does, which makes the card respond properly?

Good luck to those who are working on this problem, and please let me 
know if there is any way I can help.

-Bryan

