From: infernix <infernix@infernix.net>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Sat, 13 Feb 2010 01:21:53 +0100
Message-ID: <4B75F0A1.4060204@infernix.net>
References: <4B591D61.8030003@infernix.net>	<4B593128.1040104@gmail.com>	<4B59A0CD.4000801@infernix.net>	<4B5A4F7A.4040709@gmail.com>	<4B5A5F09.1070300@infernix.net>	<20100123101457.7f8cbb3f@lxorguk.ukuu.org.uk>	<4B5AF4DF.4020100@infernix.net>	<20100123133831.7f24ae95@lxorguk.ukuu.org.uk>	<4B75E4B2.3070105@infernix.net> <20100213000410.5d58d619@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dx.infernix.net ([83.96.151.193]:47684 "EHLO dx.infernix.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755506Ab0BMAVn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Feb 2010 19:21:43 -0500
In-Reply-To: <20100213000410.5d58d619@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On 13/02/10 01:04, Alan Cox wrote:
> Beyond that I've dug into it with another owner of the same board - the
> BIOS has hidden the device. Unfortunately the documentation for the
> chipset is quite explicit that while you can hide devices you cannot then
> unhide them again.
>
> It might be possible to do something by booting the system in compatible
> mode and beating the controller into AHCI + PATA mode but really what is
> needed is a BIOS fix.

That BIOS update will never happen, because the device was declared EOL 
by Intel in January.

So if it's a beating that's needed, I'm happy to give it, just point it 
out :) Otherwise I guess it's a lost cause, and I'd probably be better 
off by just plugging a USB stick in an internal USB port than to use the 
PATA port.
