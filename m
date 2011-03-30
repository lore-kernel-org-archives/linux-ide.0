From: Daniel Palmer <me@danielpalmer.co.uk>
Subject: PATA_ARTOP reads byte from PCI IO port without mapping it to the
 right address.
Date: Wed, 30 Mar 2011 20:09:16 +0100
Message-ID: <4D937FDC.4090607@danielpalmer.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tomato.cardboardbox.org.uk ([174.143.157.65]:38080 "EHLO
	tomato.cardboardbox.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932411Ab1C3TJZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Mar 2011 15:09:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

I posted on linux-ide a few days ago about PATA_ARTOP causing an oops in 
2.6.38.
Anyhow, it seems this issue has existed for a while but something has 
changed in the SH code since 2.6.35 that exposes the problem.
Mikael Pettersson replied to my original post and said that the driver 
works on his board. I suspect his board isn't reading the byte from the 
PCI io port (different controller that doesn't enter that code path) or 
on his board it maps to the right place (or some place that doesn't 
cause an oops) without out asking for it to be mapped.

I would write a patch, but I don't understand the linux PCI stuff enough 
to know what is right.
I have something that works on my machine (or at least it doesn't oops 
anymore) but it's probably not the right solution.

Anyhow;-


unsigned long io = pci_resource_start(pdev, 4);           // This 
returns 0x1400 on my machine
                 u8 reg;

                 ppi[0] = &info_628x;
                 if (inb(io) & 0x10)                                    
         // This reads from 0x1400, which isn't were the port actually 
is in the processors address                                             
                                                      // space and thus 
an oops happens.
                         ppi[0] = &info_628x_fast;
                 /* Mac systems come up with some registers not set as we
                    will need them */


IO port mapping for the pata controller;

    0.040000] pci 0000:00:01.0: BAR 4: set to [io  0x1400-0x140f] (PCI 
address [0x1400-0x140f])
[    0.040000] pci 0000:00:01.0: BAR 0: assigned [io  0x1410-0x1417]


I guess io should be calculated with pci_iomap(pdev, 4, 0) or something? 
I don't understand how the PCI stuff works though..
Looks like the BAR is hardcoded to 4 in the existing code. I have no 
idea what a BAR is. ;)
So, that's what I have on my machine.. and I don't get an oops anymore,
pata seems to be working too. I haven't checked what value is actually 
being read. So it's possible that it's just reading somewhere that 
doesn't cause an oops and the issue isn't actually fixed.
The main issue is the use of inb I guess. I noticed that there was some 
activity to remove all uses of it in drivers some time back.

Anyhow, that seems to be the problem. If someone who isn't just guessing 
this stuff could come up with a fix that would be nice.
I can get my board to boot now anyhow. :)

Regards,

Daniel


