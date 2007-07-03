From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Tue, 03 Jul 2007 15:00:50 +0100
Message-ID: <468A5692.9060702@genesi-usa.com>
References: <467C689E.3050800@genesi-usa.com>	<20070623103349.23cad9b7@the-village.bc.nu>	<467CE8FA.2040304@genesi-usa.com>	<20070623105344.3ece6db1@the-village.bc.nu>	<467CF1E6.8000905@genesi-usa.com>	<4689FBCB.90608@gmail.com>	<468A04A0.1020003@genesi-usa.com>	<20070703131736.5ddc0b89@the-village.bc.nu>	<468A41CC.6030203@genesi-usa.com> <20070703143809.5064fa35@the-village.bc.nu> <468A5223.4050906@genesi-usa.com> <468A54D6.6020703@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:3160 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756906AbXGCOAG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 10:00:06 -0400
In-Reply-To: <468A54D6.6020703@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Yes but the libata driver doesn't check the config register, it checks
the class code, no?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Jeff Garzik wrote:
> Matt Sealey wrote:
>> The old Via driver checked the host controller configuration space,
>> rather
>> than trust the PCI class code and the ATA specs, it seems?
> 
> This is just as dependent on firmware settings as trusting the PCI class
> code...  "six of one, half-dozen of the other"
> 
>     Jeff
> 
> 
