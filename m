From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: it821x: Add ultra_mask quirk for Vortex86SX
Date: Mon, 5 Jan 2009 17:11:04 +0000
Message-ID: <20090105171104.5db48c74@lxorguk.ukuu.org.uk>
References: <20090105165811.GF29255@jenkins.ifup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48097 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750748AbZAERK5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 12:10:57 -0500
In-Reply-To: <20090105165811.GF29255@jenkins.ifup.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brandon Philips <brandon@ifup.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, Shawn Lin <shawn@dmp.com.tw>

> +		pci_read_config_byte(dev, 0x08, &conf);
> +		if (conf == 0x11)
> +			hwif->ultra_mask = 0;

NAK

Should use dev->revision as this is already kept by the kernel. Otherwise
looks fine. pata_it821x already knows about this but not that it's only a
bug in rev 0x11 so I'll propogate that bit up.

Alan
