From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 0/6] SATA use ACPI methods for PM
Date: Tue, 13 Dec 2005 10:39:24 -0800
Message-ID: <20051213103924.7de22004.randy_d_dunlap@linux.intel.com>
References: <20051202101637.2167851a.randy_d_dunlap@linux.intel.com>
	<439F1418.5030004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:45525 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932597AbVLMSgi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Dec 2005 13:36:38 -0500
In-Reply-To: <439F1418.5030004@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, axboe@suse.de

On Tue, 13 Dec 2005 13:34:00 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Randy Dunlap wrote:
> > This is an update to the SATA suspend/resume patches
> > to use ACPI methods (specifically _SDD and _GTF).
> > This patch series applies to 2.6.15-rc4.
> > 
> > It boots but needs lots of testing & review/comments,
> > as well as adding a call to write taskfiles on
> > COMRESET event(s) (at least on async. loss of signal).
> > 
> > This is not intended to be a final patch for merging.
> > 
> > The patchset begins with the libata suspend/resume patch from
> > Jens Axboe and builds on that.
> 
> Now that activity and discussion seems to have died down a bit, could 
> you resend the latest versions of these patches?

Yes, I'm updating them a little and will try to resend
later today.

---
~Randy
