From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Tue, 14 Oct 2008 10:27:14 +1100
Message-ID: <1223940434.8157.283.camel@pasglop>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	<48F2F138.6020103@kernel.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <48F2F138.6020103@kernel.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, Jeff Garzik <jgarzik@pobox.com>, Wang Jian <lark@linux.net.cn>
List-Id: linux-ide@vger.kernel.org

On Mon, 2008-10-13 at 15:56 +0900, Tejun Heo wrote:
> Anton Vorontsov wrote:
> > When no irq specified the pata_of_platform fills the irq_res with -1,
> > which is wrong to do for two reasons:
> > 
> > 1. By definition, 'no irq' should be IRQ 0, not some negative integer;
> > 2. pata_platform checks for irq_res.start > 0, but since irq_res.start
> >    is unsigned type, the check will be true for `-1'.
> > 
> > Reported-by: Steven A. Falco <sfalco@harris.com>
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> applied to #tj-upstream (will soon be sent upstream)

Hrm... I applied it to powerpc.git too :-) Hopefully the merge will sort
it out !

Cheers,
Ben.
