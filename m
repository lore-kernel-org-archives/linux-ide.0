From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 3/4] SATA: MV: Add support for the optional PHYs
Date: Thu, 19 Dec 2013 22:25:45 -0500
Message-ID: <20131220032545.GE2609@titan.lakedaemon.net>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
 <1387311713-1926-3-git-send-email-andrew@lunn.ch>
 <52B140F2.8070900@ti.com> <20131219190329.GH4143@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20131219190329.GH4143@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Dec 19, 2013 at 08:03:29PM +0100, Andrew Lunn wrote:
> On Wed, Dec 18, 2013 at 12:00:10PM +0530, Kishon Vijay Abraham I wrote:
> > Hi Tejun,
> > 
> > On Wednesday 18 December 2013 01:51 AM, Andrew Lunn wrote:
> > > Some Marvell SoCs have a SATA PHY which can be powered off, in order
> > > to save power. Make use of the generic phy framework to control these
> > > phys.
> > 
> > I can queue this patch along with the other patches in this series if you don't
> > expect any merge issues.
> 
> Hi Kishon
> 
> I expect merge issues with the DT and the DT binding documentation. It
> would be best if Jason took those parts.

I'd prefer to keep the DT binding docs with the driver patches.

thx,

Jason.
