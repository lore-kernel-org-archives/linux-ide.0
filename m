From: Jacek Luczak <difrost.kernel@gmail.com>
Subject: Re: Suspend to memory is freezing my machine
Date: Sun, 04 May 2008 20:52:39 +0200
Message-ID: <481E05F7.5010504@gmail.com>
References: <fa.4esVkXHbwOL+Pzatd+lYSGawfns@ifi.uio.no> <fa.zsdi5UBi6URzBaRSfFXIc6F7kHk@ifi.uio.no> <fa.plXIUcQIe19WMbpH4aKYo6JX1RQ@ifi.uio.no> <481DF438.30307@shaw.ca> <481DF570.8050700@gmail.com> <481DF9E1.8050008@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757879AbYEDS5q@vger.kernel.org>
In-Reply-To: <481DF9E1.8050008@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Robert Hancock pisze:
> Jacek Luczak wrote:
>> Robert Hancock pisze:
>>> Jacek Luczak wrote:
>>>> Rafael J. Wysocki pisze:
>>>>> On Sunday, 4 of May 2008, Zdenek Kabelac wrote:
>>>>>> Hello
>>>>> Hi,
>>>>>
>>>>>> With recent 2.6.25 & 2.6.26-rc1 git (around 1 week) I get
>>>>>> occasionally
>>>>>> complete freeze of my T61 during suspend. (dual core, 2GB).
>>>>> How reproducible is this?
>>>>>
>>>>>> I'm running kernel with no_console_suspend - but all I can see is
>>>>>> blinking cursor on an empty screen - thus even when I run kernel with
>>>>>> most debug options turned on, I can't pass more details so far.  I
>>>>>> run
>>>>>> suspend with with SD card in - so maybe some update in the MMC driver
>>>>>> might be responsible for this ?
>>>>>>
>>>>>> Also - I think that option no_console_suspend doens't work
>>>>>> correctly -
>>>>>> as many times with suspend I do not see any log message on my console
>>>>>> screen. However sometimes the log is shown.
>>>>> It would be helpful if you could verify if:
>>>>>
>>>>> (1) The problem occurs without no_console_suspend.
>>>>> (2) The problem occurs without the SD card.
>>>>>
>>>> Hi Rafael,
>>>>
>>>> same problem here, although I was able to resume system (it's
>>>> basically Intel
>>>> machine) , but it was unusable - I was able to switch between
>>>> terminals and see
>>>> output from kernel. So there was:
>>>>     - Disabling irq #19;
>>>>     - some kind of lock spinning on disk:
>>>> IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA
>>>> Storage
>>>> Controller IDE (rev 02)
>>>>     but I can't provide more output of that lock now - no sign in logs.
>>>>
>>>> I've made some successful suspend/resume all without sound card active
>>>> without
>>>> problem. Those appear with sound card active, but I must take closer
>>>> look - will
>>>> send info later.
>>> Can you post your dmesg and /proc/interrupts output from normal bootup ?
>>
>> Sure I can ;)
>>
>> 1) /proc/interrupts
>>
>>            CPU0       CPU1
>>   0:   11846981          0   IO-APIC-edge      timer
>>   1:      30098          0   IO-APIC-edge      i8042
>>   8:          3          0   IO-APIC-edge      rtc
>>   9:         13          0   IO-APIC-fasteoi   acpi
>>  12:    1776540          0   IO-APIC-edge      i8042
>>  14:         39          0   IO-APIC-edge      ata_piix
>>  15:          0          0   IO-APIC-edge      ata_piix
>>  16:      54570      44642   IO-APIC-fasteoi   i915@pci:0000:00:02.0
>>  17:          0          0   IO-APIC-fasteoi   uhci_hcd:usb3
>>  18:          0          0   IO-APIC-fasteoi   uhci_hcd:usb4
>>  19:      98243          0   IO-APIC-fasteoi   ata_piix, uhci_hcd:usb5
>>  21:    1650574          0   IO-APIC-fasteoi   HDA Intel
>>  23:          0          0   IO-APIC-fasteoi   ehci_hcd:usb1,
>> uhci_hcd:usb2
>> 220:      14263          0   PCI-MSI-edge      iwl3945
>> 221:    1166041    1333296   PCI-MSI-edge      eth0
>> NMI:          0          0   Non-maskable interrupts
>> LOC:    1104887    7534969   Local timer interrupts
>> RES:     633378     701351   Rescheduling interrupts
>> CAL:         16      28315   function call interrupts
>> TLB:       1721       2620   TLB shootdowns
>> TRM:          0          0   Thermal event interrupts
>> SPU:          0          0   Spurious interrupts
>> ERR:          0
>> MIS:          0
>>
>> 2) dmesg can here -> http://212.109.128.251/~difrost/linux-next/dmesg.log
>> 3) Kernel:
>> Linux difrost 2.6.25-07422-gb66e1f1-dirty #14 SMP Fri May 2 22:04:17
>> CEST 2008
>> i686 i686 i386 GNU/Linux
>> It's marked dirty because due to http://lkml.org/lkml/2008/5/2/405
>> patch applied.
>>
>> -Jacek
>>
> 
> Well, if IRQ 19 got disabled, that's your SATA controller, so resume
> likely isn't going to work. Could be a libata problem? CCing linux-ide.

Yep, I know, that's why I pointed that out. Irq was disabled somehow in suspend
or resume process.

> BTW, if your BIOS offers an option to enable AHCI on your SATA
> controller then that would be a more optimal configuration (could get
> NCQ support), but that is an aside.

With AHCI I've got pretty bad timings (and I don't really know why!):

[root|20:49|~]$ cat sda_ahci_t

/dev/sda:
 Timing cached reads:   1560 MB in  2.00 seconds = 780.51 MB/sec
 Timing buffered disk reads:  102 MB in  3.02 seconds =  33.74 MB/sec
[root|20:49|~]$ cat sda_piix_t

/dev/sda:
 Timing cached reads:   1544 MB in  2.00 seconds = 772.35 MB/sec
 Timing buffered disk reads:  134 MB in  3.04 seconds =  44.05 MB/sec

-Jacek
