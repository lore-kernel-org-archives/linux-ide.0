From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] Add SanDisk ConnectPlus to the device table
Date: Fri, 15 Jul 2005 18:58:53 +0200
Message-ID: <20050715165853.GA3586@isilmar.linta.de>
References: <1121203461.9992.3.camel@dv> <1121284071.10274.2.camel@dv> <1121286837.2763.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:42949 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S263341AbVGOQ6y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jul 2005 12:58:54 -0400
Content-Disposition: inline
In-Reply-To: <1121284071.10274.2.camel@dv> <1121286837.2763.6.camel@dv>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: pcmcia <linux-pcmcia@lists.infradead.org>, linux-ide@vger.kernel.org

Hi,

On Wed, Jul 13, 2005 at 04:33:57PM -0400, Pavel Roskin wrote:
> Sorry for cross-post, not sure who should apply this patch.

Will push it upstream via pcmcia.

> SanDisk ConnectPlus has two functions.  Function 0 is prism2 card,
> currently only supported by HostAP (not in the kernel).  Function 1 is
> 128M flash, supported by ide-cs.  This patch adds an entry for function
> 1 to ide-cs.c.

Applied.

> There are two problems with the message about missing callback
> functions: it's not written in correct English and it lacks newline at
> the end.

Also applied. /me wears a brown paper bag for that spelling "bug"...

Thanks,
	Dominik
