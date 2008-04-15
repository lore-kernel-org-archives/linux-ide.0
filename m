From: Tejun Heo <htejun@gmail.com>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Wed, 16 Apr 2008 08:25:57 +0900
Message-ID: <48053985.8080702@gmail.com>
References: <200804021524.27222.elendil@planet.nl>	<200804021820.04610.elendil@planet.nl>	<20080402194938.GI24237@csclub.uwaterloo.ca>	<200804031947.07674.elendil@planet.nl>	<48017248.4030600@gmail.com>	<20080414134734.GB7385@csclub.uwaterloo.ca>	<20080414145302.4239b0b9@core>	<480414E6.2090205@gmail.com> <20080415110419.785a75ee@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758681AbYDOX0V@vger.kernel.org>
In-Reply-To: <20080415110419.785a75ee@core>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
>> Always loading generic or ata_generic used to be safe.  It's still 
>> pretty safe but not as much as before.  Nowadays, there are good number 
> 
> ata_generic is always safe unless you force it to grab every class
> device. By default it grabs only those devices we know obey the class
> interface well enough and for which we have no proper driver (usually
> because there are no documents). Ditto for ide/pci/generic.
> 
> The trickier one is pata_legacy, which tries to be smart and knows about
> the known exception so *should* always be safe. The old IDE legacy driver
> lacks these smarts so in some cases will do the wrong thing even if
> loaded last.

Right, I was thinking about drivers/ide/ide-generic.c which just grabs 
every known legacy IO ports.  This actually caused rather serious 
problems on some ATI controllers under certain configurations.  :-(

-- 
tejun
