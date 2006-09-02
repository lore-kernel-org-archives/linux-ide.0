From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.18-rc5-mm1
Date: Sat, 02 Sep 2006 01:37:13 -0700
Message-ID: <44F942B9.6050102@goop.org>
References: <20060901015818.42767813.akpm@osdl.org>	<1157158847.20509.10.camel@mhcln03> <20060901183028.1c6da4df.akpm@osdl.org> <44F93EB3.8050500@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <44F93EB3.8050500@goop.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Matthias Hentges <oe@hentges.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Greg KH <gregkh@suse.de>
List-Id: linux-ide@vger.kernel.org

Jeremy Fitzhardinge wrote:
> The NULL EIP is desc->handle_irq in do_IRQ():
>
>         asm volatile(
>             "       xchgl  %%ebx,%%esp      \n"
>             "       call   *%%edi           \n"
>             "       movl   %%ebx,%%esp      \n"
>             : "=a" (arg1), "=d" (arg2), "=c" (arg3), "=b" (ebx)
>             :  "0" (irq),   "1" (desc),  "2" (regs),  "3" (isp),
>                "D" (desc->handle_irq)
>             : "memory", "cc"
>         );
>
> In my case, the IRQ is 0xdb = 219, which is an MSI interrupt for 
> libata (the AHCI SATA controller, presumably).  The exception happens 
> just after the SATA driver has probed all the hard disks.
>
> So it seems to me that the suspects are 1) sata, or 2) MSI.  I'll try 
> turning off MSI to see if it helps.

Yes, that fixed it; with MSI disabled I can boot successfully.

: ezr:pts/0; cd hg/linux-2.6/patches/broken-out/
: ezr:pts/0; ls *msi* | wc -l
23

Hm, where to start...

    J

-- 
VGER BF report: H 0
