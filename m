From: "Christensen Tom" <paveraware@hotmail.com>
Subject: Adaptec Hercules 2 (Marvell AIC-8130) SATA chipset support
Date: Wed, 02 Feb 2005 03:39:47 +0000
Message-ID: <BAY21-F2602989D03802536F52405DF7E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Received: from bay21-f26.bay21.hotmail.com ([65.54.233.115]:27233 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262256AbVBBDko
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Feb 2005 22:40:44 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a server with the above SATA chipset, it has 4 SATA ports, and of 
course I can't get linux to recognize it.  I believe from a conversation 
with Supermicro (the makers of the motherboard) that it is one of the 
Marvell SATA chipsets most likely 88SX6041.  However, Adaptec wrote their 
own firmware and rereleased it as the AIC-8130...

They released a binary driver but it only works in 2.4 kernels, and then 
only in a couple vendor specific kernels that have exploits and shouldn't be 
used.  Any chance that the Marvell driver that is being worked on will work 
with this chipset/firmware?

If it's possible that the 88SX6041 driver might work, or if it might be like 
the AAR1200 series adaptec cards that are based on the Silicon Image 
chipset, but needed a patch to get working I would be more than happy to 
test and even try to do some dev work on it.

Thanks,
Tom Christensen


