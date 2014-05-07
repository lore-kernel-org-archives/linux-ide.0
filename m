From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: clean up ZPODD when a port is detached
Date: Wed, 7 May 2014 09:18:36 -0400
Message-ID: <20140507131836.GD16702@htj.dyndns.org>
References: <1399384668-20394-1-git-send-email-levex@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:41315 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933384AbaEGNSk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2014 09:18:40 -0400
Content-Disposition: inline
In-Reply-To: <1399384668-20394-1-git-send-email-levex@linux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Levente Kurusa <levex@linux.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ATA/IDE <linux-ide@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Joe Thomas <Joe.Thomas@dothill.com>

On Tue, May 06, 2014 at 03:57:48PM +0200, Levente Kurusa wrote:
> When a ZPODD device is unbound via sysfs, the ACPI notify handler
> is not removed. This causes panics as observed in Bug #74601. The
> panic only happens when the wake happens from outside the kernel
> (i.e. inserting a media or pressing a button). Add a loop to
> ata_port_detach which loops through the port's devices and checks
> if zpodd is enabled, if so call zpodd_exit.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Levente Kurusa <levex@linux.com>

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
