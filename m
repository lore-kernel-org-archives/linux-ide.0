From: Jeff Garzik <jeff@garzik.org>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Tue, 03 Jul 2007 11:08:03 -0400
Message-ID: <468A6653.8080000@garzik.org>
References: <467C689E.3050800@genesi-usa.com>	<20070623103349.23cad9b7@the-village.bc.nu>	<467CE8FA.2040304@genesi-usa.com>	<20070623105344.3ece6db1@the-village.bc.nu>	<467CF1E6.8000905@genesi-usa.com>	<4689FBCB.90608@gmail.com>	<468A04A0.1020003@genesi-usa.com>	<20070703131736.5ddc0b89@the-village.bc.nu>	<468A41CC.6030203@genesi-usa.com> <20070703143809.5064fa35@the-village.bc.nu> <468A5223.4050906@genesi-usa.com> <468A54D6.6020703@garzik.org> <468A5692.9060702@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60873 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754363AbXGCPIG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 11:08:06 -0400
In-Reply-To: <468A5692.9060702@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Matt Sealey wrote:
> Yes but the libata driver doesn't check the config register, it checks
> the class code, no?

Talking about the end result...


