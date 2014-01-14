From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
Date: Tue, 14 Jan 2014 10:59:45 -0500
Message-ID: <20140114155945.GQ19878@titan.lakedaemon.net>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <20140114151404.GN19878@titan.lakedaemon.net>
 <20140114154834.GD32507@kw.sim.vm.gnt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140114154834.GD32507@kw.sim.vm.gnt>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org, linux-ide@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Tejun Heo <tj@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Jeff Garzik <jgarzik@redhat.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

Simon,

On Tue, Jan 14, 2014 at 04:48:34PM +0100, Simon Guinot wrote:
> On Tue, Jan 14, 2014 at 10:14:04AM -0500, Jason Cooper wrote:
> > Simon,
> > 
> > On Tue, Jan 14, 2014 at 03:50:04PM +0100, Simon Guinot wrote:
> > > Hello,
> > > 
> > > This patch series fixes a SATA disk hotplug issue for the Armada 370/XP
> > > SoCs: once a disk is removed from a SATA port, then the re-plug events
> > > are not detected by the sata_mv driver.
> > > 
> > > This should be applied to the -stable kernels 3.10 and onwards. 
> > 
> > Please add a 'Fixes: <commit-hash> (oneline)' tag below the Cc: stable
> > tags.  It looks like the sata_mv binding and the Armada 370 DT booting
> > were both introduced in v3.6, so I would probably use:
> > 
> > Fixes: 9ae6f740b49f (arm: mach-mvebu: add support for Armada 370 and Armada XP with DT)
> 
> Hi Jason,
> 
> I am not comfortable with this "Fixes: commit_id" notation. It states
> that the patch fixes a regression introduced by a given commit. This
> hardly makes sense to me because obviously the hotplug issue has not
> been introduced by:
> 
> "arm: mach-mvebu: add support for Armada 370 and Armada XP with DT".
> 
> I know that the purpose is purely administrative, but it is kind of
> weird...

True, the wording may not be the best, but the goal is to make it easier
to do a 'tag --contains' search.  We could call it

Repair-Something-Broken-Since-Introduced-by:

in this case ;-)

> > Is there a specific reason you say v3.10?
> 
> I could have said nothing as well.
> 
> As stable kernel older than 3.10 are no longer maintained, I think
> we don't need to point out a specific commit as a -stable target.
> Simply Cc'ing -stable without any extra informations should be good
> enough.

The reason I ask is that I'd like to know if, in debugging this issue,
you discovered that the fix was not needed before v3.10 (hypothetically,
say because sata hotplug was added in v3.10).

The linux-stable team isn't the only people who find this information
useful.  Distros maintaining older kernels would find it very helpful
when going through -stable patches to know easily if a patch should be
backported further, say to v3.8.

thx,

Jason.
