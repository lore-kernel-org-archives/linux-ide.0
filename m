From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Early ATA devices
Date: Wed, 15 Aug 2007 18:48:43 +0100
Message-ID: <20070815184843.75f10457@the-village.bc.nu>
References: <20070801014137.4ab39e94@the-village.bc.nu>
	<46B021FC.20507@gmail.com>
	<20070802214706.50c3040c@the-village.bc.nu>
	<20070815171952.GA20237@gateway.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37144 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932355AbXHORlG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 13:41:06 -0400
In-Reply-To: <20070815171952.GA20237@gateway.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Mouw <mouw@nl.linux.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, jeff@garzik.org

> FWIW, I have a Seagate ST225 (still zero bad blocks) with controller.
> If I can persuade the old 386 to do a netboot I can test it.

Right now it'll fail on the identify (may fail earlier on the reset
signature test actually).

Alan

