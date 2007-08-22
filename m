From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.23-rc3-mm1
Date: Wed, 22 Aug 2007 11:14:28 -0700
Message-ID: <20070822111428.ad3f437c.akpm@linux-foundation.org>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org>
	<64bb37e0708221024p5184aa65x5d36c7c049049124@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43902 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761707AbXHVSOn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 14:14:43 -0400
In-Reply-To: <64bb37e0708221024p5184aa65x5d36c7c049049124@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 22 Aug 2007 19:24:39 +0200
"Torsten Kaiser" <just.for.lkml@googlemail.com> wrote:

> On 8/22/07, Andrew Morton <akpm@linux-foundation.org> wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.23-rc3/2.6.23-rc3-mm1/
> [snip]
> > -ata-add-the-sw-ncq-support-to-sata_nv-for-mcp51-mcp55-mcp61.patch
> > -ata-add-the-sw-ncq-support-to-sata_nv-for-mcp51-mcp55-mcp61-fix.patch
> [snip]
> >  Merged into mainline or a subsystem tree
> 
> That patch is no longer in 2.6.23-rc3-mm1, my bootlog says:
> [    0.000000] Unknown boot option `sata_nv.swncq=1': ignoring
> 
> I could not find this patch in any git trees I looked and its removal
> mail from mm-commit said:
> "This patch was dropped because Changes in Jeff's tree destroyed it."
> 
> 
> I only found out about the swncq=1 command line option yesterday and
> so tested it only one day.
> But I did not have any trouble with it, even as my drive was made by Maxtor.
> 
> The chipset:
> 00:05.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)
> 00:05.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)
> 00:05.2 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)
> 
> The drive:
> Device Model:     MAXTOR STM3320820AS
> Serial Number:    5QF2E698
> Firmware Version: 3.AAE
> 
> As it worked for me, I hope that patch will be picked up by someone. :)
> 

This is a fairly regular occurrence in ata land: patches from maintainers
don't get merged, so I merge them for testing, then some fairly pointless
cleanup-style patch goes on a great tree-wide rampage thus destabilising or
simply destroying the more important, mysteriously-not-merged patch.

Nobody knows why this happens.

Peer and Kuan: can you please redo that patch against the current ata
development tree?

Thanks.

