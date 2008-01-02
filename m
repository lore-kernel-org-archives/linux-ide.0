From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: commit a258f183ee4e48e9352b408e8448467eebdc6cd2
Date: Wed, 2 Jan 2008 15:18:31 +0000
Message-ID: <20080102151831.184c8055@the-village.bc.nu>
References: <477B5AAE.7070008@gmail.com>
	<20080102134859.17e75789@the-village.bc.nu>
	<477B9E9E.3000104@gmail.com>
	<20080102141937.62d49c5e@the-village.bc.nu>
	<477BA0B7.3030509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35104 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753576AbYABP1S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 10:27:18 -0500
In-Reply-To: <477BA0B7.3030509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> ata_host_intr() is just never traveled while executing SETXFER because
> SETXFERs are executed using polling which nicely works around quirky
> controllers which raises interrupt a tad bit too early during SETXFER.

Ok
