From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.26 DVD playing regression with libata
Date: Wed, 30 Jul 2008 00:20:11 +0100
Message-ID: <20080730002011.21947c32@lxorguk.ukuu.org.uk>
References: <200807292323.28033.tvrtko@ursulin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33348 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752040AbYG2Xha (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jul 2008 19:37:30 -0400
In-Reply-To: <200807292323.28033.tvrtko@ursulin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> Jul 29 21:10:03 media kernel: [353032.319013] sr 2:0:0:0: [sr0] unaligned transfer
> Jul 29 21:10:03 media kernel: [353032.319013] sr 2:0:0:0: [sr0] unaligned transfer

This is coming from the scsi/block layer and definitely isn't good.
Doesn't directly look like a libata bug but seems to be higher up the
stack. What software is triggering this ?
