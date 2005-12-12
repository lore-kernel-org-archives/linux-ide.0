From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH 0/6] SATA use ACPI methods for PM
Date: Sun, 11 Dec 2005 23:26:37 -0500
Message-ID: <439CFBFD.5010404@pobox.com>
References: <20051202101637.2167851a.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vds.fauxbox.com ([208.210.124.75]:34517 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751086AbVLLE0n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Dec 2005 23:26:43 -0500
In-Reply-To: <20051202101637.2167851a.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: ide <linux-ide@vger.kernel.org>, axboe <axboe@suse.de>, jgarzik <jgarzik@pobox.com>

Randy Dunlap wrote:
> This is an update to the SATA suspend/resume patches
> to use ACPI methods (specifically _SDD and _GTF).
> This patch series applies to 2.6.15-rc4.
> 
> It boots but needs lots of testing & review/comments,
> as well as adding a call to write taskfiles on
> COMRESET event(s) (at least on async. loss of signal).

This sequence of patches FIXED the problem I was having
until now with my Dell Inspiron.  It usually fails the
suspend/resume (RAM) test with a Hitachi 80GB drive installed,
but this patch series makes even that combo work just fine.

The regular Fujitsu 100GB drive works regardless,
so long as Jens' original patch is applied.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

