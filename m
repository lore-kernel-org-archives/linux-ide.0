From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/4] R-Car SATA driver and platform data
Date: Mon, 18 Feb 2013 10:23:22 +0900
Message-ID: <20130218012322.GA11807@verge.net.au>
References: <201302170135.28336.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201302170135.28336.sergei.shtylyov@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: magnus.damm@gmail.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org
List-Id: linux-ide@vger.kernel.org

On Sun, Feb 17, 2013 at 01:35:27AM +0300, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 4 patches against the Simon Horman's renesas.git repo, 'next' branch:
> 
> [1/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
> [2/4] ARM: mach-shmobile: r8a7779: add SATA support
> [3/4] libata: add R-Car SATA driver
> [4/4] ARM: mach-shmobile: marzen: add SATA support
> 
> Patch 3 also applies to the 'upstream' branch of Jeff Garzik's libata-dev.git repo.

Hi Sergei, Hi All,

I do not expect patch 3 of this series to got through
the renesas tree, however, I have included it and the other three patches
in this series to a topic branch in the renesas tree, topic/r-car-stat.

The base of the topic branch is:
* a merge of renesas.git next and libata-dev.git upstream, and;
* a boot fix for Marzen which I plan to add to next once it is reviewed:
  "ARM: shmobile: r8a7779: Correct TMU clock support again" (v3).

With this in place I built a kernel using the marzen_defconfig and booted it.
However, I wonder if I am missing a kernel option, or perhaps something
else of a minor nature as I see the following:

# dmesg | grep sata
sata_rcar sata_rcar: coherent DMA mask is unset
sata_rcar sata_rcar: failed to start port 0 (errno=-12)
sata_rcar: probe of sata_rcar failed with error -12


