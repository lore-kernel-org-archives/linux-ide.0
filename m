From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHv2] ata: endianness annotations in pata drivers
Date: Thu, 19 Jun 2008 15:55:15 +0100
Message-ID: <20080619155515.6ccbf1fe@lxorguk.ukuu.org.uk>
References: <1213829582.2125.24.camel@brick>
	<20080618233332.GN28946@ZenIV.linux.org.uk>
	<1213834603.2125.34.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34080 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751726AbYFSPND (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jun 2008 11:13:03 -0400
In-Reply-To: <1213834603.2125.34.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>

On Wed, 18 Jun 2008 17:16:43 -0700
Harvey Harrison <harvey.harrison@gmail.com> wrote:

> drivers/ata/pata_qdi.c:142:9: warning: incorrect type in assignment (different base types)
> drivers/ata/pata_qdi.c:142:9:    expected unsigned int [unsigned] [usertype] pad
> drivers/ata/pata_qdi.c:142:9:    got restricted __le32 [usertype] <noident>
> drivers/ata/pata_qdi.c:146:15: warning: cast to restricted __le32

This driver is obsolete anyway.. all looks good

Acked-by: Alan Cox <alan@redhat.com>
