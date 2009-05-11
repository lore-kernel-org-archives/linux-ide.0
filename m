From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 0/4] Series short description
Date: Mon, 11 May 2009 13:21:43 -0400
Message-ID: <4A085EA7.4070104@garzik.org>
References: <20090506160612.24191.90737.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46155 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbZEKRVq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 May 2009 13:21:46 -0400
In-Reply-To: <20090506160612.24191.90737.stgit@t61.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> A quick batch of PIIX updates
> ---
> 
> Alan Cox (4):
>       ata_piix: Remove stale comment
>       ata_piix: Turn on hotplugging support for older chips
>       ata_piix: The Sony TZ90 needs the cable type hardcoding
>       ata_piix: ICH7 does not support correct MWDMA timings

I guess 1 & 2 are #upstream-fixes material, and 3 & 4 are #upstream ?

	Jeff



