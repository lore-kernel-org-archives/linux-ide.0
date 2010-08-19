From: Tim Small <tim@seoss.co.uk>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Thu, 19 Aug 2010 12:02:13 +0100
Message-ID: <4C6D0F35.20202@seoss.co.uk>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>	<4C6AB68D.8000102@kernel.org>	<20100817174257.3691ed68@lxorguk.ukuu.org.uk>	<4C6AB919.7060203@kernel.org>	<20100817180158.179e7780@lxorguk.ukuu.org.uk>	<4C6ABFFA.2000502@kernel.org>	<20100817192353.3529733c@lxorguk.ukuu.org.uk>	<4C6B7B72.4090405@kernel.org>	<20100818110306.03ce2fbc@lxorguk.ukuu.org.uk>	<4C6BE9C8.4030803@kernel.org> <20100818161521.430ba361@lxorguk.ukuu.org.uk> <4C6CFB63.2070001@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:33748 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab0HSLCn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Aug 2010 07:02:43 -0400
In-Reply-To: <4C6CFB63.2070001@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org

Tejun Heo wrote:
> There's no way to hotplug intel IDEs
> anyway.
>   

Won't kvm (or similar virtualisation system) + PCI passthrough allow you
to hot-plug arbitrary PCI devices?  Bit of a corner-case I know, but I
can see people occasionally doing this...

Tim.
