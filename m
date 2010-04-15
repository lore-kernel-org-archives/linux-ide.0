From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: pass IRQ flags to the IDE core
Date: Thu, 15 Apr 2010 12:07:48 +0100
Message-ID: <20100415120748.12b2ef62@lxorguk.ukuu.org.uk>
References: <q2rf69abfc31004080726scbf96429ub4d84a318835d53d@mail.gmail.com>
	<20100415.021612.213438899.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55160 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751686Ab0DOLD1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Apr 2010 07:03:27 -0400
In-Reply-To: <20100415.021612.213438899.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: yegorslists@googlemail.com, linux-ide@vger.kernel.org

On Thu, 15 Apr 2010 02:16:12 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Yegor Yefremov <yegorslists@googlemail.com>
> Date: Thu, 8 Apr 2010 16:26:29 +0200
> 
> > IDE: pass IRQ flags to the IDE core
> > 
> > This enables shared IRQs and other features to be used with platform devices
> > 
> > Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> 
> If you need this for a new device, please use the ATA layer
> instead of adding support for new features in IDE which is
> in deep maintainence mode only.

Actually Dave I think that one should go in. pata_platform (libata) and
ide_platform both match the same platform objects so you can flip between
them easily (eg for testing work). The fact the IRQ flags are only
honoured in libata but not in the matching IDE driver is probably a good
thing to fix.

Alan
