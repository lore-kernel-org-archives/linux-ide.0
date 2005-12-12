From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 0/6] SATA use ACPI methods for PM
Date: Sun, 11 Dec 2005 20:48:55 -0800
Message-ID: <20051211204855.07961f94.rdunlap@xenotime.net>
References: <20051202101637.2167851a.randy_d_dunlap@linux.intel.com>
	<439CFBFD.5010404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:5773 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751099AbVLLEs0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Dec 2005 23:48:26 -0500
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Sun, 11 Dec 2005 20:48:22 -0800
In-Reply-To: <439CFBFD.5010404@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org, axboe@suse.de, jgarzik@pobox.com

On Sun, 11 Dec 2005 23:26:37 -0500 Mark Lord wrote:

> Randy Dunlap wrote:
> > This is an update to the SATA suspend/resume patches
> > to use ACPI methods (specifically _SDD and _GTF).
> > This patch series applies to 2.6.15-rc4.
> > 
> > It boots but needs lots of testing & review/comments,
> > as well as adding a call to write taskfiles on
> > COMRESET event(s) (at least on async. loss of signal).
> 
> This sequence of patches FIXED the problem I was having
> until now with my Dell Inspiron.  It usually fails the
> suspend/resume (RAM) test with a Hitachi 80GB drive installed,
> but this patch series makes even that combo work just fine.
> 
> The regular Fujitsu 100GB drive works regardless,
> so long as Jens' original patch is applied.

Thanks.  I'll see if I can mold it into something acceptable,
although Jeff still hasn't commented on it directly....

---
~Randy
