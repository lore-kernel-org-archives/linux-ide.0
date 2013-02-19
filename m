From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/4] R-Car SATA driver and platform data
Date: Tue, 19 Feb 2013 12:42:12 +0900
Message-ID: <20130219034210.GA7701@verge.net.au>
References: <201302182327.46930.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201302182327.46930.sergei.shtylyov@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: magnus.damm@gmail.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, vladimir.barinov@cogentembedded.com
List-Id: linux-ide@vger.kernel.org

On Mon, Feb 18, 2013 at 11:27:46PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the v2 of the set of 4 patches against the Simon Horman's renesas.git
> repo, 'next' branch:
> 
> [1/4] libata: add R-Car SATA driver
> [2/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
> [3/4] ARM: mach-shmobile: r8a7779: add SATA support
> [4/4] ARM: mach-shmobile: marzen: add SATA support
> 
> Patch 1 also applies to the 'upstream' branch of Jeff Garzik's libata-dev.git
> repo.
> 
> Patch changes since the initial posting are reported in the individual patches.

Thanks, I have updated topic/r-car-sata and verified
that the SATA driver is successfully initialised for both
non-DT and DT boot.
