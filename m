From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ide patches
Date: Sun, 29 Jul 2007 14:48:58 +0400
Message-ID: <46AC709A.6060002@ru.mvista.com>
References: <200707222019.03684.bzolnier@gmail.com> <1185155835.5439.91.camel@localhost.localdomain> <1185156084.5439.93.camel@localhost.localdomain> <200707232322.22129.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:55624 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761284AbXG2Kq6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Jul 2007 06:46:58 -0400
In-Reply-To: <200707232322.22129.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>Ok, there's a combination of things here:

>>> - First, doing a set_pio from userland (hdparm -p XX) causes the kernel
>>>to disable DMA, which I think is incorrect. It's not the case with
>>>2.6.22 from my quick tests. The problem is that ide_config_drive_speed
>>>disables DMA, but only re-enables it when setting a DMA speed. I think

> The problem is that _many_ chipsets don't support separate PIO and DMA
> timings so disabling DMA while programming chipset for PIO timings is a
> necessity for them.

    Actually, I didn't quite follow (as I'm afraid Ben also :-). Do you mean 
the fact that the DMA timings may get overwritten (which happens due to the 
failure of the drivers to handle the shared PIO/DMA timing registers, and in 
some cases by "coupling" PIO to UltraDMA timings for no apparent reasons which 
leads to disabling UltraDMA when PIO is being programmed)?

MBR, Sergei
