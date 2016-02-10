From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v8] SATA: OCTEON: support SATA on OCTEON platform
Date: Wed, 10 Feb 2016 13:16:49 -0500
Message-ID: <20160210181649.GR3741@mtj.duckdns.org>
References: <1455019469-5765-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <20160210160234.GH3741@mtj.duckdns.org>
 <56BB7DA4.9010207@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f194.google.com ([209.85.160.194]:35323 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbcBJSQv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Feb 2016 13:16:51 -0500
Content-Disposition: inline
In-Reply-To: <56BB7DA4.9010207@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, hdegoede@redhat.com, david.daney@cavium.com, aleksey.makarov@caviumnetworks.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Feb 10, 2016 at 10:12:52AM -0800, David Daney wrote:
> On 02/10/2016 08:02 AM, Tejun Heo wrote:
> >On Tue, Feb 09, 2016 at 12:04:29PM +0000, Zubair Lutfullah Kakakhel wrote:
> >...
> >>  .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
> >>  .../devicetree/bindings/mips/cavium/sata-uctl.txt  |  42 +++++++++
> >>  arch/mips/include/asm/octeon/cvmx.h                |   9 ++
> >>  drivers/ata/Kconfig                                |   9 ++
> >>  drivers/ata/Makefile                               |   1 +
> >>  drivers/ata/ahci_platform.c                        |   1 +
> >>  drivers/ata/sata_octeon.c                          | 105 +++++++++++++++++++++
> >
> >Don't we usually name these ahci variants ahci_xxx?
> >
> 
> Just to be clear, are you suggesting renaming sata_octeon.c to
> ahci_octeon.c?

Yeah, unless there are reasons not to.

Thanks.

-- 
tejun
