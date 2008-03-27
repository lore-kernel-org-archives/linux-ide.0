From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_atiixp: Simplex clear
Date: Thu, 27 Mar 2008 09:02:04 +0000
Message-ID: <20080327090204.0fd38356@core>
References: <20080326113503.7c0218ce@core>
	<20080327013438.cc2a69b6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50695 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758567AbYC0JTL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 05:19:11 -0400
In-Reply-To: <20080327013438.cc2a69b6.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

> Changelog whine: I am unable to work out from the above whether this patch
> is appropriate to 2.6.24.x and/or 2.6.25.  It _looks_ like this change will
> unbreak some people's stuff, but that's a mad guess.

I don't yet know. I'm hoping it'll get some feedback to be sure. 

Alan
