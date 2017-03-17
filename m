From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_pcmcia: add EBSA110's PCMCIA slot support
Date: Fri, 17 Mar 2017 10:13:13 -0400
Message-ID: <20170317141313.GC5078@htj.duckdns.org>
References: <CGME20170314175046epcas1p43f98daad14a2bac7f314e7d39e120232@epcas1p4.samsung.com>
 <1533391.BtkrkgvqUW@amdc3058>
 <20170317133900.GA5078@htj.duckdns.org>
 <11380780.Ccg1NEX8q5@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <11380780.Ccg1NEX8q5@amdc3058>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hello,

On Fri, Mar 17, 2017 at 03:08:56PM +0100, Bartlomiej Zolnierkiewicz wrote:
> To be honest, the main point here is to make Russell happy. ;-)
> 
> This is the second time he brought EBSA110 issue while talking about
> conversion of ARM platforms to use libata PATA so I've finally decided
> to do the patch just to have a reference example of how to deal with
> this and similar devices in a proper way.
> 
> Even though the patch can't be tested EBSA110 is still a supported ARM
> platform and the patch should work fine in theory (+ it cannot break
> anything).  OTOH it adds an extra code which has some cost from the
> long-term maintenance POV.  Anyway, it is up to you to decide what to
> do with it. :-)

It's fairly low impact and I don't think it's gonna add noticeable
maintenance overhead at all, so that part is fine but it's super weird
to add code which we know not to have any users.  It looks like we
can't even test it.

What's the end game here?  Is it part of the effort to remove ide?  If
so, I have no objection to that but think it isn't a pressing issue
either and the ultimate decision has to come from Dave.

Thanks.

-- 
tejun
