From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Final 2.4.x SATA updates
Date: Thu, 01 Dec 2005 20:41:01 -0500
Message-ID: <438FA62D.2040707@pobox.com>
References: <20051201214837.GA25256@havoc.gtf.org> <20051201231008.GA7921@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:12509 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932715AbVLBBlH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2005 20:41:07 -0500
In-Reply-To: <20051201231008.GA7921@codepoet.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: andersen@codepoet.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>

Erik Andersen wrote:
> On Thu Dec 01, 2005 at 04:48:37PM -0500, Jeff Garzik wrote:
> 
>>Now that ATAPI support is pretty stable, the 2.4 version of libata will
>>be receiving its final updates soon.  Here is the current backport,
>>for testing and feedback.
> 
> 
> Awesome.  2.4.x lacks KM_IRQ0 in kmap_types.h
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.32/include -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fomit-frame-pointer -Os -falign-functions=2 -falign-jumps=2 -falign-labels=2 -falign-loops=2 -pipe -mpreferred-stack-boundary=2 -march=i486  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=libata_core  -DEXPORT_SYMTAB -c libata-core.c
> libata-core.c: In function `ata_sg_clean':
> libata-core.c:2427: error: `KM_IRQ0' undeclared (first use in this function)
> libata-core.c:2427: error: (Each undeclared identifier is reported only once
> libata-core.c:2427: error: for each function it appears in.)
> libata-core.c: In function `ata_sg_setup':
> libata-core.c:2701: error: `KM_IRQ0' undeclared (first use in this function)
> make[2]: *** [libata-core.o] Error 1

hmmm, interesting.  Easy enough to fix.  I guess I didn't build on a 
highmem box.

	Jeff



