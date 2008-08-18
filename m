From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Add support for Long Logical Sectors and Long
 Physical Sectors
Date: Mon, 18 Aug 2008 19:06:29 +0100
Message-ID: <20080818190629.22fd618c@lxorguk.ukuu.org.uk>
References: <1217957207-23116-1-git-send-email-matthew@wil.cx>
	<1217957207-23116-3-git-send-email-matthew@wil.cx>
	<48A8B211.8030103@pobox.com>
	<20080818181523.GG677@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46445 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751083AbYHRSYD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Aug 2008 14:24:03 -0400
In-Reply-To: <20080818181523.GG677@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Matt_Domsch@dell.com, Matthew Wilcox <willy@linux.intel.com>

> +	static const char command_sect_size[256] = {
> +		[ ATA_CMD_CFA_TRANSLATE_SECTOR ] = DEVICE,

Should be a bit array so we can do a single fast test_bit()

> +	if (size == UNKNOWN && printk_ratelimit())
> +		printk("Unknown ata cmd %d, assuming 512 byte sector size\n",
> +				command);

or two bits ;)


Rest looks ok. I'll probably send a follow up patch to make most pata
drivers return "no" to anything but 512 until we can test them with real
devices.

Alan
