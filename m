From: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: switch ide-proc to use the ide_key functionality
Date: Mon, 16 Aug 2004 20:13:36 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040817001336.GA25753@devserv.devel.redhat.com>
References: <20040815150414.GA12181@devserv.devel.redhat.com> <200408170135.11465.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:15286 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268038AbUHQAOb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Aug 2004 20:14:31 -0400
Content-Disposition: inline
In-Reply-To: <200408170135.11465.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

On Tue, Aug 17, 2004 at 01:35:11AM +0200, Bartlomiej Zolnierkiewicz wrote:
> Alan, 'ide_key' protection misses driver specfiic /proc/entries.

Ok need to fix that

> It is also still racy for some drivers because ide_register_hw() -> 
> init_hwif_data() sets hwif->key to zero - you must set hwif->hold to 1.

ide_register_hw holds ide_setting_sem. I think that should be ok ?

> Can't we solve the problem in simpler way by covering affected /proc
> handlers with ide_setting_sem?

You'd need to refcount the ide objects because the 'data' value is long
lived. I did consider this but it seemed more complex. It also leaves end
users able to open an ide file and prevent unloading although I'm not
sure it is a big issue.

