From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: switch ide-proc to use the ide_key functionality
Date: Tue, 17 Aug 2004 02:31:25 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200408170231.25725.bzolnier@elka.pw.edu.pl>
References: <20040815150414.GA12181@devserv.devel.redhat.com> <200408170135.11465.bzolnier@elka.pw.edu.pl> <20040817001336.GA25753@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28584 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266453AbUHQAbq
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Aug 2004 20:31:46 -0400
In-Reply-To: <20040817001336.GA25753@devserv.devel.redhat.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

On Tuesday 17 August 2004 02:13, Alan Cox wrote:
> On Tue, Aug 17, 2004 at 01:35:11AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Alan, 'ide_key' protection misses driver specfiic /proc/entries.
>
> Ok need to fix that
>
> > It is also still racy for some drivers because ide_register_hw() ->
> > init_hwif_data() sets hwif->key to zero - you must set hwif->hold to 1.
>
> ide_register_hw holds ide_setting_sem. I think that should be ok ?

ide_setting_sem doesn't help situation when hwif is unregistered and some 
other driver is loaded later and takes this hwif using ide_register_hw().

Highly unlikely but possible.

> > Can't we solve the problem in simpler way by covering affected /proc
> > handlers with ide_setting_sem?
>
> You'd need to refcount the ide objects because the 'data' value is long
> lived. I did consider this but it seemed more complex. It also leaves end
> users able to open an ide file and prevent unloading although I'm not
> sure it is a big issue.

Yep. :/
