From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] (2.6.20) pata_mpiix: probing cleanup (resend)
Date: Tue, 06 Feb 2007 19:53:48 -0500
Message-ID: <45C9231C.2020201@garzik.org>
References: <200702052108.55763.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57044 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933318AbXBGAxt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 19:53:49 -0500
In-Reply-To: <200702052108.55763.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Sergei Shtylyov wrote:
> [Cr*p, forgot both the sign-off and cut-off! :-)]
> 
> MPIIX has only single channel IDE which can be configured for either primary or
> secondary legacy I/O ports and IRQ.  So, get rid of the unneeded second probe
> entry in mpiix_init_one() and of the invalid (but unused anyway) enable bits in
> mpiix_pre_reset().
> 
> Warning: this cleanup has only been compile-tested...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied, on top of Tejun's probing cleanup by way of devres.

warning: this merge has only been compiled-tested... :)

	Jeff


