From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 3/7] SATA ACPI linux/libata.h update
Date: Wed, 14 Dec 2005 15:00:16 -0800
Message-ID: <20051214150016.3595e882.randy_d_dunlap@linux.intel.com>
References: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com>
	<20051213160530.1fcadda0.randy_d_dunlap@linux.intel.com>
	<43A097E1.1000402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:45734 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S965061AbVLNW4q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Dec 2005 17:56:46 -0500
In-Reply-To: <43A097E1.1000402@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, axboe@suse.de

On Wed, 14 Dec 2005 17:08:33 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Randy Dunlap wrote:
> > From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> > 
> > Add ACPI data pointer/length holders.
> > 
> > Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Why does struct ata_device need to remember this info at all?

Uh... I dunno.  I'll see if I can just read that data
during resume.

---
~Randy
