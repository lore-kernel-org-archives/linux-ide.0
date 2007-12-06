From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: a question about interrupt of IDE controller( bug 5637)
Date: Thu, 6 Dec 2007 02:32:56 +0000
Message-ID: <20071206023256.0f623ab2@the-village.bc.nu>
References: <1196738884.4012.55.camel@yakui_zhao.sh.intel.com>
	<20071204123828.09fc2648@the-village.bc.nu>
	<1196832826.10467.15.camel@yakui_zhao.sh.intel.com>
	<20071205141809.615d1f59@the-village.bc.nu>
	<1196904616.29019.12.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33929 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751907AbXLFChl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 21:37:41 -0500
In-Reply-To: <1196904616.29019.12.camel@yakui_zhao.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-ide@vger.kernel.org, len.brown@intel.com, shaohua.li@intel.com, rui.zhang@intel.com

> The above patch can fix the issue in Bug5637. But if IDE controller
> works in legcay mode and PRT tells us the interrupt for some PCI devices
> is 14/15, should we make it pci-like interrupt(level trigger, low
> active)? 

If that occurs the BIOS is broken.

Alan
