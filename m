From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 0/5] Support for Marvell AHCI interface on Armada 38x
Date: Mon, 14 Apr 2014 18:19:20 +0200
Message-ID: <20140414181920.1e309019@skate>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <16639486.i0jTGsaDYr@amdc1032> <20140414180142.0dd63a1f@skate>
 <10589751.qhi630WAFs@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <10589751.qhi630WAFs@amdc1032>
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
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, linux-ide@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

Dear Bartlomiej Zolnierkiewicz,

On Mon, 14 Apr 2014 18:13:07 +0200, Bartlomiej Zolnierkiewicz wrote:
> On Monday, April 14, 2014 06:01:42 PM Thomas Petazzoni wrote:
> > Dear Bartlomiej Zolnierkiewicz,
> > 
> > On Mon, 14 Apr 2014 17:53:37 +0200, Bartlomiej Zolnierkiewicz wrote:
> > 
> > > >  * Fixed the module alias name. Suggested by Bartlomiej
> > > >    Zolnierkiewicz.
> > > 
> > > Well, you could have also added a comment explaining the lack of
> > > the Power Management support..
> > 
> > True, sorry for this. Should I resend a new version of the patch series
> > with an indication about this in the commit log? Or is this OK as it is?
> 
> Please include the comment in the next revision if this is not too much
> trouble (I assume that you would like to do another re-spin just to add
> Acked-by/Reviewed-by tags anyway).

Well, I wasn't planning on re-spinning just to add Acked-by/Reviewed-by
tags, as those are generally added by the subsystem maintainers when
applying the patches. Though if Tejun says otherwise, I can definitely
re-spin without any problem.

Tejun, just let me know what you prefer.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
