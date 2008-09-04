From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG?] pata_marvell doesn't see ide on asus-p5q-pro m/b.
Date: Thu, 4 Sep 2008 12:16:57 +0100
Message-ID: <20080904121657.4f04ec9c@lxorguk.ukuu.org.uk>
References: <vIHEILms.1220518770.4586010.pluto@agmk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38355 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752237AbYIDLRN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Sep 2008 07:17:13 -0400
In-Reply-To: <vIHEILms.1220518770.4586010.pluto@agmk.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>
Cc: linux-ide@vger.kernel.org

> to the ide slot. the marvell bios detects dvd correctlly,
> so it looks like a bug in pata_marvell module.

It's a bug in the AHCI driver which means it takes stuff the pata_marvell
module needs. I'm hoping this will finally get fixed

> i'm using the 2.6.25.16 modularized kernel.
> i can provide more info for debugging purposes if you want.

Remove the marvell pci ids from drivers/ata/ahci.c
