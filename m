From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 51/64] alim15x3: fix handling of address setup timings
Date: Tue, 19 Jan 2010 01:53:18 -0800 (PST)
Message-ID: <20100119.015318.108902562.davem@davemloft.net>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118172105.14623.5133.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:44780
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752075Ab0ASJxI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2010 04:53:08 -0500
In-Reply-To: <20100118172105.14623.5133.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 18 Jan 2010 18:21:05 +0100

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] alim15x3: fix handling of address setup timings
> 
> Account for the requirements of the other device on the port.
> 
> Based on libata pata_ali host driver.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
