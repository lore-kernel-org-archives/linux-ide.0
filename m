From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: recent IDE regression
Date: Sat, 26 Jul 2008 14:04:49 +0200
Message-ID: <200807261404.49947.bzolnier@gmail.com>
References: <20080724.233831.193691312.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754996AbYGZMSu@vger.kernel.org>
In-Reply-To: <20080724.233831.193691312.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: harvey.harrison@gmail.com, linux-ide@kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
List-Id: linux-ide@vger.kernel.org

On Friday 25 July 2008, David Miller wrote:

[...]

> Something like this:
> 
> endian: Always evaluate arguments.
> 
> Changeset 7fa897b91a3ea0f16c2873b869d7a0eef05acff4
> ("ide: trivial sparse annotations") created an IDE bootup
> regression on big-endian systems.  In drivers/ide/ide-iops.c,
> function ide_fixstring() we now have the loop:
> 
> 		for (p = end ; p != s;)
> 			be16_to_cpus((u16 *)(p -= 2));
> 
> which will never terminate on big-endian because in such
> a configuration be16_to_cpus() evaluates to "do { } while (0)"
> 
> Therefore, always evaluate the arguments to nop endian transformation
> operations.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Thanks David.

PS We need more big-endian users testing linux-next (this particular patch
despite being trivial has been put there just-in-case for a week)
 
