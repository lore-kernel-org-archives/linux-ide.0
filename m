From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 59/64] it821x: use ->pio_mode value to determine pair
 device speed
Date: Tue, 19 Jan 2010 01:54:13 -0800 (PST)
Message-ID: <20100119.015413.244180263.davem@davemloft.net>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118172202.14623.99244.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756586Ab0ASJzu@vger.kernel.org>
In-Reply-To: <20100118172202.14623.99244.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 18 Jan 2010 18:22:02 +0100

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] it821x: use ->pio_mode value to determine pair device speed
> 
> Use the current PIO mode value instead of the physical maximum one
> of the pair device on the port to determine PIO commmand timings used
> for both devices on the port.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
