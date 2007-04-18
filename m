From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Wed, 18 Apr 2007 14:03:46 +0100
Message-ID: <20070418140346.636879a1@the-village.bc.nu>
References: <88SeR-5Sf-15@gated-at.bofh.it>
	<88Sov-662-3@gated-at.bofh.it>
	<88SHV-6uL-29@gated-at.bofh.it>
	<8agVk-3wc-81@gated-at.bofh.it>
	<8b3IR-4mE-25@gated-at.bofh.it>
	<8b3SA-4z3-5@gated-at.bofh.it>
	<8b42g-51N-15@gated-at.bofh.it>
	<8bbdm-7iS-27@gated-at.bofh.it>
	<E1He8dA-0000mw-LI@be1.lrz>
	<46260981.1040109@gmail.com>
	<20070418132904.3322ba5f@the-village.bc.nu>
	<46261337.3010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60513 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422986AbXDRNBz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2007 09:01:55 -0400
In-Reply-To: <46261337.3010406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: 7eggert@gmx.de, Chuck Ebbert <cebbert@redhat.com>, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>

> Thought about that and querying power state before doing shutdown 
> sequence but things get somewhat ugly because shutdown sequence is 
> driven from sd->shutdown().  We'll have to snoop both sync and shutdown 
> commands and check whether the system is shutting down.  Also, I felt 
> very uneasy about faking successful completion to SYNCHRONIZE_CACHE.

If you see a synchronize cache succeed and you then see the drive
shutdown succeed then you know that a sync cache can be faked as ok
safely. Any other command in between or after and it doesn't get faked

This seems pretty easy to deal with at command issue.

> I dunno.  It's already too late for 2.6.21.  I was hoping we could get 
> distros to update shutdown utilities in not-too-distant future but I 
> have no experience with that.  Is that just a wishful thinking?

Probably not, but it will take a year or so and throughout this time
period everyone with the wrong combination of shutdown and kernel (which
will be a lot of people who compile their own kernels) are going to have
problems caused by what is a very obscure piece of libata internal
behaviour they'll never even know about.

