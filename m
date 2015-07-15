From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: increase the timeout when setting transfer mode
Date: Wed, 15 Jul 2015 11:57:19 -0400
Message-ID: <20150715155719.GD15934@mtj.duckdns.org>
References: <alpine.LRH.2.02.1507081304050.5355@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1507081304050.5355@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Jul 08, 2015 at 01:06:12PM -0400, Mikulas Patocka wrote:
> I have a ST4000DM000 disk. If Linux is booted while the disk is spun down,
> the command that sets transfer mode causes the disk to spin up. The
> spin-up takes longer than the default 5s timeout, so the command fails and
> timeout is reported.
> 
> Fix this by increasing the timeout to 15s, which is enough for the disk to
> spin up.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org

Applied to libata/for-4.2-fixes.

Thanks!

-- 
tejun
