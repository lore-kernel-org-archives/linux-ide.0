From: Olaf Hering <olaf@aepfle.de>
Subject: Re: adding Pegasus IDE quirk for pata_via
Date: Thu, 16 Aug 2007 19:00:32 +0200
Message-ID: <20070816170032.GA26962@aepfle.de>
References: <20070404111635.GA1855@aepfle.de> <461A3C10.3050104@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:47927 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbXHPRA0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Aug 2007 13:00:26 -0400
Content-Disposition: inline
In-Reply-To: <461A3C10.3050104@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Mon, Apr 09, Matt Sealey wrote:

> +				if (bridge) {
> +					u8 iir, irqlist[4] = { 14, 15, 10, 
> 11 };
> +
> +					pci_read_config_byte(bridge, 
> VIA_IDE_STEERING, &iir);

What value has VIA_IDE_STEERING?
Googles only reference is your own posting.
