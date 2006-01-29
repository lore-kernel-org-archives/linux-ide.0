From: Aaron Gyes <floam@sh.nu>
Subject: Re: ATAPI works on via_sata, but only sort of.
Date: Sun, 29 Jan 2006 11:41:54 -0800
Message-ID: <1138563714.7059.2.camel@localhost.localdomain>
References: <1138507667.9669.6.camel@localhost.localdomain>
	 <43DCFEAF.2010900@vip.cybercity.dk>  <43DD070C.7010205@vip.cybercity.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.mcdownloads.com ([216.239.132.98]:37027 "EHLO
	mail.3gstech.com") by vger.kernel.org with ESMTP id S1751130AbWA2Tlz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Jan 2006 14:41:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.3gstech.com (Postfix) with ESMTP id 9C52284DC53
	for <linux-ide@vger.kernel.org>; Sun, 29 Jan 2006 11:41:54 -0800 (PST)
Received: from mail.3gstech.com ([216.239.132.98])
 by localhost (fungus [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22003-03 for <linux-ide@vger.kernel.org>;
 Sun, 29 Jan 2006 11:41:54 -0800 (PST)
Received: from [192.168.1.103] (c-24-20-99-84.hsd1.wa.comcast.net [24.20.99.84])
	by mail.3gstech.com (Postfix) with ESMTP id 40BC3847261
	for <linux-ide@vger.kernel.org>; Sun, 29 Jan 2006 11:41:54 -0800 (PST)
In-Reply-To: <43DD070C.7010205@vip.cybercity.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sun, 2006-01-29 at 18:43 +0100, Mogens Valentin wrote:
> @Aaron: I guess you use SATA disk(s), no problems?
Yeah, hard drives are no issue. I've been using this WD Raptor for quite
some time, never an issue.

> Does the kernel boot with APIC enabled without problems? I know this
has 
> been a problem on at least some VIA chipsets.
APIC is enabled in my BIOS and menuconfig, seems to work.


Aaron Gyes

