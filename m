From: Jeff Garzik <jgarzik@pobox.com>
Subject: Happy New Year, libata hackers
Date: Tue, 03 Jan 2006 12:50:47 -0500
Message-ID: <43BAB977.3010203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:2193 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932471AbWACRuu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2006 12:50:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>


Well, another year has passed, and somehow the duct tape that keeps our 
hard drives together has remained intact.  After a nice and refreshing 
holiday, I have a bunch of patches pending, that will probably take a 
week or two to sort through.

For 2.6.16, my main goals are getting irq-pio upstream and supporting 
iomap -- which will kill all those annoying warnings finally.  And 
probably some EH work from Tejun will go in too.  The suspend/resume 
stuff is shaping up nicely, and device hotplug work suddenly reappeared. 
  Fun for all.

Port multiplier and NCQ (queueing) support are the two other big to-do 
items on the list.

I updated the hardware status report at
	http://linux.yyz.us/sata/

and will update the software status report in a week or two.

Everybody wants to play in the same sandbox, so please be patient as we 
sort it all out.

Cheers and happy new year,

	Jeff



