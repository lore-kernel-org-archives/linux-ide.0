From: Ricky Beam <jfbeam@bluetronic.net>
Subject: Re: [PATCH] fix sata_sil quirk
Date: Tue, 22 Jun 2004 20:34:04 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.33.0406222031230.25702-100000@sweetums.bluetronic.net>
References: <40D8AED6.8050503@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sweetums.bluetronic.net ([24.199.150.42]:61691 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264966AbUFWAkk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jun 2004 20:40:40 -0400
In-Reply-To: <40D8AED6.8050503@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Tue, 22 Jun 2004, Jeff Garzik wrote:
>Is this with my patch?

It is now.  Either way, max_sectors is staying 15.  I'll post the results
after it's had time to zero 40G a few dozen times.

>The full-speed fix requires splitting affected DMA writes into two
>separate commands, when the sector count matches "sectors % 15 == 1".

Why 15 I wonder?

--Ricky


