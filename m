From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Sun Blade 100 - boot issue
Date: Mon, 24 Aug 2009 14:57:54 +0100
Message-ID: <20090824145754.6d5a63a2@lxorguk.ukuu.org.uk>
References: <9a65e4710908220341j75457e31m475da871cbb266fd@mail.gmail.com>
	<4A924AAB.8070408@ed.ac.uk>
	<20090824103607.GA14812@orion.carnet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58883 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752540AbZHXN5k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Aug 2009 09:57:40 -0400
In-Reply-To: <20090824103607.GA14812@orion.carnet.hr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Josip Rodin <joy@entuzijast.net>
Cc: linux-ide@vger.kernel.org, debian-sparc@lists.debian.org, Nataraj M Basappa <nataraj.m.basappa@gmail.com>, Hugh Pumphrey <H.C.Pumphrey@ed.ac.uk>

>  * pata_ali.c   - ALI 15x3 PATA for new ATA layer
>  * based in part upon
>  * linux/drivers/ide/pci/alim15x3.c             Version 0.17    2003/01/02
> 
>  *  TODO/CHECK
>  *      Review Sunblade workaround.
> 
> I'm sending this to the IDE list - what is the status of this driver,
> and what can the users do to help?

Short of someone with a Sunblade and suitable documentation probably not
a lot. The libata driver has some sunblade workarounds but I simply didn't
have documentation on the Sun side of it sufficient to complete the job

Alan
