From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ST340823A disk size issue
Date: Wed, 1 Aug 2007 23:32:21 +0100
Message-ID: <20070801233221.34e2ff0c@the-village.bc.nu>
References: <20070801092903.GA1199@nalle>
	<200708012234.03375.bzolnier@gmail.com>
	<20070801215003.GA1864@nalle>
	<200708020019.25742.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58785 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753016AbXHAWZJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 18:25:09 -0400
In-Reply-To: <200708020019.25742.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, linux-ide@vger.kernel.org

> If you fix the printk, add patch description (can use the one from my patch)
> and add "Signed-off-by:" I would happily apply it and dump mine version.

Sorry but the patch is wrong - plain and simple. It works over the bug
but its not the real problem. ide-disk needs to spot a 1K request for the
last 512 bytes, issue a 512 byte request and complete the 512 bytes only.

Alan
