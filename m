From: Erik Rull <erik.rull@rdsoftware.de>
Subject: IRQ 15  not assigned, but still unable to use it - in MSDOS it works
Date: Wed, 16 Jun 2010 13:30:19 +0200
Message-ID: <4C18B5CB.4060707@rdsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51559 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858Ab0FPLaV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2010 07:30:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

I've worked a lot on bringing the IRQ 15 to work for my embedded system but 
it still fails.

My kernel is the 2.6.29.4 - I've already updated from 2.6.23.3 because 
there were some bugs in some ata drivers.
My system is a embedded system with Intel ATOM CPU and Intel 965 chipset.
I need to access some very old ISA-Bus boards. Before I used a Pentium-M 
Board that worked perfect.
The new board seems to have problems disabling the IRQ 15 in linux. BIOS 
has IRQ 15 reserved for legacy hardware and the IDE port behind it is 
disabled - so IRQ15 should be really free.
The 2.6.23.3 found an IDE device and said afterwards that it is disabled 
but kept the resources assigned without releasing them - so I was not able 
to use the IRQ15 with my own software.
With the 2.6.29.4 I don't get this any longer but the IRQ15 doesn't work 
either. Other interrupts are fine (5 or 10) but they are already used by 
other hardware components.
Now the interesting part: in MSDOS I'm able to see the IRQ15 from the ISA 
board as a source....

So I think that linux somewhere takes the IRQ15 and does not allow me to 
use it - and IRQ sharing seems not to be possible in this case.

I need some ideas where to continue my search - I think that it is 
somewhere in the libata that blocks this interrupt. /proc/interrupts shows 
up no interrupt neither that #15 is used.

Any ideas?

If you need more information please let me know.

Thanks a lot!

Best regards,

Erik
