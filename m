From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 2.6.32.3] ahci: AHCI and RAID mode SATA patch for Intel
	Cougar Point DeviceIDs
Date: Wed, 13 Jan 2010 18:03:37 -0600
Message-ID: <51f3faa71001131603x56abe9a2t4a8c4ffc3dadfce2@mail.gmail.com>
References: <201001121700.18234.seth.heasley@intel.com>
	 <4B4D4EAA.2010109@gmail.com> <4B4DAA68.60608@pobox.com>
	 <4B4DDFD3.5050700@redhat.com>
	 <CF9C39F99A89134C9CF9C4CCB68B8DDF12D391CB2A@orsmsx501.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756691Ab0ANADk@vger.kernel.org>
In-Reply-To: <CF9C39F99A89134C9CF9C4CCB68B8DDF12D391CB2A@orsmsx501.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Heasley, Seth" <seth.heasley@intel.com>
Cc: David Milburn <dmilburn@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Jan 13, 2010 at 9:43 AM, Heasley, Seth <seth.heasley@intel.com>=
 wrote:
>>> * some of lines of Intel chips do not separate AHCI into a separate=
 PCI
>>> ID rather legacy IDE interface. =A0When an AHCI interface exists an=
d
>>> AHCI/IDE share the same PCI ID, we default to using AHCI. =A0Thus, =
some of
>>> those PCI ID matches in ahci.c's PCI table may not get caught by th=
e
>>> generic PCI class match at the end of the table.
>>>
>>> * the cost carrying redundant PCI IDs seems low, harmless, and
>>> potentially helpful.
>>
>>It is helpful for the specific device IDs to show up in "modinfo ahci=
" and
>>modules.pcimap.
>>
>>David
>
> This is the reason I was asked to start adding the AHCI DeviceIDs her=
e.

I'm not sure why exactly that is useful - or at least why it's useful
enough to be worth the effort of patching the kernel for every new
AHCI controller that gets released..

I looked at what the Windows msahci driver is doing, they're not
listing any specific device IDs at all, they're just using the class
code matching only. (Of course, they don't have to worry about devices
in RAID mode, as those have to use vendor-specific drivers..)
