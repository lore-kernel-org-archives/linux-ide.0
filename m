From: "Paul Rolland" <rol@as2917.net>
Subject: RE: [git patches] libata fixes
Date: Sun, 11 Mar 2007 20:20:31 +0100
Message-ID: <018901c76412$56bc2bf0$2101a8c0@donald>
References: <017f01c7640b$fbcafab0$2101a8c0@donald>
Reply-To: <rol@as2917.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964873AbXCKTUj@vger.kernel.org>
In-Reply-To: <017f01c7640b$fbcafab0$2101a8c0@donald>
Sender: linux-kernel-owner@vger.kernel.org
To: rol@as2917.net, 'Linus Torvalds' <torvalds@linux-foundation.org>
Cc: 'Tejun Heo' <htejun@gmail.com>, 'Jeff Garzik' <jeff@garzik.org>, 'Andrew Morton' <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>
List-Id: linux-ide@vger.kernel.org

Just one point that may be interesting, as it seems that this is IRQ
related : at the beginning of the dmesg, it seems that IRQ16 is used
for sky2/Yukon , but when reading /proc/interrupts, it has been remapped
to IRQ 505... Could this also affect libata ?

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur 
"Some people dream of success... while others wake up and work hard at it" 

"I worry about my child and the Internet all the time, even though she's too 
young to have logged on yet. Here's what I worry about. I worry that 10 or 15 
years from now, she will come to me and say 'Daddy, where were you when they 
took freedom of the press away from the Internet?'"
--Mike Godwin, Electronic Frontier Foundation 
  

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Paul Rolland
> Sent: Sunday, March 11, 2007 7:35 PM
> To: 'Linus Torvalds'
> Cc: 'Tejun Heo'; 'Jeff Garzik'; 'Andrew Morton'; 
> linux-ide@vger.kernel.org; 'LKML'; 'Eric D. Mudama'
> Subject: RE: [git patches] libata fixes
> 
> Hello,
> 
> >  do I understand correctly that the *only* difference between 
> > the working 
> > setup is that you applied (by hand) the libata patch that 
> > Jeff sent out?
> > 
> > So plain 2.6.21-rc2 works fine, but with the patch applied, 
> > you get no 
> > interrupts on the DVD drive?
> 
> Nope... I tried several patches from Tejun, and also some 
> that Jeff posted
> to linux-ide, but no luck. The only way to have this DVD-RW 
> working is to
> use irqpoll on the command line...
> 
> Sorry to have been unclear....
> 
> To complete, here are some more output from the machine : 
>  - a dmesg without irqpoll,
>  - a dmesg with irqpoll,
>  - a copy of /proc/interrupts
> 6 [19:33] rol@riri:~> cat /proc/interrupts 
>            CPU0       CPU1       
>   0:     357022          0   IO-APIC-edge      timer
>   1:          8          0   IO-APIC-edge      i8042
>   4:         14          0   IO-APIC-edge      serial
>   6:          5          0   IO-APIC-edge      floppy
>   8:          1          0   IO-APIC-edge      rtc
>   9:          0          0   IO-APIC-fasteoi   acpi
>  12:        129          0   IO-APIC-edge      i8042
>  14:       7639          0   IO-APIC-edge      libata
>  15:          0          0   IO-APIC-edge      libata
>  16:          0          0   IO-APIC-fasteoi   libata
>  17:          0          0   IO-APIC-fasteoi   uhci_hcd:usb3
>  18:          0          0   IO-APIC-fasteoi   uhci_hcd:usb4
>  19:        204          0   IO-APIC-fasteoi   uhci_hcd:usb5, 
> HDA Intel
>  20:        107          0   IO-APIC-fasteoi   ehci_hcd:usb1, 
> uhci_hcd:usb2
>  21:          3          0   IO-APIC-fasteoi   ohci1394
> 504:       8243          0   PCI-MSI-edge      libata
> 505:          1          0   PCI-MSI-edge      eth1
> 506:        386          0   PCI-MSI-edge      eth0
> NMI:        771        531 
> LOC:     569318     578684 
> ERR:          0
> 
> Regards,
> Paul
> 
