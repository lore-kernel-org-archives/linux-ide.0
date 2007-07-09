From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: CHRP PCI fixup for Pegasos IDE (looking for testers)
Date: Mon, 09 Jul 2007 17:45:01 +0100
Message-ID: <4692660D.3050807@genesi-usa.com>
References: <46924C27.8020100@genesi-usa.com>	<20070709160656.2666ef61@the-village.bc.nu>	<46925CBC.1020100@genesi-usa.com> <20070709174325.7cb19968@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:1271 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761730AbXGIQoK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 12:44:10 -0400
In-Reply-To: <20070709174325.7cb19968@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Fixed the define thing.

As a corollary to the patch it might be a good idea to fix the
arch/powerpc/kernel/prom_init.c at line ~2084 and remove the
interrupt 15 reference

		prop[0] = 14;
		prop[1] = 0x0;
-		prop[0] = 15;
-		prop[1] = 0x0;
-		prom_setprop(ph, name, "interrupts", prop, 4*sizeof(u32));
+		prom_setprop(ph, name, "interrupts", prop, 2*sizeof(u32));
	}
}

Since nobody uses the device tree for anything here, I think
it's merely cosmetic, though.

I'll see what I can do about getting this fix into the firmware
as and if the via86cxxx driver works with it (I have my doubts but
am willing to be pleasantly surprised)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Alan Cox wrote:
>> I don't understand what you mean by the ifdef being wrong. I don't
>> see how else I can make any kind of check for it. If the fix needs
> 
> if defined(CONFIG_FOO) || defined(CONFIG_FOO_MODULE)
> 
>> The viaide->irq check is just me being careful. I know for a fact the
>> only way the Pegasos is set up on every firmware revision is that
>> the PCI interrupt line for the IDE controller is set to 14. If it's
> 
> Cool. Thats fine then.
