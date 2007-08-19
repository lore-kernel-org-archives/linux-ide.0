From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA hotplug
Date: Sun, 19 Aug 2007 18:06:11 +0100
Message-ID: <20070819180611.7b83e476@the-village.bc.nu>
References: <540684.20873.qm@web57912.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35987 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754152AbXHSQ6I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Aug 2007 12:58:08 -0400
In-Reply-To: <540684.20873.qm@web57912.mail.re3.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Wakeman <prwakeman@yahoo.com>
Cc: linux-ide@vger.kernel.org

On Fri, 17 Aug 2007 08:56:35 -0700 (PDT)
Paul Wakeman <prwakeman@yahoo.com> wrote:

> Does libata support PATA hotplug?
> 
> I have a PCMCIA CF using TrueIDE mode and want to be able to hotplug CF
> cards. Would I get hotplug for free if I convert the existing IDE
> driver to a libata pata platform driver?

If your hardware supports PATA hotplug (most doesn't) then you can tell
the kernel to remove the device, pull it, add a new one and tell the
kernel to rescan (exactly as you do with any other scsi device).
Autodetect support right now is only in the SATA side and afaik no PATA
controller supports PATA hot plug autodetect.

