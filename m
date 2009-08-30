From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ata_piix: parallel scanning on PATA needs an extra locking
Date: Sun, 30 Aug 2009 16:33:19 +0200
Message-ID: <200908301633.19978.bzolnier@gmail.com>
References: <200908301456.30132.bzolnier@gmail.com> <20090830151321.57bc33eb@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:51597 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbZH3OdK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Aug 2009 10:33:10 -0400
In-Reply-To: <20090830151321.57bc33eb@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Alan Cox <alan@linux.intel.com>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 30 August 2009 16:13:21 Alan Cox wrote:
> > Lets fix all such races by adding an extra locking to ->set_piomode
> > and ->set_dmamode methods for PATA controllers.
> 
> Would it not be better to take the host lock in libata-core for these
> cases so that we fix all the adapters in one swoop. Even if we are doing
> this lock taking in the controller specific code it seems the right lock
> to use ?

Yes, taking the host lock would be a preferred solution in the long-term
and would allow us to enable parallel scanning for many other controllers
later.

The downside is that it requires somebody to audit all host drivers before
making such change and much more testing time..

> Looks fine as a temproary quickfix tho

That was the goal of the patch (I verified the issue only yesterday).
