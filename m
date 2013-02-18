From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 0/4] R-Car SATA driver and platform data
Date: Mon, 18 Feb 2013 18:04:21 +0400
Message-ID: <512234E5.5050700@cogentembedded.com>
References: <201302170135.28336.sergei.shtylyov@cogentembedded.com> <20130218012322.GA11807@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20130218012322.GA11807@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: magnus.damm@gmail.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 18-02-2013 5:23, Simon Horman wrote:

>>     Here's the set of 4 patches against the Simon Horman's renesas.git repo, 'next' branch:

>> [1/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
>> [2/4] ARM: mach-shmobile: r8a7779: add SATA support
>> [3/4] libata: add R-Car SATA driver
>> [4/4] ARM: mach-shmobile: marzen: add SATA support

>> Patch 3 also applies to the 'upstream' branch of Jeff Garzik's libata-dev.git repo.

> Hi Sergei, Hi All,

> I do not expect patch 3 of this series to got through
> the renesas tree, however, I have included it and the other three patches
> in this series to a topic branch in the renesas tree, topic/r-car-stat.

    I probably make the patch 3 patch 1 in the next posting.

> The base of the topic branch is:
> * a merge of renesas.git next and libata-dev.git upstream, and;
> * a boot fix for Marzen which I plan to add to next once it is reviewed:
>    "ARM: shmobile: r8a7779: Correct TMU clock support again" (v3).

> With this in place I built a kernel using the marzen_defconfig and booted it.
> However, I wonder if I am missing a kernel option, or perhaps something
> else of a minor nature as I see the following:

> # dmesg | grep sata
> sata_rcar sata_rcar: coherent DMA mask is unset
> sata_rcar sata_rcar: failed to start port 0 (errno=-12)
> sata_rcar: probe of sata_rcar failed with error -12

    No, it's entirely our fault -- Vladimir didn't test the driver in non-DT 
mode with DMA support added (due to the above mentioned boot fix missing), and 
I didn't notice the missing intializers for 
'sata_device.dev.[coherent_]dma_mask' when reviewing his patches. V2 will be 
posted soon.

WBR, Sergei

