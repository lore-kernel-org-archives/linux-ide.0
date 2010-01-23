From: infernix <infernix@infernix.net>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Sat, 23 Jan 2010 14:14:13 +0100
Message-ID: <4B5AF625.2000501@infernix.net>
References: <4B591D61.8030003@infernix.net> <4B593128.1040104@gmail.com>	 <4B59A0CD.4000801@infernix.net> <4B5A4F7A.4040709@gmail.com>	 <4B5A5F09.1070300@infernix.net> <51f3faa71001222318k573d95e6h422b2cd3276e61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dx.infernix.net ([83.96.151.193]:55495 "EHLO dx.infernix.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755216Ab0AWNOP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Jan 2010 08:14:15 -0500
In-Reply-To: <51f3faa71001222318k573d95e6h422b2cd3276e61@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On 23/01/10 08:18, Robert Hancock wrote:
> Since the chipset does have open documentation, one might be able to
> develop a PCI quirk that would re-enable the disabled IDE interface so
> that ata_piix can access it. That would likely be the best option,
> albeit still rather ugly and highly system-specific..

Sounds difficult. Are there any other drivers that do something like 
this? I can try to poke around with it but I'm stepping into the unknown 
here.

Other options would be donating one to a willing developer. Any takers? 
They aren't very expensive fortunately :)
