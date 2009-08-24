From: Josip Rodin <joy@entuzijast.net>
Subject: Re: Sun Blade 100 - boot issue
Date: Mon, 24 Aug 2009 12:36:07 +0200
Message-ID: <20090824103607.GA14812@orion.carnet.hr>
References: <9a65e4710908220341j75457e31m475da871cbb266fd@mail.gmail.com> <4A924AAB.8070408@ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orion.CARNet.hr ([161.53.160.90]:60926 "EHLO orion.carnet.hr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbZHXLGx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Aug 2009 07:06:53 -0400
Content-Disposition: inline
In-Reply-To: <4A924AAB.8070408@ed.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: debian-sparc@lists.debian.org, Nataraj M Basappa <nataraj.m.basappa@gmail.com>, Hugh Pumphrey <H.C.Pumphrey@ed.ac.uk>

On Sat, Aug 22, 2009 at 11:41:41AM +0100, Nataraj M Basappa wrote:
>  i am new to sparc hardware, just found this isse after setting up
> lenny using netboot install.
> default kernal options on the stock kernel fails (see attached txt -
> withoutdma.txt), if i add ide=nodma boots correctly. is this a known
> issue? (as i found on some ubuntu forums)

On Mon, Aug 24, 2009 at 09:09:15AM +0100, Hugh Pumphrey wrote:
> I'm not an expert, but I have had Debian on a SunBlade 100 for a while.  
> I have always needed to use the ide=nodma option to get it to boot,  
> although the symptoms of allowing it to try DMA have varied from kernel  
> to kernel. Usually the boot process just hangs rather than doing the  
> kernel panic that you observe.

I googled a bit and it looks like the ALi 15x3 IDE controller/driver has
had various issues with Sun Blades over the years:

http://bugzilla.kernel.org/show_bug.cgi?id=7294
https://lists.linux-foundation.org/pipermail/bugme-new/2005-April/012164.html
http://www.cs.helsinki.fi/linux/linux-kernel/2002-25/0049.html

The latest incarnation of the driver even says:

 * pata_ali.c   - ALI 15x3 PATA for new ATA layer
 * based in part upon
 * linux/drivers/ide/pci/alim15x3.c             Version 0.17    2003/01/02

 *  TODO/CHECK
 *      Review Sunblade workaround.

I'm sending this to the IDE list - what is the status of this driver,
and what can the users do to help?

-- 
     2. That which causes joy or happiness.
