From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Read Prefetch, Post Write on IDE chipsets
Date: Sun, 2 Sep 2007 15:00:34 +0100
Message-ID: <20070902150034.7a6713f5@the-village.bc.nu>
References: <46DAB1DF.5050109@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34659 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752562AbXIBNwA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 09:52:00 -0400
In-Reply-To: <46DAB1DF.5050109@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: linux-ide@vger.kernel.org

On Sun, 02 Sep 2007 13:51:43 +0100
Matt Sealey <matt@genesi-usa.com> wrote:

> Hi guys,
> 
> Does anyone have any decent information on the purpose, performance potential
> or perhaps quirks of the "read prefetch" and "post write" buffer features on
> some IDE chipsets?
> 
> It doesn't look like any standard but at least is included in quite a few
> of the libata drivers, and a lot of x86 BIOS control has toggles to try and
> turn it on or off.
> 
> But, what is it? I've never seen any documentation but which register to use
> to toggle it.. no vendor recommendations to turn it on, it seems like a rather
> secret feature..?

Chipset specific. Some public documentation discusses it for certain
chips (eg the Intel ATA tuning guidelines). For others you may need the
BIOS vendor manual or similar.

Alan
