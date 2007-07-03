From: Tejun Heo <htejun@gmail.com>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Tue, 03 Jul 2007 16:33:31 +0900
Message-ID: <4689FBCB.90608@gmail.com>
References: <467C689E.3050800@genesi-usa.com>	<20070623103349.23cad9b7@the-village.bc.nu>	<467CE8FA.2040304@genesi-usa.com> <20070623105344.3ece6db1@the-village.bc.nu> <467CF1E6.8000905@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:5024 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbXGCHet (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 03:34:49 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2655610wah
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 00:34:48 -0700 (PDT)
In-Reply-To: <467CF1E6.8000905@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Matt Sealey wrote:
> I'm a litle confused here.
> 
> Page 10 (4.2.1) so I just mask off bit 0 and bit 2 of the class prog-if byte and set
> it to "compatible" mode which will basically mean PCI mapped registers and
> two IRQs? This corresponds with the table on Page 7 (4.2.1.1)..
> 
> Checked the Pegasos IDE class code and in the firmware it's set to 0x1018F so, I
> would assume the correct value is 0x1018A (knocking out the "native mode").
> 
> Okay! Great. This looks easy. Just gotta decode PCI addresses in Forth now..

I think I wrote this in the bugzilla entry but my memory is fuzzy as
always, so I'll repeat it here.  If you turn off the native bits,
libata-sff will use ATA_PRIMARY_CMD and its friends to determine IO
ports and ATA_PRIMARY_IRQ and friends to determine IRQs.  PCI BAR is
only used to determine IO ports for BMDMA register.

ie. The legacy mode means "there's no standard way to configure the damn
thing.  Just believe what the arch code says.  However, BMDMA is
introduced after PCI so let's use PCI BAR for it."  So, if you're gonna
make the controller legacy (which I think is the correct way), don't
forget to update those arch macros.

-- 
tejun
