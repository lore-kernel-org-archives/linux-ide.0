From: David Richards <david@industrialstrengthsolutions.com>
Subject: SiI 3112 & Seagate drivers++
Date: Sun, 13 Mar 2005 16:52:23 -0500
Message-ID: <4234B617.6010103@industrialstrengthsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from lakermmtao06.cox.net ([68.230.240.33]:37340 "EHLO
	lakermmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261472AbVCMVkj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Mar 2005 16:40:39 -0500
Received: from [192.168.1.101] (really [68.10.24.17])
          by lakermmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050313214038.KBIA21504.lakermmtao06.cox.net@[192.168.1.101]>
          for <linux-ide@vger.kernel.org>; Sun, 13 Mar 2005 16:40:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I dont think the blacklist is the correct way to fix the problem because 
I still get data corruption. On occasion. (only noticed by bit torrent)

Both the silicon image sata chip and the nforce2 network chip on my 
motherboard are unsupported, and only availible when you check 'Prompt 
for development and/or incomplete code/drivers', My soundcard is an 
Chaintech Envy24HT chip, but it isnt one of the cards listed under 
support for that chip, and has some issues. The nforce also seems to 
have issues with transfer rates.

All in all, I need to get a new sata controler card, ( a promise tx2 ?)  
a new soundcard with all the functionality i need (audiophile 24/96 or 
delta series) and a new ethernet card (dlink gbit ? )

Then I can have all of my hardware operating without having 'Prompt for 
development and/or incomplete code/drivers' enabled or what not.

This shows an important lesson to individual Linux users that want to 
know the best source for information on hardware compatiblity, that is 
looking through the kernel xconfig with 'Prompt for development and/or 
incomplete code/drivers' unchecked ;]

Ive learned my lesson and hopefully helped atleast one other person.

-David
