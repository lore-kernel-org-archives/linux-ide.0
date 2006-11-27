From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: typo in ide-io.c leads to faulty assignment
Date: Mon, 27 Nov 2006 15:08:37 +0000
Message-ID: <20061127150837.336f5541@localhost.localdomain>
References: <87k61h3pu2.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43200 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757648AbWK0PCB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Nov 2006 10:02:01 -0500
In-Reply-To: <87k61h3pu2.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Mon, 27 Nov 2006 15:51:33 +0100
Elias Oltmanns <eo@nebensachen.de> wrote:

> Due to a typo in ide_start_power_step, the result of a function rather
> than its pointer is assigned to args->handler.

NAK

If it was the result of the function it would end with (arguments);

Alan
