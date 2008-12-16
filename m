From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 1/3] pata_hpt366: fix cable detection,
Date: Tue, 16 Dec 2008 05:41:04 -0500
Message-ID: <494785C0.4030106@garzik.org>
References: <493E289F.1010000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45974 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbYLPKlJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Dec 2008 05:41:09 -0500
In-Reply-To: <493E289F.1010000@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

Tejun Heo wrote:
> pata_hpt366 is strange in that its two channels occupy two PCI
> functions and both are primary channels and bit1 of PCI configuration
> register 0x5A indicates cable for both channels.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> ---
>  drivers/ata/pata_hpt366.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

applied 1-2 of 3 (the last looked risky for -rc?)


