From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compact Flash Question
Date: Wed, 7 May 2008 08:39:17 +0100
Message-ID: <20080507083917.6eebf110@core>
References: <005b01c8afc4$77f4ec90$6401a8c0@techwriter>
	<e2e108260805062315n15e84abck5f4207a6a7a11805@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38747 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758454AbYEGHsv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2008 03:48:51 -0400
In-Reply-To: <e2e108260805062315n15e84abck5f4207a6a7a11805@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bart Van Assche <bart.vanassche@gmail.com>
Cc: Yigal Sadgat <YSadgat1@gcte.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jwboyer@linux.vnet.ibm.com, joern@logfs.org

> For most Linux filesystems you really need wear leveling. E.g. ext3's
> superblock is at a fixed location and gets overwritten frequently.
> Without wear leveling you risk that the flash sector where the
> superblock resides wears out early.

CF sector mappings are not simple 1:1 mappings with flash blocks so this
is not the case. It is true with raw flash but not with CF. What CF
requires is vendor dependent but most vendors are pretty sensible.

The noatime advice is however good.
