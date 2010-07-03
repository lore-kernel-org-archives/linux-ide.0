From: Hans Mueller <hans42mueller@googlemail.com>
Subject: Re: [Bug 16142] r8169: Kernel Panic when a lot of data is
 transferred through network interface
Date: Sat, 3 Jul 2010 09:49:18 +0200
Message-ID: <20100703094918.03007437@cbook.fritz.box>
References: <20100617080726.GA13713@liondog.tnic>
	<20100617150008.16a5e653@cpc>
	<20100618074510.GD32368@liondog.tnic>
	<20100619005045.2173fcce@cpc>
	<20100619100511.GA31429@liondog.tnic>
	<20100619132708.030fe408@cpc>
	<20100623080200.GB5010@liondog.tnic>
	<20100625185846.72171be0@cpc>
	<20100630065426.GA1857@liondog.tnic>
	<20100630200254.45ab84d1@cpc>
	<20100630183138.GA11036@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62135 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661Ab0GCHpU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Jul 2010 03:45:20 -0400
Received: by bwz1 with SMTP id 1so1931161bwz.19
        for <linux-ide@vger.kernel.org>; Sat, 03 Jul 2010 00:45:18 -0700 (PDT)
In-Reply-To: <20100630183138.GA11036@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

Hi, 

On Wed, 30 Jun 2010 20:31:38 +0200
Borislav Petkov <bp@alien8.de> wrote:
> Alternatively, if you have a spare PCI NIC, you can insert it into one
> of the PCI slots after having disabled the onboard NIC in the BIOS. Just
> for testing purposes, to see whether "unsharing" the IRQ line fixes the
> issue.

I have currently no access to the computer, I will be able to test
things again on monday.
But as I wrote in my original bugreport, I tested with a PCI NIC. (But
the onboard NIC was not completely disabled, it was only disabled via
ifconfig ... down)
When using the PCI NIC, the whole problem (kernel panik) did not occure.


--
Regards Jonas
