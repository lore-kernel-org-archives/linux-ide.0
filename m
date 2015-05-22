From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 2/2] drivers: ata: add support for Ceva sata host
 controller
Date: Fri, 22 May 2015 11:34:24 +0200
Message-ID: <1432287264.27695.72.camel@x220>
References: <1432180625-25159-1-git-send-email-suneel.garapati@xilinx.com>
	 <1432180625-25159-3-git-send-email-suneel.garapati@xilinx.com>
	 <20150521215744.GE4914@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150521215744.GE4914@htj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Suneel Garapati <suneel.garapati@xilinx.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, michals@xilinx.com, sorenb@xilinx.com, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-ide@vger.kernel.org

[Adding Bjorn.]

> On Thu, May 21, 2015 at 09:27:05AM +0530, Suneel Garapati wrote:
> > --- /dev/null
> > +++ b/drivers/ata/ahci_ceva.c

> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along with
> > + * this program. If not, see <http://www.gnu.org/licenses/>.

> > +MODULE_LICENSE("GPLv2");

You meant "GPL v2".

"GPLv2" is not one of the idents that pass license_is_gpl_compatible().
Loading a module with that ident should trigger a warning and taint the
kernel. See linux/module.h (or linux/license.h) for acceptable idents.

This is a bit of a gotcha. A patch that would have helped here was
posted in https://lkml.org/lkml/2015/4/7/824 . I don't know why that
patch didn't make it into checkpatch.pl. Bjorn?

Thanks,


Paul Bolle
