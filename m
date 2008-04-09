From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Hard freeze / interrupt-related death / instability
Date: Wed, 09 Apr 2008 17:40:09 +0800
Message-ID: <1207734009.16101.5.camel@yakui_zhao.sh.intel.com>
References: <d55656c10804080627r6cb7ba2ao37476b602e4f157e@mail.gmail.com>
	 <1207687673.3091.12.camel@linux-2bdv.site>
	 <d55656c10804081502s52c61c7eo623cd9b6255613bb@mail.gmail.com>
	 <47FBEE45.8010900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <47FBEE45.8010900@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>, Peter Gervai <grinapo@gmail.com>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Wed, 2008-04-09 at 02:14 +0400, Alexey Starikovskiy wrote:
> Peter Gervai wrote:
> >
> >>  > #acpi=off                       - uniprocessor, ok
> >>  > #noapic acpi=off                - uniprocessor, ok
> >>  What means uniprocessor?
> >>  Also added nosmp or maxcpus=1?
> >>     
> >
> > Oh, maybe forgot to explain this one (copypaste from my grub menu.lst
> > :)). It means the machine didn't freeze but the kernel completely
> > ignored the second core of the dual core cpu, basically seem to have
> > ignored SMP capability altogether. I did not use nosmp or maxcpu since
> > I do want to use them all. :)
> >
> >   
> This is expected, there are two ways to find second CPU -- with MP 
> tables and ACPI.
> New machines do not carry MP tables, so if you disable ACPI, second CPU 
> remains
> unknown to the system.
> 
What Alexey said is right. There is no MPS table on this laptop. And
when acpi is disabled, the second CPU will be unknown to the system.

Will you please attach the acpidump output? (
Latest pmtools can be found at
http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/ )

Will you please try the boot option of "noapic acpi_irq_nobalance" ?
Thanks.


> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

