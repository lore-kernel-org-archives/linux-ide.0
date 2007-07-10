From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Date: Tue, 10 Jul 2007 14:53:36 +0400
Message-ID: <20070710145336.6f8b5770@localhost.localdomain>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<20070707150147.GA2202@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50106 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757899AbXGKKsj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jul 2007 06:48:39 -0400
In-Reply-To: <20070707150147.GA2202@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org


On Sat, 7 Jul 2007 10:01:47 -0500
Olof Johansson wrote:

> On Sat, Jul 07, 2007 at 01:48:52PM +0400, Vitaly Bordug wrote:
> > 
> > This adds support for MMIO IDE device like CompactFlash 
> > in TrueIDE mode.
> 
> Doesn't this duplicate most of pata_platform, but as the
> no-longer-preferred legacy IDE device? Did you try using
> pata_platform instead?
> 
prolly true,
but as Sergei told upper, that's not an option so far due to internal reasons. But it is likely to be followed-up
that way a little bit later.

> 
> -Olof


-- 
Sincerely, Vitaly

-- 
Sincerely, Vitaly
