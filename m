From: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: switch ide-proc to use the ide_key functionality
Date: Mon, 16 Aug 2004 20:41:28 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040817004128.GA32628@devserv.devel.redhat.com>
References: <20040815150414.GA12181@devserv.devel.redhat.com> <200408170135.11465.bzolnier@elka.pw.edu.pl> <20040817001336.GA25753@devserv.devel.redhat.com> <200408170231.25725.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52930 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266484AbUHQAmb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Aug 2004 20:42:31 -0400
Content-Disposition: inline
In-Reply-To: <200408170231.25725.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

On Tue, Aug 17, 2004 at 02:31:25AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > It is also still racy for some drivers because ide_register_hw() ->
> > > init_hwif_data() sets hwif->key to zero - you must set hwif->hold to 1.
> >
> > ide_register_hw holds ide_setting_sem. I think that should be ok ?
> 
> ide_setting_sem doesn't help situation when hwif is unregistered and some 
> other driver is loaded later and takes this hwif using ide_register_hw().

Right - ide_cfg_sem is covering this. ide_cfg_sem is taken after 
ide_setting_sem so how about making init_hwif_data restore that field.

ide_drive_from_key can then take ide_cfg_sem during its checking

The other alternative is to never use key = 0 in the real world but I
see no reason for not just taking ide_cfg_sem during the key to drive
operation. ide_cfg_sem is the read lock for configuration change so this
is logically the right behaviour too ?





