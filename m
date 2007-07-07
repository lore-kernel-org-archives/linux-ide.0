From: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Date: Sat, 7 Jul 2007 10:01:47 -0500
Message-ID: <20070707150147.GA2202@lixom.net>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:54108 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbXGGOun (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Jul 2007 10:50:43 -0400
Content-Disposition: inline
In-Reply-To: <20070707094852.9473.21013.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

On Sat, Jul 07, 2007 at 01:48:52PM +0400, Vitaly Bordug wrote:
> 
> This adds support for MMIO IDE device like CompactFlash 
> in TrueIDE mode.

Doesn't this duplicate most of pata_platform, but as the
no-longer-preferred legacy IDE device? Did you try using
pata_platform instead?


-Olof
