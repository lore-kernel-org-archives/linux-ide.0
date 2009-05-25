From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: add warning about possible HPA compatibility
 issue
Date: Mon, 25 May 2009 23:38:14 +0100
Message-ID: <20090525233814.4cb8b1c2@lxorguk.ukuu.org.uk>
References: <200905252348.08970.bzolnier@gmail.com>
	<20090525232014.7b6dd7bd@lxorguk.ukuu.org.uk>
	<200905260036.17718.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55188 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751715AbZEYWi2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 May 2009 18:38:28 -0400
In-Reply-To: <200905260036.17718.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jacob <fun2program8@yahoo.com>, Christopher Hogan <chris.c.hogan@gmail.com>, Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> > NAK - this is extremely misleading and will just randomly terrify users,
> > who may then set the paramater and corrupt things like BIOS save areas.
> 
> Please propose better description.

As was discussed before

Tejun has a patch in the queue which exposes the HPA and real sizes to
the OS

Libata can support revalidating a disc

Once the HPA/Real size data is there the tools can be tuned for this and
a sysfs node added to switch hpa on/off per disc. At that point this can
be done by the user space intelligently.

The fact this is a user parameter is itself a problem.

