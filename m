From: Russell King <rmk+pcmcia@arm.linux.org.uk>
Subject: Re: [PATCH 1/8] pcmcia: Add an id to ide-cs.c
Date: Mon, 20 Nov 2006 09:53:49 +0000
Message-ID: <20061120095349.GA15410@flint.arm.linux.org.uk>
References: <20061119163427.GA2924@dominikbrodowski.de> <20061119163851.GB2924@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:14600 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S934039AbWKTJxz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Nov 2006 04:53:55 -0500
Content-Disposition: inline
In-Reply-To: <20061119163851.GB2924@dominikbrodowski.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On Sun, Nov 19, 2006 at 11:38:51AM -0500, Dominik Brodowski wrote:
> 
> From: Matt Reimer <mattjreimer@gmail.com>
> Date: Thu, 26 Oct 2006 15:56:00 -0700
> Subject: [PATCH] pcmcia: Add an id to ide-cs.c
> 
> Add an ID entry for:
> 
> product info: "TRANSCEND", "TS1GCF80", "", ""
> manfid: 0x000a, 0x0000
> function: 4 (fixed disk)

Erm, silly question: isn't this supposed to be matched by the following:

static struct pcmcia_device_id ide_ids[] = {
        PCMCIA_DEVICE_FUNC_ID(4),

or are we going to be ignoring the function ID and only matching using
the manfid and product info strings?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
