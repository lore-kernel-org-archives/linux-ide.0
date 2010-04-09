From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Fri, 9 Apr 2010 10:16:05 +0100
Message-ID: <20100409101605.50fe9e8e@lxorguk.ukuu.org.uk>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
	<20100408144525.2f3f5718@lxorguk.ukuu.org.uk>
	<4bbdde49.e302be0a.3106.0220@mx.google.com>
	<20100408145916.50dbe8de@lxorguk.ukuu.org.uk>
	<4bbde1ea.c701be0a.60ec.0270@mx.google.com>
	<20100408150920.5689564b@lxorguk.ukuu.org.uk>
	<4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
	<4BBE6CA6.1010808@gmail.com>
	<4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38829 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755971Ab0DIJLw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2010 05:11:52 -0400
In-Reply-To: <4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-14?B?ROJuaWVs?= Fraga <fragabr@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

> 	So there's no NCQ in legacy mode? But you wrote that
> regarding just the ICH chipset or all chipsets? Because I remember when
> I used the forcedeth driver there was NCQ.

NCQ requires interfaces above and beyond the "traditional" IDE interface
that most controllers used. AHCI is sort of a standard for this but there
are a few other NCQ capable devices with their own interfaces/extensions
including Nvidia (forcedeth is an ethernet driver so I assume you
actually meant the Nvidia SATA driver ?)

Alan
