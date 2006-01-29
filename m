From: Mogens Valentin <mogensv@vip.cybercity.dk>
Subject: Re: ATAPI works on via_sata, but only sort of.
Date: Sun, 29 Jan 2006 22:20:52 +0100
Message-ID: <43DD31B4.9000806@vip.cybercity.dk>
References: <1138507667.9669.6.camel@localhost.localdomain>	 <43DCFEAF.2010900@vip.cybercity.dk>  <43DD070C.7010205@vip.cybercity.dk> <1138563714.7059.2.camel@localhost.localdomain>
Reply-To: mogensv@vip.cybercity.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cicero0.cybercity.dk ([212.242.40.52]:26070 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id S1751162AbWA2VTS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Jan 2006 16:19:18 -0500
In-Reply-To: <1138563714.7059.2.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Gyes <floam@sh.nu>
Cc: linux-ide@vger.kernel.org

Aaron Gyes wrote:
> On Sun, 2006-01-29 at 18:43 +0100, Mogens Valentin wrote:
> 
>>@Aaron: I guess you use SATA disk(s), no problems?
> 
> Yeah, hard drives are no issue. I've been using this WD Raptor for quite
> some time, never an issue.

That's not a SATA-2 disk, right?
I'd really like to know if the chipset has issues with SATA-2.

>>Does the kernel boot with APIC enabled without problems? I know this
>>has been a problem on at least some VIA chipsets.
> 
> APIC is enabled in my BIOS and menuconfig, seems to work.

You would've noticed if it hadn't ;)
Thanks for easing my mind so far.

-- 
Kind regards,
Mogens Valentin

