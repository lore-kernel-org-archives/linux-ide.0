From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 0/2] ahci/pci-quirks: Add PCI-id for the Highpoint
 Rocketraid 644L card
Date: Fri, 2 Mar 2018 13:29:07 -0600
Message-ID: <20180302192907.GB202062@bhelgaas-glaptop.roam.corp.google.com>
References: <20180302103633.10592-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180302103633.10592-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Mar 02, 2018 at 11:36:31AM +0100, Hans de Goede wrote:
> Hi All,
> 
> Here are 2 patches adding support for Highpoint Rocketraid 644L cards,
> they can be merged independently from each-other into their resp. subsys,
> but since they belong together I'm sending them out as a series.

Seems like it'd be nice to keep these together, so Tejun, feel free to
take both patches with my

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

on the pci/quirks.c patch.  If you'd prefer me to take them, just let
me know.
