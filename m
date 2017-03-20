From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] pata_pcmcia: add EBSA110's PCMCIA slot support
Date: Mon, 20 Mar 2017 14:00:50 +0100
Message-ID: <19614027.eE1GoeCQeE@amdc3058>
References: <CGME20170314175046epcas1p43f98daad14a2bac7f314e7d39e120232@epcas1p4.samsung.com>
 <20170317141313.GC5078@htj.duckdns.org> <5827966.LxfQpi93qC@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <5827966.LxfQpi93qC@amdc3058>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Olof Johansson <olof@lixom.net>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Friday, March 17, 2017 04:51:13 PM Bartlomiej Zolnierkiewicz wrote:

> > What's the end game here?  Is it part of the effort to remove ide?  If
> > so, I have no objection to that but think it isn't a pressing issue
> > either and the ultimate decision has to come from Dave.
> 
> I'm just helping in migrating users that are still using ide to libata,
> enhancing libata's hardware support in the process. I would prefer to
> have ide removed in the long-term (once there are no known users of
> it) but Dave has a valid point (see below).  This particular patch is
> more a by-product of the above work than a part of it itself.
> 
> Dave's current opinion is that we can't prove that all configurations
> currently supported by ide are supported by libata.  Since it can never
> be really proved (as there are ide drivers for hardware that cannot be
> tested because of having no active users) he is fine with ide staying
> in the kernel forever. Which may be not as bad for me personally as
> I have a lot of contributions there. ;-)

I've given some more thought on this over the weekend.

I completely agree with Dave's opinion now. He has a good understanding
of a long-term kernel development process (his opinions on ide were right
back in 2009 and 2005).

We keep support for hardware that has no active users "just in case" until
the maintenance cost becomes too high or it blocks (in major way) some new
developments.  This is not the case with ide (even with all active users
ported to libata we will still be left with some support for hardware which
can no longer be tested) and it should stay unless some of above conditions
change. My personal wish to have coherent PATA support in the kernel doesn't
really matter here.

I would apologize for being wrong on this and I'm sorry for waisting
people's time.

Coming back to the pata_pcmcia patch, Tejun, please just ignore it. It is
now in mailing list's archives and this is sufficient to reference it if
ever needed.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
