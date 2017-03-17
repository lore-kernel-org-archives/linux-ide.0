From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_pcmcia: add EBSA110's PCMCIA slot support
Date: Fri, 17 Mar 2017 09:39:00 -0400
Message-ID: <20170317133900.GA5078@htj.duckdns.org>
References: <CGME20170314175046epcas1p43f98daad14a2bac7f314e7d39e120232@epcas1p4.samsung.com>
 <3458240.9SL7iGif3L@amdc3058>
 <20170316212654.GD1480@htj.duckdns.org>
 <1533391.BtkrkgvqUW@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1533391.BtkrkgvqUW@amdc3058>
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

On Fri, Mar 17, 2017 at 12:59:56PM +0100, Bartlomiej Zolnierkiewicz wrote:
> There is no support for this device in the upstream ide driver but
> Russell has a hacky patch to make it work by redefining inb()/outb()
> operations globally for the whole ide subsystem, please see:
> 
> https://www.spinics.net/lists/arm-kernel/msg567454.html

Well, that mail says that the hardware is a museum piece.  What's the
point here?  This can't even be tested, can it?

Thanks.

-- 
tejun
