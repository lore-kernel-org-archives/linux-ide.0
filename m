From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] libata IORDY handling
Date: Mon, 29 Jan 2007 15:45:47 +0000
Message-ID: <20070129154547.6a76f07d@localhost.localdomain>
References: <200701282024.17518.sshtylyov@ru.mvista.com>
	<45BCEA03.8070901@ru.mvista.com>
	<20070129133423.75aa208e@localhost.localdomain>
	<45BE0483.4070409@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59778 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750783AbXA2Pd5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jan 2007 10:33:57 -0500
In-Reply-To: <45BE0483.4070409@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

>      Atttaching my (already obsolete) patch, just in case...
> 

Thanks. Double checking my code it looks similar although I don't bother
with the DMA check as the drivers know that in DMA cases the PIO call will
be made before the DMA mode is set when DMA modes are in use.

