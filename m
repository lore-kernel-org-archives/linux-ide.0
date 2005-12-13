From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/6] SATA use ACPI methods for PM
Date: Tue, 13 Dec 2005 13:34:00 -0500
Message-ID: <439F1418.5030004@pobox.com>
References: <20051202101637.2167851a.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:64716 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932582AbVLMSeD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Dec 2005 13:34:03 -0500
In-Reply-To: <20051202101637.2167851a.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: ide <linux-ide@vger.kernel.org>, axboe <axboe@suse.de>

Randy Dunlap wrote:
> This is an update to the SATA suspend/resume patches
> to use ACPI methods (specifically _SDD and _GTF).
> This patch series applies to 2.6.15-rc4.
> 
> It boots but needs lots of testing & review/comments,
> as well as adding a call to write taskfiles on
> COMRESET event(s) (at least on async. loss of signal).
> 
> This is not intended to be a final patch for merging.
> 
> The patchset begins with the libata suspend/resume patch from
> Jens Axboe and builds on that.

Now that activity and discussion seems to have died down a bit, could 
you resend the latest versions of these patches?

	Jeff



