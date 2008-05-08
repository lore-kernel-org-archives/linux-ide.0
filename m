From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/6] ide: remove IDE_TFLAG_NO_SELECT_MASK taskfile flag
Date: Thu, 8 May 2008 23:22:13 +0200
Message-ID: <200805082322.13297.bzolnier@gmail.com>
References: <200805071943.24296.bzolnier@gmail.com> <20080508205802.GA5722@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933313AbYEHVGX@vger.kernel.org>
In-Reply-To: <20080508205802.GA5722@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>
List-Id: linux-ide@vger.kernel.org

On Thursday 08 May 2008, Russell King wrote:
> On Wed, May 07, 2008 at 07:43:24PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Always call SELECT_MASK(..., 0) in ide_tf_load() (needs to be done
> > to match ide_set_irq(..., 1)) and then remove IDE_TFLAG_NO_SELECT_MASK
> > taskfile flag.
> > 
> > This change should only affect hpt366 and icside host drivers since
> > ->maskproc(..., 0) for sgiioc4 is equivalent to ide_set_irq(..., 1).
> 
> Provided the two channels on icside are serialised (so IDE doesn't
> try to enable IRQs on both channels at the same time) it shouldn't
> be a problem.

Yep, they are serialized.

> However, since I don't use this driver anymore (using the PATA version
> instead) I don't feel it's right for me to ack this change.

Thanks for taking a look anyway.

Bart
