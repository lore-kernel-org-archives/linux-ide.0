From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
Date: Wed, 17 Feb 2016 10:57:50 -0800
Message-ID: <56C4C2AE.90009@caviumnetworks.com>
References: <1455319230-30201-1-git-send-email-tchalamarla@caviumnetworks.com> <20160214170152.GC3965@htj.duckdns.org> <56C147B2.9010303@caviumnetworks.com> <20160215183041.GH3965@htj.duckdns.org> <20160216144250.GD31343@rric.localdomain> <56C37524.5090000@caviumnetworks.com> <56C37AD3.4030407@caviumnetworks.com> <56C37D94.8080403@caviumnetworks.com> <20160216211410.GI25086@rric.localdomain> <56C3AD1C.2000003@caviumnetworks.com> <20160217112931.GB31970@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160217112931.GB31970@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>, stripathi@apm.com, David Daney <ddaney@caviumnetworks.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Robert Richter <rric@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 02/17/2016 03:29 AM, Will Deacon wrote:
> On Tue, Feb 16, 2016 at 03:13:32PM -0800, Tirumalesh Chalamarla wrote:
>> On 02/16/2016 01:14 PM, Robert Richter wrote:
>>> CONFIG_CAVIUM_ERRATUM_22536 is exactly that you need. It is not only
>>> used for core interrupts, e.g. also for gicv3 devices (and now also
>>> for ahci). Non-core errata (e.g. CONFIG_CAVIUM_ERRATUM_23144) are not
>>> enabled in the arm64 cpu errata framework (not handled in
>>> arch/arm64/kernel/cpu_errata.c).
>>>
>>> Thus,
>>>
>>> #ifdef CONFIG_CAVIUM_ERRATUM_22536
>>> 	if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
>>> 		ahci_thunderx_init(&pdev->dev, hpriv);
>>> #endif
>>>
>>> is the correct enablement of the workaround by device id.
>>>
>>> And, CAVIUM_ERRATUM_* is very easy to handle, enable and document.
>>>
>> The code will only run for Thunder and AHCI, becuase its PCI.
>
> Well, the guards also serve as documentation for exactly why we're having
> to do something special here, so I'd say go ahead and add
> CONFIG_CAVIUM_ERRATUM_22536 and update
> Documentation/arm64/silicon-errata.txt accordingly.
>

If the ahci/ata maintainers insist, we can add that.

<sarcasm>
Should we also add some CONFIG_ variables for:

   ahci_mcp89_apple_enable()
   ahci_sb600_enable_64bit()
   ahci_p5wdh_workaround()
   .
   .
   .

Surely we would wish to give people the flexibility to trim that code 
out of the driver if they know that it is not needed.

And don't even get me started on drivers/pci/quirks.c ...

</sarcasm>


>
>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
