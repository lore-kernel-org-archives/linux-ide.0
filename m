From: Mark Lord <lkml@rtr.ca>
Subject: Re: sata_mv important note
Date: Tue, 17 Jan 2006 14:34:15 -0500
Message-ID: <43CD46B7.4000907@rtr.ca>
References: <43CD07D5.30302@pobox.com> <E1EytdC-0006DE-IS@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:63681 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751331AbWAQTfb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2006 14:35:31 -0500
In-Reply-To: <E1EytdC-0006DE-IS@highlab.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Kuzminsky <seb@highlab.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Sebastian Kuzminsky wrote:
>
> Can anyone recommend a 4xSATA (or more) controller on a PCI-X card that
> _is_ ready for production use?  eSATA ports are prefered but not required.
> Support for hotplug, power management (spindown) and SMART is prefered
> but not required.

The Pacific Digital QStor cards come in PCIX variants,
and support SATA2.  Hotplug et al is supported in the hardware,
but not in the Libata driver.  ATAPI is not supported at all.

Cheers
