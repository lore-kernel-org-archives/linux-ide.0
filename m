From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/4] R-Car SATA driver and platform data
Date: Tue, 26 Feb 2013 09:07:09 +0900
Message-ID: <20130226000709.GB16202@verge.net.au>
References: <201302182327.46930.sergei.shtylyov@cogentembedded.com>
 <20130219034210.GA7701@verge.net.au>
 <512B6243.9060808@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <512B6243.9060808@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: magnus.damm@gmail.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, vladimir.barinov@cogentembedded.com
List-Id: linux-ide@vger.kernel.org

On Mon, Feb 25, 2013 at 05:08:19PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 19-02-2013 7:42, Simon Horman wrote:
> 
> >>    Here's the v2 of the set of 4 patches against the Simon Horman's renesas.git
> >>repo, 'next' branch:
> 
> >>[1/4] libata: add R-Car SATA driver
> >>[2/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
> >>[3/4] ARM: mach-shmobile: r8a7779: add SATA support
> >>[4/4] ARM: mach-shmobile: marzen: add SATA support
> 
> >>Patch 1 also applies to the 'upstream' branch of Jeff Garzik's libata-dev.git
> >>repo.
> 
> >>Patch changes since the initial posting are reported in the individual patches.
> 
> >Thanks, I have updated topic/r-car-sata and verified
> >that the SATA driver is successfully initialised for both
> >non-DT and DT boot.
> 
>    The SATA driver have been already merged by Linus:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=163cf81d266f017d718ef786fbbb6b2513ce7ec3
> 
> Can we merge the rest of the patches in this merge window?

Unfortunately the path for patches for shmobile is long, arduous and
out of my control.

I will merge the remaining patches into the renesas tree ASAP
and push them to arm-soc for v3.10.
