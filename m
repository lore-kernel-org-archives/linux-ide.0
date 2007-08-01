From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ST340823A disk size issue
Date: Wed, 1 Aug 2007 23:25:59 +0100
Message-ID: <20070801232559.42ba6a32@the-village.bc.nu>
References: <20070801092903.GA1199@nalle>
	<200708012234.03375.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37265 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753269AbXHAWSr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 18:18:47 -0400
In-Reply-To: <200708012234.03375.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, linux-ide@vger.kernel.org

> Could you try attached patch?
> 
> [PATCH] ide-disk: workaround for buggy HPA support on ST340823A

Title is wrong. The disc is performing correctly but if you dump the
request you should see a 1024 byte request for the last odd sector number
and the drive response is likewise correct.


Thus NAK the change

Fix ide-disk to issue requests for the last sector correctly instead (or
at least complete them properly)
