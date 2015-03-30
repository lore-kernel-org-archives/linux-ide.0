From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_mv: Manage SATA port multiplier while searching for
 active links
Date: Mon, 30 Mar 2015 13:35:15 -0400
Message-ID: <20150330173515.GC9974@htj.duckdns.org>
References: <1427736765-846-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427736765-846-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On Mon, Mar 30, 2015 at 07:32:45PM +0200, Gregory CLEMENT wrote:
> From: Nadav Haklai <nadavh@marvell.com>
> 
> With this patch, when searching for active link, first search through
> the port multiplier links. And then fall to the default ap active_tag
> only if no there is no active link in the port multiplier.

What does this fix?  What was broken before?  What's the impact of the
patch?  A patch description which just restates the patch content
isn't all that useful.

Thanks.

-- 
tejun
