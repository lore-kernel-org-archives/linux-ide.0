From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Intel RAID in the X79 chipset
Date: Tue, 17 Jun 2014 13:53:19 +0100
Message-ID: <20140617135319.54981ef7@alan.etchedpixels.co.uk>
References: <539EAA36.9050701@jrcs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:39945 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755755AbaFQMxv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2014 08:53:51 -0400
In-Reply-To: <539EAA36.9050701@jrcs.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Stevens <james@jrcs.net>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On Mon, 16 Jun 2014 09:26:30 +0100
James Stevens <james@jrcs.net> wrote:

> Hi
> 
> I have an ASUS P9X79 mainboard which has the Intel x79 chipset with a 
> built-in RAID controller.

It's got disk controllers - the RAID is a property of the windows driver.

> As of "linux-3.15", I also see it is not mentioned in the 
> "drivers/ata/ahci.c" file.

AHCI is a class based driver so it will find the drives 

> When I boot Linux it never seems the RAID volume, but still tells me I 
> have three separate hard drives.

This is correct behaviour. Use the options in your distribution to set up
raid volumes.

Alan
