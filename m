From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ST340823A disk size issue
Date: Thu, 2 Aug 2007 12:33:59 +0100
Message-ID: <20070802123359.1e731c35@the-village.bc.nu>
References: <20070801092903.GA1199@nalle>
	<200708020019.25742.bzolnier@gmail.com>
	<20070801233221.34e2ff0c@the-village.bc.nu>
	<200708020117.58916.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42776 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754502AbXHBL2d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 07:28:33 -0400
In-Reply-To: <200708020117.58916.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, linux-ide@vger.kernel.org

> Additionally fs/partitions/check.c:rescan_partitions() should warn if the
> partition exceeds device size and we are not seeing any such warning.

Why would it if there isn't anything wrong ?

The same disks just work in libata even with the hpa being disabled. It
closed a pile of long standing bugzillas about such problems with odd
sized disks. This therefore (and instrumenting the requests being issued
when I first looked at it) made me fairly sure its not the drive. I was
seeing 1K requests for the last 512 byte sector.

Alan
