From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
Date: Wed, 13 Dec 2006 11:32:48 +0000
Message-ID: <20061213113248.06372806@localhost.localdomain>
References: <200612130148.34539.sshtylyov@ru.mvista.com>
	<20061212234145.557cb035@localhost.localdomain>
	<58cb370e0612121709x41270fb2p20280cc1edc9c533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51181 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964855AbWLMLY5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Dec 2006 06:24:57 -0500
In-Reply-To: <58cb370e0612121709x41270fb2p20280cc1edc9c533@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> > Waste of space having a busproc routine. The maintainer removed all the
> > usable hotplug support from old IDE so this might as well be dropped.
> 
> I took over IDE when hotplug was already broken (late 2.5), moreover IDE
> hotplug support has been always a quick hack according to its original author...
> I remember your great efforts to fix it but unfortunately they
> depended on executing
> ioctls on non-existing devices which made them depend on layering
> violation in 2.6,

Bart, I'm really not interested in a 500 email rehash of the fact you
chose to refuse the hotplug support (that was working) for 2.6.x. You
did, the world has moved on, and there is no point putting a busproc
function in that driver.

Do something useful. Send a patch to make Sergei the IDE maintainer as
he's doing all the IDE stuff these days.

