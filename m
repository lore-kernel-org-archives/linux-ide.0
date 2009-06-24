From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 4/6] ide: allow ide_dev_read_id() to be called from the IRQ context
Date: Wed, 24 Jun 2009 15:05:52 +0200
Message-ID: <200906241505.52899.bzolnier@gmail.com>
References: <200906240336.25263.bzolnier@gmail.com> <200906241248.21173.bzolnier@gmail.com> <200906241304.14926.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759237AbZFXNAt@vger.kernel.org>
In-Reply-To: <200906241304.14926.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 24 June 2009 13:04:14 Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 24 June 2009 12:48:20 Bartlomiej Zolnierkiewicz wrote:
> 
> > > 1) You want the device to be quiescent anyways when you do this
> > >    SET_XFER command.  What better way than to plug the queue
> > >    and make sure all currently outstanding requests complete?

BTW this is the way we do it currently.

We just back-ride on ide_finish_cmd() call for the special user-initiated
REQ_TYPE_ATA_TASKFILE request.  Doing it the other way will only result in:

* shorter IRQ latency for user-space requested xfer mode change request
  (irrelevant as the whole interface is just a rarely used legacy)

* much more invasive changes to the IDE core (I would be more than happy
  to welcome them but this is against our newly established policy)

Anyway I'll be happy with whatever solution that will end up in Linus tree
and is OK from the correctness POV.

> > >    And as already discussed, we even already have logic to support
> > >    this kind of thing for the sake of power-management.
> > 
> > Power management requests are kind of special and need block layer support.
> > 
> > Please take a look at REQ_DEVSET_EXEC special requests from ide-devsets.c
> > instead if you would like to investigate possibility of a cleaner (although
> > more invasive) solution.
> > 
> > > 2) All commands going into the device do so from a context from
> > >    which we could take a sleeping lock such as a mutex.  It's
> > >    therefore the most natural way to synchonize things.
> > 
> > The fact is that we need to synchronize against all commands going into
> > the device and they are synchronized using block queue (which is protected
> > with spinlock by block layer). Adding an extra mutex (even if possible)
> 
> We need to also take the synchronization between block queues of all devices
> on the port and the serialized ports into account..  This is quite complex
> and fragile code (vide cmd64x screaming IRQ issue ;)..
> 
> I would personally try going with 1) and avoid 2) at all costs..
