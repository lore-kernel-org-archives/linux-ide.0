From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] pata_ali not working on a 64 bit system
Date: Fri, 6 Jul 2007 18:44:02 +0100
Message-ID: <20070706184402.16d290b7@the-village.bc.nu>
References: <20070706173605.GA6484@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43171 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761321AbXGFRhl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jul 2007 13:37:41 -0400
In-Reply-To: <20070706173605.GA6484@dreamland.darkstar.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 6 Jul 2007 19:36:05 +0200
Luca Tettamanti <kronos.it@gmail.com> wrote:

> Hello,
> I found out that pata_ali is not working with a 64 bit kernel, while a
> 32 bit kernel on the same machine works fine. I'm running a very recent
> kernel (872aad45, somewhere after 2.6.22-rc7).
> 
> The problem is that as soon as the module is loaded I get a screaming
> interrupt:

Can you report this with a full dmesg to the ACPI maintainers as that is
where the IRQ routing is presumably coming from. Are you using ACPI on
both cases ?
