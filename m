From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Date: Wed, 7 Dec 2005 15:53:48 +0000
Message-ID: <20051207155348.GB17371@srcf.ucam.org>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com> <20051206222001.GA14171@srcf.ucam.org> <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com> <20051207131454.GA16558@srcf.ucam.org> <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com> <20051207143337.GA16938@srcf.ucam.org> <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com> <20051207145811.GA17119@srcf.ucam.org> <58cb370e0512070744w6a820f72h853783c851b580c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751164AbVLGPxx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <58cb370e0512070744w6a820f72h853783c851b580c4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Dec 07, 2005 at 04:44:39PM +0100, Bartlomiej Zolnierkiewicz wrote:

> PCI device will get re-configured indirectly by ide_complete_power_step()
> which is calling hwif->ide_dma_check() (piix_config_drive_xfer_rate).

Ah, right - which is /after/ the failure I see, so it's not surprising 
that it doesn't work :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
