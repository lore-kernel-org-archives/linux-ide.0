From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv,ahci: add the ahci legacy mode support to sata_nv
Date: Fri, 09 Nov 2007 23:04:40 -0500
Message-ID: <47352DD8.6040607@garzik.org>
References: <200709251323031982245@gmail.com> <470FE47B.5060505@garzik.org>	 <cfaab6210710160108x1328086cse991f668e23e569e@mail.gmail.com>	 <47181CE1.4000802@garzik.org>	 <cfaab6210710182358t4de355f9wd6d605a7b8076ace@mail.gmail.com>	 <47185BFD.2010909@garzik.org> <cfaab6210710211855q7a2de35co13d3017b2a07d4cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764094AbXKJEE5@vger.kernel.org>
In-Reply-To: <cfaab6210710211855q7a2de35co13d3017b2a07d4cc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peer chen <peerchen@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>, Kuan Luo <kluo@nvidia.com>
List-Id: linux-ide@vger.kernel.org

peer chen wrote:
> Yes, link - http://lkml.org/lkml/2007/10/8/93 add the AHCI legacy
> support to sata_nv when IDE/RAID mode been set in SBIOS and Device IDs
> are not in ahci.c at this moment. To do so, when a new chipset come
> out and DIDs haven't been submited to LKML,user still can use ahci
> driver to handle it when setting AHCI mode in BIOS, using sata_nv when
> setting RAID/IDE in BIOS.
> For example, ahci driver in Fedora 7 doesn't include the DIDs of
> MCP78, so if you set the IDE/RAID mode in BIOS, os installation onto
> SATA drive will fail. But if Fedora 7 include this patch, installation
> will be successful.

The problem with this change is that sata_nv picks it up through the 
default entry, and then later on, ahci picks it up as well.

Rather than the confusion of "which driver is the user running on this 
hardware?" it is easier to take steps to ensure the user is always 
running in AHCI mode.

Therefore, I think the best idea is to follow the same policy as 
drivers/net/forcedeth.c (Ayaz @ NVIDIA) and Intel AHCI, and simply 
provide the individual PCI IDs in advance of product release.

If you wish to avoid this, then take steps to make sure 
drivers/ata/ahci.c has the appropriate wildcard entry in its 
pci_device_id table.

Really, look at the sata_nv bug reports that keep popping up.  We want 
to move away from that driver long term, and always drive the SATA 
interface in AHCI mode.

The proposed sata_nv patch does the opposite -- guarantees we must 
support the continually problematic legacy IDE interface ad infinitum. 
Such patches are OK for the test lab, but in this specific case users 
/suffer/ when not running AHCI mode.

	Jeff
