From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ATA: sata_mv: Remove uneeded CONFIG_HAVE_CLK ifdefs
Date: Mon, 29 Jul 2013 12:00:16 -0400
Message-ID: <20130729160016.GC22605@mtj.dyndns.org>
References: <1375111282-22624-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1375111282-22624-2-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1375111282-22624-2-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-ide@vger.kernel.org

On Mon, Jul 29, 2013 at 12:21:22PM -0300, Ezequiel Garcia wrote:
> If CONFIG_HAVE_CLK is not selected, then all the clk API turn out
> into stubs, so there's no need to have the ifdefs.
> The only side-effect of this patch is the extra tiny kmalloc,
> but that's not enough reason to have such ugly ifdefs all around
> the code.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Can you please add a comment in the hpriv definition explaining what
that clk is for and how it's optional and becomes noops when not
needed?

Thanks.

-- 
tejun
