From: Jeff Garzik <jeff@garzik.org>
Subject: Re: AMD 890GX vs 6Gbps SATA?
Date: Sun, 14 Nov 2010 23:08:39 -0500
Message-ID: <4CE0B247.50002@garzik.org>
References: <m3mxpbn69i.fsf@jhcloos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54287 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755722Ab0KOEIm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Nov 2010 23:08:42 -0500
Received: by vws13 with SMTP id 13so1483930vws.19
        for <linux-ide@vger.kernel.org>; Sun, 14 Nov 2010 20:08:41 -0800 (PST)
In-Reply-To: <m3mxpbn69i.fsf@jhcloos.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Cloos <cloos@jhcloos.com>
Cc: linux-ide@vger.kernel.org

On 11/14/2010 12:50 PM, James Cloos wrote:
> All of the ad copy and doc I can find claim that the sata controller in
> the 890gx supports 6Gbps sata3.  But I still get this:
>
> ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: ATA-8: WDC WD1002FAEX-xxxxxx, 05.xxxxx, max UDMA/133
>
> I hadn't noticed before because that box's first drive only supports 3 Gbps.
>
> Does the 6Gpbs mode require that all of the disks are sata3?  (That would
> be /most/ annoying, given that optical drives all seem to be 1.5Gbps.)

No, on SATA each link is entirely independent of the other links 
(ignoring port multipliers).

The "3 Gbps" maximum you see on the first line comes directly from what 
capabilities the chip reports, so perhaps the firmware/BIOS is not 
initializing the chip properly.

AHCI 1.2 hardware, the AHCI driver and libata core should all support 
operation at 6 Gbps.

	Jeff



