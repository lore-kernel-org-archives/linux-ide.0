From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4/5] sata, highbank: set tx_atten override bits
Date: Tue, 30 Jul 2013 17:42:31 +0100
Message-ID: <20130730164231.GH29859@e106331-lin.cambridge.arm.com>
References: <1374851518-4802-1-git-send-email-mark.langsdorf@calxeda.com>
 <1374851518-4802-4-git-send-email-mark.langsdorf@calxeda.com>
 <20130726162231.GD3528@e106331-lin.cambridge.arm.com>
 <51F2C220.5040407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51F2C220.5040407@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>
List-Id: linux-ide@vger.kernel.org

On Fri, Jul 26, 2013 at 07:38:24PM +0100, Rob Herring wrote:
> On 07/26/2013 11:22 AM, Mark Rutland wrote:
> > On Fri, Jul 26, 2013 at 04:11:57PM +0100, Mark Langsdorf wrote:
> >> Some board designs do not drive the SATA transmit lines within the
> >> specification. The ECME can provide override settings, on a per board
> >> basis, to bring the transmit lines within spec. Read those settings
> >> from the DTB and program them in.
> > 
> > How variable is the use of this property going to be? Would it instead
> > be possible to decide that this was necessary, and choose the
> > appropriate values based on a compatible property?
> 
> It is based on compliance testing of the particular board design. Basing
> on a compatible property would not work in this case.

Ok. Could you clarify the u8/cell usage in the binding and amend the
example please?

Cheers,
Mark.
