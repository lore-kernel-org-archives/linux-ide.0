From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: update Kconfig text to mark as deprecated
Date: Fri, 30 Oct 2009 01:39:13 -0700 (PDT)
Message-ID: <20091030.013913.238587076.davem@davemloft.net>
References: <20091029.173028.248393897.davem@davemloft.net>
	<200910300915.51836.Martin@lichtvoll.de>
	<200910300918.39261.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57238
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756194AbZJ3Iit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2009 04:38:49 -0400
In-Reply-To: <200910300918.39261.Martin@lichtvoll.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin@lichtvoll.de
Cc: linux-kernel@vger.kernel.org, hancockrwd@gmail.com, linux-ide@vger.kernel.org

From: Martin Steigerwald <Martin@lichtvoll.de>
Date: Fri, 30 Oct 2009 09:18:39 +0100

> One thing to add: If you use a InitRD, you can use UUID or LABEL in GRUB 1 
> as well. I believe GRUB 2 at leasts supports UUID out of the box, but 
> better check this, before relying on my word.

Since I recently implement sparc64 support for GRUB2 I know that
indeed it does support UUID out of the box.

But grub2 sparc64 support is very new and the existing sparc64 boot
loader 'SILO' doesn't support UUIDs.

Personally, I also don't use initrds, I avoid them like the
plague. :-)
