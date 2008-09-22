From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 3/3] libata: reorder ata_device to remove 8 bytes of
 padding on 64 bits
Date: Mon, 22 Sep 2008 22:53:56 +0100
Message-ID: <20080922225356.18f05413@lxorguk.ukuu.org.uk>
References: <200809222147.m8MLlDGd031662@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36322 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753742AbYIVVzW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Sep 2008 17:55:22 -0400
In-Reply-To: <200809222147.m8MLlDGd031662@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, akpm@linux-foundation.org, richard@rsk.demon.co.uk

On Mon, 22 Sep 2008 14:47:13 -0700
akpm@linux-foundation.org wrote:

> From: Richard Kennedy <richard@rsk.demon.co.uk>
> 
> reduce size by 8 bytes from 1160 to 1152 allowing it to fit in 1 fewer
> cachelines.
> 
> Signed-off-by: Richard Kennedy <richard@rsk.demon.co.uk>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Alan Cox <alan@redhat.com>
