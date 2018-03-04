From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/2] ahci/pci-quirks: Add PCI-id for the Highpoint
 Rocketraid 644L card
Date: Sun, 4 Mar 2018 12:36:40 -0800
Message-ID: <20180304203640.GF231488@devbig577.frc2.facebook.com>
References: <20180302103633.10592-1-hdegoede@redhat.com>
 <20180302192907.GB202062@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180302192907.GB202062@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Mar 02, 2018 at 01:29:07PM -0600, Bjorn Helgaas wrote:
> On Fri, Mar 02, 2018 at 11:36:31AM +0100, Hans de Goede wrote:
> > Hi All,
> > 
> > Here are 2 patches adding support for Highpoint Rocketraid 644L cards,
> > they can be merged independently from each-other into their resp. subsys,
> > but since they belong together I'm sending them out as a series.
> 
> Seems like it'd be nice to keep these together, so Tejun, feel free to
> take both patches with my
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> on the pci/quirks.c patch.  If you'd prefer me to take them, just let
> me know.

Applied both to libata/for-4.16-fixes with ack added.

Thanks.

-- 
tejun
