From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Fri, 11 Apr 2008 15:05:58 +0900
Message-ID: <47FEFFC6.4@gmail.com>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <200804030704.21480.volker.armin.hemmann@tu-clausthal.de> <47F46A74.504@gmail.com> <200804031347.20352.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757859AbYDKGG3@vger.kernel.org>
In-Reply-To: <200804031347.20352.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>
List-Id: linux-ide@vger.kernel.org

Volker Armin Hemmann wrote:
> From systemrescuecd, ahci in bios, no nomsi:
>            CPU0       CPU1       
>   0:        147          1   IO-APIC-edge      timer
>   1:          0        607   IO-APIC-edge      i8042
>   8:          0         61   IO-APIC-edge      rtc
>   9:          0          1   IO-APIC-fasteoi   acpi
>  12:          0          4   IO-APIC-edge      i8042
>  14:          0          0   IO-APIC-edge      libata
>  15:          0          0   IO-APIC-edge      libata
>  18:          0         16   IO-APIC-fasteoi   aic7xxx
>  21:          0          0   IO-APIC-fasteoi   ohci_hcd:usb2
>  22:          2       8428   IO-APIC-fasteoi   ehci_hcd:usb1
> 1274:          0          0   PCI-MSI-edge      ahci
> 1275:          0        222   PCI-MSI-edge      eth0
> NMI:          0          0   Non-maskable interrupts
> LOC:      14777      16785   Local timer interrupts
> RES:       7250       6100   Rescheduling interrupts
> CAL:         41         52   function call interrupts
> TLB:       1866       1876   TLB shootdowns
> TRM:          0          0   Thermal event interrupts
> THR:          0          0   Threshold APIC interrupts
> SPU:          0          0   Spurious interrupts
> ERR:          6
> 
> With my 'own' kernel, AHCI has interrupt 315. I will try and make a more 
> monolithic kernel so I might be able to boot from a usb-flash device.
> .
> .
> .
> which didn't work. Hm, I am too stupid for that today...

Hmmm...

>>> I will reboot from systemresucecd later today and post some results with
>>> ahci-mode set, no nomsi. Just can't try patches that way.
>> Is sytemrescuecd using the same kernel?  Otherwise, it will only add
>> more to the confusion.
> 
> almost.  A heavily patched 2.6.24.2. That is why I don't sent a dmesg ... just 
> cat /proc/interrupts. I can send you lspci -vv and dmesg from systemrescuecd 
> if you want.

Aiee.... Can you please try 2.6.25-rc8 with both configurations?  And 
w/o systemrescuecd?  Just seeing whether things mount properly or not is 
good enough.  There isn't much risk of losing data.

-- 
tejun
