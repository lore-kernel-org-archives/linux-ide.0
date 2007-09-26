From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Chipset selection for NCQ md RAID
Date: Wed, 26 Sep 2007 12:03:55 +0100
Message-ID: <20070926120355.14bace0a@the-village.bc.nu>
References: <76366b180709252203t6cb790c8lc3d71b4f56670061@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57079 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751829AbXIZK56 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Sep 2007 06:57:58 -0400
In-Reply-To: <76366b180709252203t6cb790c8lc3d71b4f56670061@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-ide@vger.kernel.org

> If support for SiI chips is the most robust, would multiple
> SiI3124/SiI3132 chips be most reliable? Or is support for something

They seem to be pretty solid. We have a few bugs with multiple cards in
bugzilla mostly with Nvidia boards. I suspect a hardware issue but we
don't really 100% know.

> What about port multiplier support? Do they ever introduce stability
> problems with the drivers?

The PMP code is pretty new and it means more overhead.

> Is native libata support for high-density Areca cards planned? Does
> anyone know if the manufacturer driver is good enough to rely on for
> the above config to "just work"? I'd personally like to stay within
> libata. (Comments from any Areca Linux users with an ARC-1261ML?
> http://www.areca.com.tw/products/pcie341.htm)

I'm not sure where this got to but there was certainly some stuff going
on to try and get Areca polished and merged, but it seems to have gone
quiet of late.
