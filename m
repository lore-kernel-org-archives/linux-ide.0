From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] HPA support: Revised patch
Date: Thu, 5 Apr 2007 09:25:20 -0700
Message-ID: <20070405092520.9bad0c45.randy.dunlap@oracle.com>
References: <20070405141352.12fddb6e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:39153 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbXDEQYk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Apr 2007 12:24:40 -0400
In-Reply-To: <20070405141352.12fddb6e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kyle@canonical.com

On Thu, 5 Apr 2007 14:13:52 +0100 Alan Cox wrote:

> This one should fix the problems with slave devices and the Macintosh hang

s/Performa/Perform/g

> +/**
> + *	ata_read_native_max_address_ext	-	LBA48 native max query
> + *	@dev: Device to query
> + *
> + *	Performa an LBA48 size query upon the device in question. Return the
> + *	actual LBA48 size or zero if the command fails.
> + */
> +
> +static u64 ata_read_native_max_address_ext(struct ata_device *dev)
> +{
> +}
> +
> +/**
> + *	ata_read_native_max_address	-	LBA28 native max query
> + *	@dev: Device to query
> + *
> + *	Performa an LBA28 size query upon the device in question. Return the
> + *	actual LBA28 size or zero if the command fails.
> + */
> +
> +static u64 ata_read_native_max_address(struct ata_device *dev)
> +{
> +}


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
