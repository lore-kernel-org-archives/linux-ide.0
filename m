From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: 2.6.30-rc6: Problem with an SSD disk on Freescale PowerPC
	mpc8315e-rdb, works fine on x86
Date: Wed, 17 Jun 2009 18:07:42 +0200
Message-ID: <c384c5ea0906170907u5a4af524m65e23b32446dd79f@mail.gmail.com>
References: <c384c5ea0906080759n24a66d21ob9076518cec41755@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <c384c5ea0906080759n24a66d21ob9076518cec41755@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: Linux PPC <linuxppc-dev@ozlabs.org>, Kumar Gala <galak@kernel.crashing.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello Kumar, all,

On Mon, Jun 8, 2009 at 4:59 PM, Leon
Woestenberg<leon.woestenberg@gmail.com> wrote:
> using 2.6.30-rc6, I get the following problems when I read from a SSD
> disk, connected to the
> 3.0 Gb SATA controller of the MPC8315E SoC rev 1.0 running Linux 2.6.30-rc6.
>
Result on a first batch of bisects. I decided to go with the kernel
releases rather than git-bisect (still too scary for me).

All kernel releases 2.6.25 through -30 kernel gave the same error.
2.6.25 crashed on it, whereas 2.6.26+ recovered after each "dd" run.

The BSP 2.6.24.3-rt3 kernel did not give the error.

So on my todo is diff between 2.6.25 and .2.6.24.3-rt3 from the BSP.

Regards,
-- 
Leon
