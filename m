From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata/sata_sil24 cache alignment problem?
Date: Tue, 12 Feb 2008 22:12:57 +0000
Message-ID: <20080212221257.12eeab13@core>
References: <20080212180254.GA28237@postdiluvian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46761 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753553AbYBLW0d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 17:26:33 -0500
In-Reply-To: <20080212180254.GA28237@postdiluvian.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Mason <mason@postdiluvian.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

> Has anyone else reported a problem like this?  It requires
> non-coherent DMA, and a lack of a cache invalidate instruction, and
> one of the drivers that has this problem (it looks like sata_qstor
> does too, I haven't looked at others), so maybe that doesn't cover
> any other architectures.

Nobody has, not even PA-RISC which is normally guaranteed to make life
miserable in the caching area but I agree entirely with your diagnosis
and that buffer should indeed be marked cache aligned

> I can provide a patch if you're interested.

Please do.

Alan
