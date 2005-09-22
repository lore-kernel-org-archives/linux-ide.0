From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SATA suspend-to-ram patch - merge?
Date: Thu, 22 Sep 2005 15:17:59 +0100
Message-ID: <1127398679.18840.84.camel@localhost.localdomain>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com>
	 <20050922061849.GJ7929@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030343AbVIVNvt@vger.kernel.org>
In-Reply-To: <20050922061849.GJ7929@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Joshua Kwan <joshk@triplehelix.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

On Iau, 2005-09-22 at 08:18 +0200, Jens Axboe wrote:
> > So currently we are in limbo...
> 
> Which is a shame, since it means that software suspend on sata is
> basically impossible :)

Not really, everyone on the planet who cares is using the existing patch
and that just works. If the SCSI folks can't fix the SCSI layer to do
power management then the scsi drivers just need to not provide pm
methods until they catch up.

Blocking SATA suspend which people need for SCSI suspend which is
utterly obscure and weird is pointless, as pretty much ever vendor
except Red Hat has already decided.

Alan
