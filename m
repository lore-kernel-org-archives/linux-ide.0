From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] pata_pcmcia: add EBSA110's PCMCIA slot support
Date: Fri, 17 Mar 2017 16:51:13 +0100
Message-ID: <5827966.LxfQpi93qC@amdc3058>
References: <CGME20170314175046epcas1p43f98daad14a2bac7f314e7d39e120232@epcas1p4.samsung.com>
 <11380780.Ccg1NEX8q5@amdc3058> <20170317141313.GC5078@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20170317141313.GC5078@htj.duckdns.org>
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
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Friday, March 17, 2017 10:13:13 AM Tejun Heo wrote:
> Hello,
> 
> On Fri, Mar 17, 2017 at 03:08:56PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > To be honest, the main point here is to make Russell happy. ;-)
> > 
> > This is the second time he brought EBSA110 issue while talking about
> > conversion of ARM platforms to use libata PATA so I've finally decided
> > to do the patch just to have a reference example of how to deal with
> > this and similar devices in a proper way.
> > 
> > Even though the patch can't be tested EBSA110 is still a supported ARM
> > platform and the patch should work fine in theory (+ it cannot break
> > anything).  OTOH it adds an extra code which has some cost from the
> > long-term maintenance POV.  Anyway, it is up to you to decide what to
> > do with it. :-)
> 
> It's fairly low impact and I don't think it's gonna add noticeable
> maintenance overhead at all, so that part is fine but it's super weird
> to add code which we know not to have any users.  It looks like we
> can't even test it.

Well, this is more general problem.  We keep things like ARM EBSA110
platform support in the kernel for some reason.. maybe we shouldn't?

> What's the end game here?  Is it part of the effort to remove ide?  If
> so, I have no objection to that but think it isn't a pressing issue
> either and the ultimate decision has to come from Dave.

I'm just helping in migrating users that are still using ide to libata,
enhancing libata's hardware support in the process. I would prefer to
have ide removed in the long-term (once there are no known users of
it) but Dave has a valid point (see below).  This particular patch is
more a by-product of the above work than a part of it itself.

Dave's current opinion is that we can't prove that all configurations
currently supported by ide are supported by libata.  Since it can never
be really proved (as there are ide drivers for hardware that cannot be
tested because of having no active users) he is fine with ide staying
in the kernel forever. Which may be not as bad for me personally as
I have a lot of contributions there. ;-)

Theoretically another option is to finish ide's evolution into "ide
compat" layer for SCSI/libata. This would give us full git history from
ide to libata support + thin compatibility layer. However with libata
PATA availability and hardware being obsolete there is no real need
for it and the cost to finish such transition is much higher than cost
of ide staying in the kernel forever. Moreover it would need to happen
outside of the upstream kernel and there are no guarantees that it
would be ever merged (ide is in deep maintenance policy and treated
as a "safe fallback" for libata; SCSI & libata changes would need to
be agreed on).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
