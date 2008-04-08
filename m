From: "Peter Gervai" <grinapo@gmail.com>
Subject: Re: Hard freeze / interrupt-related death / instability
Date: Wed, 9 Apr 2008 00:02:09 +0200
Message-ID: <d55656c10804081502s52c61c7eo623cd9b6255613bb@mail.gmail.com>
References: <d55656c10804080627r6cb7ba2ao37476b602e4f157e@mail.gmail.com>
	 <1207687673.3091.12.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1207687673.3091.12.camel@linux-2bdv.site>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Apr 8, 2008 at 10:47 PM, Thomas Renninger <trenn@suse.de> wrote:
> Hi,
>
>  I expect this is more a ata/ahci or chipset problem (this is ICH7,
>  right?),

Yes.

>  maybe ide list has an idea or has seen something similar already?

Good point, let's see.

>  Two more little comments below.

>  > Then one page started to suggest to play with acpi switches on boot, and I went
>  > on. The results:
>  >
>  > #irqpoll                        - dies eventually
>  > #noapic irqpoll pci=nommconf    - dies eventually
>  > #pci=noacpi                     - dies eventually
>  > #noacpi                         - dies eventually, but it took longest (3 days)
>  >
>  > #acpi=off                       - uniprocessor, ok
>  > #noapic acpi=off                - uniprocessor, ok
>  What means uniprocessor?
>  Also added nosmp or maxcpus=1?

Oh, maybe forgot to explain this one (copypaste from my grub menu.lst
:)). It means the machine didn't freeze but the kernel completely
ignored the second core of the dual core cpu, basically seem to have
ignored SMP capability altogether. I did not use nosmp or maxcpu since
I do want to use them all. :)

>  Maybe pci=nomsi helps?

I note that, and try it the next time.

Thanks,
Peter
