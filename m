From: Alan Cox <alan@linux.intel.com>
Subject: Re: [git patches] libata updates for 2.6.34
Date: Fri, 5 Mar 2010 18:37:24 +0000
Message-ID: <20100305183724.37b6f820@linux.intel.com>
References: <20100301202330.GA14977@havoc.gtf.org>
	<201003051958.24987.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:20048 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754178Ab0CETBq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Mar 2010 14:01:46 -0500
In-Reply-To: <201003051958.24987.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

> > +		const struct ata_port_info * const * ppi,
> > +		struct scsi_host_template *sht, void *host_priv,
> > int hflags);
> 
> 'int' type is not equal 'unsigned long' one on 64-bit architectures.

Agreed should indeed be a ulong.

> Besides doing it this way is clearly suboptimal

In your opinion - see previous discussion of this.
