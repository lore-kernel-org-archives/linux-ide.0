From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 4/6] ide: remove IDE_TFLAG_NO_SELECT_MASK taskfile flag
Date: Thu, 8 May 2008 21:58:03 +0100
Message-ID: <20080508205802.GA5722@flint.arm.linux.org.uk>
References: <200805071943.24296.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33131 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbYEHU6Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 May 2008 16:58:16 -0400
Content-Disposition: inline
In-Reply-To: <200805071943.24296.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Wed, May 07, 2008 at 07:43:24PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Always call SELECT_MASK(..., 0) in ide_tf_load() (needs to be done
> to match ide_set_irq(..., 1)) and then remove IDE_TFLAG_NO_SELECT_MASK
> taskfile flag.
> 
> This change should only affect hpt366 and icside host drivers since
> ->maskproc(..., 0) for sgiioc4 is equivalent to ide_set_irq(..., 1).

Provided the two channels on icside are serialised (so IDE doesn't
try to enable IRQs on both channels at the same time) it shouldn't
be a problem.

However, since I don't use this driver anymore (using the PATA version
instead) I don't feel it's right for me to ack this change.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
