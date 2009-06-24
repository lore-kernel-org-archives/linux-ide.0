From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 4/6] ide: allow ide_dev_read_id() to be called from the IRQ context
Date: Wed, 24 Jun 2009 21:55:56 +0200
Message-ID: <200906242155.56769.bzolnier@gmail.com>
References: <200906240336.25263.bzolnier@gmail.com> <200906241304.14926.bzolnier@gmail.com> <4A427EE0.8050901@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:54772 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbZFXTuY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2009 15:50:24 -0400
In-Reply-To: <4A427EE0.8050901@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 24 June 2009 21:30:40 Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday 24 June 2009 12:48:20 Bartlomiej Zolnierkiewicz wrote:
> > 
> >>> 1) You want the device to be quiescent anyways when you do this
> >>>    SET_XFER command.  What better way than to plug the queue
> >>>    and make sure all currently outstanding requests complete?
> >>>
> >>>    And as already discussed, we even already have logic to support
> >>>    this kind of thing for the sake of power-management.
> >> Power management requests are kind of special and need block layer support.
> >>
> >> Please take a look at REQ_DEVSET_EXEC special requests from ide-devsets.c
> >> instead if you would like to investigate possibility of a cleaner (although
> >> more invasive) solution.
> >>
> >>> 2) All commands going into the device do so from a context from
> >>>    which we could take a sleeping lock such as a mutex.  It's
> >>>    therefore the most natural way to synchonize things.
> >> The fact is that we need to synchronize against all commands going into
> >> the device and they are synchronized using block queue (which is protected
> >> with spinlock by block layer). Adding an extra mutex (even if possible)
> > 
> > We need to also take the synchronization between block queues of all devices
> > on the port and the serialized ports into account..  This is quite complex
> > and fragile code (vide cmd64x screaming IRQ issue ;)..
> > 
> > I would personally try going with 1) and avoid 2) at all costs..
> 
> FWIW, on Promise chipsets, SETFEATURES_XFER requires synchronization 
> across all ports on the controller, otherwise SETFEATURES_XFER on port M 
> can potentially cause data corruption on unrelated port N.
> 
> This has to do with the snooping of ATA commands performed by the 
> Promise PATA and SATA chips.  The chip sees SETFEATURES_XFER, and does a 
> bit of internal programming.
> 
> Silicon Image (siimage or sata_sil) also snoops ATA commands such as 
> SETFEATURES_XFER; ditto a few other chipsets.
> 
> SETFEATURES_XFER has always required very, very careful, often 
> chipset-specific handling.

Thanks for the reminder.

David, we should probably disallow user-space requested transfer mode
changes on some chipsets (especially Promise ones) in IDE until somebody
provides the needed synchronization infrastructure for handling such
special cases (libata avoids the issue by not allowing any user-space
requested transfer mode changes).  However since this is an independent
issue from IRQ handler vs user context races it would be best done in
the separate patch.
