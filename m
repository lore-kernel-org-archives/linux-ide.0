From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New CD/DVD drive - 80-wire cable detection failure
Date: Wed, 24 Oct 2007 22:13:53 +0100
Message-ID: <20071024221353.2117fd76@the-village.bc.nu>
References: <200710181832.42906.nick@ukfsn.org>
	<200710201322.57178.nick@ukfsn.org>
	<200710240133.08425.bzolnier@gmail.com>
	<200710241803.03955.nick@ukfsn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33149 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753970AbXJXVLI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 17:11:08 -0400
In-Reply-To: <200710241803.03955.nick@ukfsn.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nick@ukfsn.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> hdd: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache<7>hdd: skipping 
> word 93 validity check
> , UDMA(66)
> 
> 
> Many thanks indeed!

Sigh I'd hoped that libata could avoid the word 93 mess but apparently
not. Bartlomiej - I've ported your IVB bits over into libata as a new
horkage type.

Alan
