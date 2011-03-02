From: Len Brown <lenb@kernel.org>
Subject: Re: [Bugme-new] [Bug 29922] New: irqpool crash
Date: Wed, 02 Mar 2011 17:36:27 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1103021721590.12344@x980>
References: <bug-29922-10286@https.bugzilla.kernel.org/>
 <20110301152833.66dc5e6f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <20110301152833.66dc5e6f.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, mysql.jorge@decimal.pt
List-Id: linux-ide@vger.kernel.org

> pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16

This is a "hard coded IRQ", rather than a programmable PCI Link,
so it doesn't look like this issue is related to ACPI
interrupt routing.

There are multiple PCI devices associated with IRQ16,
so it is likely one of them is pulling on the IRQ
and the others can't quiesce it.

The output from acpidump attached to the bug report will help,
as we can verify that the IRQ is associated w/ the
PCI devices listed below.

The dmesg is 2.6.35.11
Does any version of linux earlier or later work properly?

cheers,
-Len

pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PME# disabled
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:00:01.0:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:01.0:   bridge window [mem 0xfbe00000-0xfbefffff]
pci 0000:00:01.0:   bridge window [mem 0xfff00000-0x000fffff pref] 
(disabled)
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:00:01.0:   bridge window [io  disabled]
pci 0000:00:01.0:   bridge window [mem 0xfbe00000-0xfbefffff]
pci 0000:00:01.0:   bridge window [mem pref disabled]
pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:01.0: setting latency timer to 64


pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.0: PCI bridge to [bus 02-02]
pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff pref] 
(disabled)
pci 0000:00:1c.0: BAR 15: assigned [mem 0xdb800000-0xdb9fffff 64bit pref]
pci 0000:00:1c.0: PCI bridge to [bus 02-02]
pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
pci 0000:00:1c.0:   bridge window [mem 0xdb800000-0xdb9fffff 64bit pref]
pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.0: setting latency timer to 64

ahci 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA 
mode
ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part
ahci 0000:02:00.0: setting latency timer to 64

ata7: SATA max UDMA/133 abar m8192@0xfbcfe000 port 0xfbcfe100 irq 16
ata8: SATA max UDMA/133 abar m8192@0xfbcfe000 port 0xfbcfe180 irq 16

