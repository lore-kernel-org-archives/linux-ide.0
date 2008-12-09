From: Mark Lord <liml@rtr.ca>
Subject: Re: [RFC PATCH] pata_hpt366: fix mode configuration
Date: Tue, 09 Dec 2008 14:47:56 -0500
Message-ID: <493ECB6C.3040304@rtr.ca>
References: <493CC897.9080406@kernel.org> <493CF9A8.301@ru.mvista.com> <ce9d8ed60812081518g5d9166baia9fb9531b472dbff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:47383 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754599AbYLITqn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Dec 2008 14:46:43 -0500
In-Reply-To: <ce9d8ed60812081518g5d9166baia9fb9531b472dbff@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob OpenSuSE <rob.opensuse.linux@googlemail.com>, Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Rob OpenSuSE wrote:
> Though I do wonder
> how sensible it is, to spend a lot of time on elegant driver
> development for this legacy hardware, as it must be nearing practical
> end of life.
..

There are tons of PCI add-on cards still out there with these chips,
and they will continue to work fine so long as PCI slots
and PATA drives exist.  So we may as well ensure Linux does the Right Things (tm).

:)

Nice work, Tejun!
