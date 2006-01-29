From: Mogens Valentin <mogensv@vip.cybercity.dk>
Subject: Re: ATAPI works on via_sata, but only sort of.
Date: Sun, 29 Jan 2006 18:43:11 +0100
Message-ID: <43DCFEAF.2010900@vip.cybercity.dk>
References: <1138507667.9669.6.camel@localhost.localdomain>
Reply-To: mogensv@vip.cybercity.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cicero0.cybercity.dk ([212.242.40.52]:33510 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id S1751085AbWA2Rlg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Jan 2006 12:41:36 -0500
In-Reply-To: <1138507667.9669.6.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Gyes <floam@sh.nu>
Cc: linux-ide@vger.kernel.org

Aaron Gyes wrote:
> Hi,
> 
> I recently tried out 2.6.16-rc1-mm3 to see if my Plextor PX716-SA would
> magically come to life, it did. It had previously not worked in 2.6.15
> with the correct parameters being passed to libata. I can seem to read
> CDs okay, however every single attempt at burning a CD thus far has
> resulted in either a CD that doesn't work or a CD with CRC errors. Is
> this expected/known? Can I do anything to fix it or help diagnose the
> problem further?
> 
> My motherboard is a Asus A8V, VIA K8T800Pro.

An interesting question, since I'm just about buying a Shuttle SK21G 
with VIA K8T800CE chipset.

http://linux.yyz.us/sata/sata-status.html#via: VIA SATA production.
@Garzik: Does that mean all their chipsets, K8T800xx included?

@Aaron: I guess you use SATA disk(s), no problems?
Does the kernel boot with APIC enabled without problems? I know this has 
been a problem on at least some VIA chipsets.

-- 
Kind regards,
Mogens Valentin

