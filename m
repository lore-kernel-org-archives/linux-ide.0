From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Thu, 8 Apr 2010 14:59:16 +0100
Message-ID: <20100408145916.50dbe8de@lxorguk.ukuu.org.uk>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
	<20100408144525.2f3f5718@lxorguk.ukuu.org.uk>
	<4bbdde49.e302be0a.3106.0220@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33838 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753880Ab0DHNzE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 09:55:04 -0400
In-Reply-To: <4bbdde49.e302be0a.3106.0220@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-14?B?ROJuaWVs?= Fraga <fragabr@gmail.com>
Cc: linux-ide@vger.kernel.org

> 	But the important thing here is: should it work with just the
> AHCI kernel support? I tested it with 2 machines and it gave me the
> same behaviour.

If you have the device name right (and if you are not using labels
remember it might change depending upon whether the pata port has disks
or not), your controller is in AHCI mode in the BIOS and your disk is on
the SATA cables then yes.

And in those cases it should always use the AHCI driver for those devices
even if the PIIX driver is also present

Alan
