From: Brad Campbell <brad@wasp.net.au>
Subject: Libata VIA woes continue. Worked around
Date: Fri, 27 Aug 2004 17:58:02 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <412F3DEA.2070307@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:19127 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S265053AbUH0N52 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Aug 2004 09:57:28 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Ok, so after a couple of reboots with max_sector set to 200 the problem re-occurs.

It must be something to do with programming the controller or timing or some other issue.

I have worked around it by putting my 2 raid-0 drives on my spare promise ports, and at UDMA100 with 
transfers of 2048 sectors they behave fine no matter what I throw at them.

It seems with the VIA interface it either works first time for a big transfer or it does not, 
depending on the cold boot.

If I power cycle the machine 5 times it might work perfectly 3 out of 5 and if it works ok for the 
first couple of transfers it will work ok for the entire uptime of the machine. If not then it locks 
the interface up.

I'm going to sit on it for a few days. It's no longer an issue for me and perhaps I'll stop chasing 
it until someone else reports a similar issue with a VIA controller.

I'll see if I can jam my 2 new Maxtors in the machine on these VIA ports and give them a good 
workout. I only rebooted the machine 3 times with them connected and I might have been lucky with 3 
working reboots. (There is only so many times you want to power cycle a box that has 15 hard disks 
in it!)

Regards,
Brad (Dazed, confused and a little narked!)
