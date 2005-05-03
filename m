From: "Drew Winstel" <DWinstel@Miltope.com>
Subject: RE: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Date: Tue, 3 May 2005 13:29:45 -0500
Message-ID: <66F9227F7417874C8DB3CEB057727417045155@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from firewall.miltope.com ([208.12.184.221]:36372 "EHLO
	smtp.miltope.com") by vger.kernel.org with ESMTP id S261536AbVECS3P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 May 2005 14:29:15 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Oskar Liljeblad <oskar@osk.mine.nu>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Thanks, now it loads correctly. Unfortunately the clock drift still occurs
> with pata_pdc2027x. I'm guessing here, but can clock drift have anything
> to do with IRQs? Also, is it normal to see errors in /proc/interrupt?

I've never noticed any errors before, but that could just be a result of me 
never actually bothering to look.

> # cat /proc/interrupts 

<snip>
> ERR:      23672

Hmmm....

I'm grasping at straws here.

Let's do some poking into your kernel config.  What do you have set under 
"Processor type and features"?  

I experienced a similar situation once in the past, but that was a result of 
drives losing DMA and doing simultaneous activity on eight drives and four 
controllers.  Moving to the pata_pdc2027x driver seems to have cleared it 
right up.

Sorry I can't provide a quick cure-all!

Drew
