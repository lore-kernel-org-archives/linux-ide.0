From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
Date: Fri, 12 May 2006 12:21:16 -0700
Message-ID: <20060512122116.152fbe80.rdunlap@xenotime.net>
References: <20060512132437.GB4219@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:60807 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751362AbWELTSu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 May 2006 15:18:50 -0400
Received: from midway.site ([71.245.102.105]) by xenotime.net for <linux-ide@vger.kernel.org>; Fri, 12 May 2006 12:18:46 -0700
In-Reply-To: <20060512132437.GB4219@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, 12 May 2006 22:24:37 +0900 Tejun Heo wrote:

> Hello, all.
> 
> Lately libata has been going through a lot of changes and even more
> are around the corner.  I've been working on error handling and
> advanced SATA features for quite sometime now, and, finally, patches
> have been finalized and submitted for review a few days ago.
> 
> 2.6.18 is the target for mainline merge.  As there is quite some time
> between now and 2.6.18, I have made patches to update the current
> stable kernel to support the new features so that they can receive
> wider testing and interested people don't have to wait too long.  I
> intend to maintain these patches through 2.6.16 and 17 until the
> mainline merge happens.
> 
> Added new features are
> 
> * New error handling
> * IRQ driven PIO (from Albert Lee)
> * SATA NCQ support
> * Hotplug support
> * Port Multiplier support

BTW, we often use PM to mean Power Management.
Could we find a different acronym for Port Multiplier support,
such as PMS or PX or PXS?

---
~Randy
