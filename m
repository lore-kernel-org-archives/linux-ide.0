From: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH][SDK v1.2] sata: I/O load balancing
Date: Fri, 13 Jan 2012 17:36:52 +0800
Message-ID: <CADRPPNQsVB-2jR0UaX6RB_4PCf9kt4UXvAXnxaVk=LsBcwGowg@mail.gmail.com>
References: <1326443147-26645-1-git-send-email-qiang.liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46655 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab2AMJgy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jan 2012 04:36:54 -0500
In-Reply-To: <1326443147-26645-1-git-send-email-qiang.liu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Qiang Liu <qiang.liu@freescale.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Qiang Liu <b32616@freescale.com>

On Fri, Jan 13, 2012 at 4:25 PM, Qiang Liu <qiang.liu@freescale.com> wrote:
> From: Qiang Liu <b32616@freescale.com>
>
> Reduce interrupt singnals through reset Interrupt Coalescing Control Reg.
> Increase the threshold value of interrupt and timer will reduce the number
> of complete interrupt sharply. Improve the system performance effectively.

There is always a trade off of throughput and latency by using
interrupt coalescing.  It's not reasonable to assume that the
throughput is the only factor to be considered and set the coalescing
threshold and timeout to the max value by default.  Have you carried
out other benchmark like copying many small files?

It will be safer to make the coalescing runtime configurable like the
sata_mv driver, IMO.

- Leo
