From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Lay groundwork for ATA port multiplier support
Date: Mon, 8 Aug 2005 22:22:47 -0400
Message-ID: <20050809022247.GA9715@havoc.gtf.org>
References: <42F7F352.2080307@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:39909 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932411AbVHICWs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Aug 2005 22:22:48 -0400
Content-Disposition: inline
In-Reply-To: <42F7F352.2080307@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Edward Falk <efalk@google.com>
Cc: linux-ide@vger.kernel.org, linux-kernel-daily-digest@lists.us.dell.com

On Mon, Aug 08, 2005 at 05:05:38PM -0700, Edward Falk wrote:
> This patch adds a few constants related to port multipliers to libata.h, 
> hdreg.h, and libata-core.c

Looks good, save for one detail:

hdreg.h is deprecated, and we want to put new defines in
include/linux/ata.h (which can be shared between IDE driver and libata).

	Jeff



