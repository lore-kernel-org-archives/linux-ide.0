From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_via: write errors on PATA drive connected to VT6421
Date: Tue, 21 Aug 2007 13:27:31 +0100
Message-ID: <20070821132731.6bf10b50@the-village.bc.nu>
References: <200708202242.07290.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47900 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752197AbXHUMVp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Aug 2007 08:21:45 -0400
In-Reply-To: <200708202242.07290.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> The transfer mode decreases from UDMA/100 to UDMA/66 and then UDMA/33 but it 
> doesn't help at all. The drive itself is fine, the problems also appear with 

Does it settle at UDMA33 or keep going down lower ?

