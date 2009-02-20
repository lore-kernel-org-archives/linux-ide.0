From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: no hotplugging support (FIXME)
Date: Fri, 20 Feb 2009 21:37:02 +0000
Message-ID: <20090220213702.3d33d61f@the-village.bc.nu>
References: <Pine.LNX.4.10.10301040547120.421-100000@master.linux-ide.org>
	<499F171D.5020600@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48684 "EHLO
	the-village.bc.nu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751191AbZBTVFG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Feb 2009 16:05:06 -0500
In-Reply-To: <499F171D.5020600@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Todd and Margo Chester <ToddAndMargo@verizon.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


> 1483 /* no hotplugging support (FIXME) */
> 1484 if (!in_module_init)
> 1485 return -ENODEV;

The old code does not support PIIX controller hot plug - it does support
drive plugging
