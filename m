From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Forcing PIO0 mode on reset must not freeze
 system
Date: Mon, 11 Feb 2008 11:50:50 +0000
Message-ID: <20080211115050.77feb1af@core>
References: <20080210195556.GA5261@homac>
	<47AFB4DB.1000204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55164 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752520AbYBKL6f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 06:58:35 -0500
In-Reply-To: <47AFB4DB.1000204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, htejun@gmail.com, alan@redhat.com, jeff@garzik.org

> In the above example, even the reset sequence itself can cause hang if
> the hardware is implemented slightly differently.  The reason why
> set_piomode() locks up but reset sequence doesn't is simple dumb luck.
> I think the proper fix is to tell libata to detach the cdrom before
> undocking.

Just a thought but which ICH variant is this. For the older ones we have
to turn IORDY off in software before an eject and they cannot fully
support hot unplug

Alan

