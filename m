From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 29/64] alim15x3: cleanup ali_cable_detect()
Date: Tue, 19 Jan 2010 01:25:56 -0800 (PST)
Message-ID: <20100119.012556.140440898.davem@davemloft.net>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118171807.14623.50469.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755917Ab0ASJZx@vger.kernel.org>
In-Reply-To: <20100118171807.14623.50469.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 18 Jan 2010 18:18:07 +0100

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] alim15x3: cleanup ali_cable_detect()
> 
> Remove leftover local_irq_[save,restore]() and FIXME note.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
