From: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH 2/2] [POWERPC] mmio ide support for mpc8349-itx target
Date: Sat, 7 Jul 2007 10:07:08 -0500
Message-ID: <20070707150708.GA5387@lixom.net>
References: <20070707094852.9473.21013.stgit@localhost.localdomain> <20070707094900.9473.48577.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:35418 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbXGGO4F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Jul 2007 10:56:05 -0400
Content-Disposition: inline
In-Reply-To: <20070707094900.9473.48577.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

On Sat, Jul 07, 2007 at 01:49:00PM +0400, Vitaly Bordug wrote:
> 
> This updates relevant platform code
> (freescale mpc8349itx target) to make the CompactFlash
> work in TrueIDE mode.

Shouldn't you be writing a PCMCIA driver instead for the CF, so it
handles other devices as well? Then you get storage "for free", as
well as hotplug, etc.

It's not hard:

http://patchwork.ozlabs.org/linuxppc/patch?person=124&id=12044


-Olof

