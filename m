From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_hpt3x2n: fix timing register masks (take 2)
Date: Fri, 4 Dec 2009 23:29:23 +0000
Message-ID: <20091204232923.6daacb23@lxorguk.ukuu.org.uk>
References: <200912042330.23507.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53935 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751699AbZLDX2E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Dec 2009 18:28:04 -0500
In-Reply-To: <200912042330.23507.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org

> - the driver doesn't serialize access to the channels depending on the current
>   clock mode like the vendor drivers, so the clock turnaround is only executed
>   "optionally", not always as it should be;

The vendor driver I have uses that algorithm. I think I prefer your
approach however !

> - the wrong ports are written to when hpt3x2n_set_clock() is called for the
>   secondary channel;

Ouch.

> - hpt3x2n_set_clock() can inadvertently enable the disabled channels when
>   resetting the channel state machines.

Yep.

> Could you give this a bit of testing? I don't have HPT371N at hand, and it's
> seated in the board with 66 MHz PCI anyway...

I'm not likely to have a chance to do so until next year.

