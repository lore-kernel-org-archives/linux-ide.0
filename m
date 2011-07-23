From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream] ahci: start engine only during soft/hard resets
Date: Sat, 23 Jul 2011 18:12:39 -0400
Message-ID: <4E2B4757.7040204@pobox.com>
References: <CAN8TOE9CCSiS2koyx=UsZj=9KwaWZW5yDjUUqgJf2=qZU70k1w@mail.gmail.com> <20110713131407.GN2872@htj.dyndns.org> <CAN8TOE9Rjujf9aLQGONDULNasFiQmVkiUPWUDX=Vf0Nx2pka7w@mail.gmail.com> <20110721084917.GE3455@htj.dyndns.org> <CAN8TOE_dCg6Wi_trE97hXjBPnZi4jpLyoeUEVrbMpgDH-BwKWA@mail.gmail.com> <20110722090317.GH2622@htj.dyndns.org> <20110722094126.GI2622@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56754 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab1GWWMm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jul 2011 18:12:42 -0400
In-Reply-To: <20110722094126.GI2622@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>, linux-ide@vger.kernel.org, Valdis.Kletnieks@vt.edu, "Rafael J. Wysocki" <rjw@sisk.pl>, Michael Leun <lkml20100708@newton.leun.net>, linux-kernel@vger.kernel.org, Jian Peng <jipeng2005@gmail.com>, Kevin Cernekee <cernekee@gmail.com>

On 07/22/2011 05:41 AM, Tejun Heo wrote:
> This is another attempt at fixing the same problem that 270dac35c2
> (libata: ahci_start_engine compliant to AHCI spec) tried to solve.
> Unfortunately, 270dac35c2 created regressions for a lot more common
> controllers and got reverted.
>
> This specific AHCI IP block becomes a brick if the DMA engine is
> started while DRQ is set.  It is not possible to avoid the condition
> completely but the most common occurrence is caused by spurious use of
> ahci_start_engine() from ahci_start_port() during init sequence.
>
> DMA engine is started after both soft and hard resets and
> ahci_start_port() is always followed by resets, so there is no reason
> to start DMA engine from ahci_start_port().
>
> This patch removes ahci_start_engine() invocation from
> ahci_start_port().  This change makes failure path of
> ahci_port_suspend() leave engine stopped without following resets.
> This is resolved by replacing ahci_start_port() call with
> ata_port_freeze() which forces resets afterwards, which is the better
> behavior anyway.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Brian Norris<computersforpeace@gmail.com>
> Reported-by: Jian Peng<jipeng2005@gmail.com>
> ---
> Jeff, this needs to be tested for a while in linux-next before sending
> it mainline.  Please apply it for 3.1 merge window and let's see
> whether anything explodes.

Stuffed this into branch #upstream-next, which appears periodically for 
situations like this.  #upstream-next will become #upstream after the 
merge window closes.


