From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 9/15] cs5530: remove needless ide_lock taking
Date: Wed, 3 Oct 2007 01:14:21 +0100
Message-ID: <20071003011421.76fd2fa6@the-village.bc.nu>
References: <200710012337.16971.bzolnier@gmail.com>
	<20071002144541.1832b74d@the-village.bc.nu>
	<200710022302.20574.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45989 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751697AbXJCAJH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 20:09:07 -0400
In-Reply-To: <200710022302.20574.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

> All the removed code resided in init_chipset_cs5530() which is called only
> during the controller initialization.  Moreover pata_cs5530 also don't have
> any locking in cs5530_init_chip().

Fair enough, and I haven't found a reason for the locking being needed
from doc reviews (hence its not in libata).
