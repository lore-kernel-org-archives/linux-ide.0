From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] ide_tape: convert jiffies with jiffies_to_msecs
Date: Wed, 18 Mar 2015 23:27:05 -0400 (EDT)
Message-ID: <20150318.232705.2124623765475489475.davem@davemloft.net>
References: <1425379971-12641-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425379971-12641-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hofrat@osadl.org
Cc: joe@perches.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>
Date: Tue,  3 Mar 2015 05:52:51 -0500

> Use jiffies_to_msecs for converting jiffies as it handles all of the corner
> cases reliably and also helps readability. The printk format is fixed up 
> as jiffies_to_msecs returns unsigned int not unsigned long.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> v2: change printk format string from %d to %u as suggested by
>     Joe Perches <joe@perches.com>.

Applied, thanks.
