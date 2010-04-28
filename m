From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Weird ahci init failure possibly caused by PCI layer
Date: Wed, 28 Apr 2010 09:48:38 -0600
Message-ID: <201004280948.39263.bjorn.helgaas@hp.com>
References: <4BD8469D.6080409@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4BD8469D.6080409@kernel.org>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Reinhard Max <max@novell.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Wednesday 28 April 2010 08:30:53 am Tejun Heo wrote:
> Hello, Jesse.
> 
> There is a pretty weird ahci init failure[1] reported by Reinhard Max
> against openSUSE 11.3 on Dell Optiplex 960[2].  It looks like
> something between the cpu and the controller isn't properly set up and
> register reads on the controller return garbage values.  The problem
> appeared somewhere between 2.6.33 and 2.6.34-rc3 and is still present
> in -rc5.
> 
> The following log from -rc3 seemed :-) relevant to me.
> 
>  <3>pci 0000:00:1f.2: no compatible bridge window for [mem 0xff970000-0xff9707ff]
>  <4>Expanded resource reserved due to conflict with PCI Bus 0000:00
>  <7>reserve RAM buffer: 000000000009e400 - 000000000009ffff
>  <7>reserve RAM buffer: 00000000cfdffc00 - 00000000cfffffff
> 
> The full log from -rc3 is available[3].  Any ideas?

This is the same problem as https://bugzilla.kernel.org/show_bug.cgi?id=15744

The snippet below shows that BIOS left the 00:1f.2 BAR at
[mem 0xff970000-0xff9707ff], which is not in any of the host bridge
MMIO windows, so Linux moved it.  Unfortunately, we moved it to 0xa0000,
which was not a good choice.

The patch here: https://bugzilla.kernel.org/attachment.cgi?id=26149
(attached as comment #11 to 15744) should fix the problem.

Let me know if it doesn't.

Bjorn


  pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
  pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x000effff]
  pci_root PNP0A03:00: host bridge window [mem 0x000f0000-0x000fffff]
  pci_root PNP0A03:00: host bridge window [mem 0xf0000000-0xfebfffff]
  pci_root PNP0A03:00: host bridge window [mem 0xcff00000-0xdfffffff]
  pci_root PNP0A03:00: host bridge window [mem 0xff980000-0xff980fff]
  pci_root PNP0A03:00: host bridge window [mem 0xff97c000-0xff97ffff]
  pci_root PNP0A03:00: host bridge window [mem 0xfed20000-0xfed9ffff]
  pci_root PNP0A03:00: host bridge window [mem 0xfeda7000-0xfeda7fff]
  pci 0000:00:1f.2: reg 24: [mem 0xff970000-0xff9707ff]
  pci 0000:00:1f.2: no compatible bridge window for [mem 0xff970000-0xff9707ff]
  pci 0000:00:1f.2: BAR 5: assigned [mem 0x000a0000-0x000a07ff]
