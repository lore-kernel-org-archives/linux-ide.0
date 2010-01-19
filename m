From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 55/64] amd74xx: use ->pio_mode value to determine pair
 device speed
Date: Tue, 19 Jan 2010 01:53:47 -0800 (PST)
Message-ID: <20100119.015347.202770006.davem@davemloft.net>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118172133.14623.99453.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756039Ab0ASJxo@vger.kernel.org>
In-Reply-To: <20100118172133.14623.99453.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 18 Jan 2010 18:21:33 +0100

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] amd74xx: use ->pio_mode value to determine pair device speed
> 
> Use the current PIO mode value instead of the current transfer speed
> of the pair device on the port to determine PIO commmand timings used
> for both devices on the port.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
