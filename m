From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH next] ide: fix PowerMac bootup oops
Date: Wed, 10 Jun 2009 14:50:07 +0200
Message-ID: <200906101450.08632.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0906082137120.22183@sister.anvils> <200906091436.19710.bzolnier@gmail.com> <Pine.LNX.4.64.0906091357490.21803@sister.anvils>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:35053 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469AbZFJMpo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jun 2009 08:45:44 -0400
In-Reply-To: <Pine.LNX.4.64.0906091357490.21803@sister.anvils>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Cc: Joao Ramos <joao.ramos@inov.pt>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 09 June 2009 15:02:20 Hugh Dickins wrote:
> On Tue, 9 Jun 2009, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 09 June 2009 13:44:25 Hugh Dickins wrote:
> > > 
> > > But memset id in probe_for_drive() when it might be being reused -
> > > or would it be better to memset it wherever it used to be kfreed?
> > 
> > Please memset() it in ide_port_init_devices_data() -- this function
> > is called before IDE device structure is going to be (re-)used.
> 
> That makes sense too, thanks, here we go...
> 
> 
> [PATCH next] ide: fix PowerMac bootup oops
> 
> PowerMac bootup with CONFIG_IDE=y oopses in ide_pio_cycle_time():
> because "ide: try to use PIO Mode 0 during probe if possible" causes
> pmac_ide_set_pio_mode() to be called before drive->id has been set.
> 
> Bart points out other places which now need drive->id set earlier,
> so follow his advice to allocate it in ide_port_alloc_devices()
> (using kzalloc_node, without error message, as when allocating drive)
> and memset it for reuse in ide_port_init_devices_data().
> 
> Fixed in passing: ide_host_alloc() was missing ide_port_free_devices()
> from an error path.
> 
> Signed-off-by: Hugh Dickins <hugh.dickins@tiscali.co.uk>

applied
