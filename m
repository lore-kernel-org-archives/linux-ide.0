From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: a disk timeout and a disk state
Date: Mon, 10 Sep 2007 18:46:42 +0100
Message-ID: <20070910184642.3d0d9499@the-village.bc.nu>
References: <5d96567b0709040009o2b1580fel4bcd91e629b5bef3@mail.gmail.com>
	<46E25696.4000504@gmail.com>
	<5d96567b0709101027g3553fc7evfb42f8a7121c84ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36089 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753871AbXIJRjU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Sep 2007 13:39:20 -0400
In-Reply-To: <5d96567b0709101027g3553fc7evfb42f8a7121c84ba@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Raz <raziebe@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

If you get a bad sector on a disk you can't get the data back. If you
rewrite that data then the disk can put data back. It may use the same
space on the medium or place the sector somewhere else on the physical
platter depending on the error involved.


Alan
