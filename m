From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 33/64] cy82c693: fix PIO timings calculations
Date: Tue, 19 Jan 2010 01:26:27 -0800 (PST)
Message-ID: <20100119.012627.220165105.davem@davemloft.net>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118171847.14623.38391.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932181Ab0ASJ0m@vger.kernel.org>
In-Reply-To: <20100118171847.14623.38391.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 18 Jan 2010 18:18:47 +0100

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] cy82c693: fix PIO timings calculations
> 
> Just use the standard ide_timing_compute() helper to calculate
> PIO timings.  This fixes many issues with the open-coded version
> like using 16-bit timings when 8-bit ones should be used or not
> accounting for the enhanced cycle time specified by the device.
> 
> Based on libata pata_cypress host driver.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
