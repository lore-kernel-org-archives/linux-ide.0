From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/20] dtc2278: ->io_32bit setting don't have to be
 identical for master/slave
Date: Sun, 9 Dec 2007 22:27:36 +0000
Message-ID: <20071209222736.1c4ba88c@the-village.bc.nu>
References: <200712092208.58494.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42715 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751136AbXLIWcy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 17:32:54 -0500
In-Reply-To: <200712092208.58494.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

> drive->io_32bit is used per PIO transfer so there is no reason to
> require it to be identical for master/slave.

Sure about that ?

The driver has always gone to great pains to ensure that occurs and that
suggests the author had a good reason for doing it. Have you tested this
with an actual DTC2278 card ?

If not - NAK. You risk corruptors for no material benefit.
