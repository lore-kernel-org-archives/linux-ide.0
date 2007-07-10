From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] mmio ide support for mpc8349-itx target
Date: Tue, 10 Jul 2007 14:52:56 +0400
Message-ID: <20070710145256.6ac64e11@localhost.localdomain>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<20070707094900.9473.48577.stgit@localhost.localdomain>
	<468FC376.2040405@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50133 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758597AbXGKKto (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jul 2007 06:49:44 -0400
In-Reply-To: <468FC376.2040405@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

On Sat, 07 Jul 2007 20:46:46 +0400
Sergei Shtylyov wrote:

> > +
> > +#ifdef CONFIG_MPC834x_ITX  
> 
>     Erm, isn't this stuff misplaced? Is this really SoC device? I
> remember seeng this in the arch/ppc/ platform code before (in the
> internal tree)...

The point is to declare methods bsp, as mmio access may effectively vary (having bugs or intentionally) from platform to platform. All-in-one driver approach is nice but might be an issue to handle/maintain.

Thanks for looking at it, other notes make sense.

-- 
Sincerely, Vitaly
