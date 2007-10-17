From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [git patch] libata build fix
Date: Wed, 17 Oct 2007 16:00:27 -0400
Message-ID: <yq18x618qas.fsf@sermon.lab.mkp.net>
References: <20071015221329.GA8778@havoc.gtf.org>
	<200710170123.43244.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:28288 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757535AbXJQUBo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Oct 2007 16:01:44 -0400
In-Reply-To: <200710170123.43244.bzolnier@gmail.com> (Bartlomiej Zolnierkiewicz's message of "Wed\, 17 Oct 2007 01\:23\:43 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>

>>>>> "BZ" == Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> writes:

BZ> We probably need also this one for pata_cs5536:

BZ> [PATCH] pata_cs5536: MWDMA fix

BZ> * Fix out-of-bound array access for MWDMA modes.

BZ> * Bump driver version.

Obviously correct.  

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

