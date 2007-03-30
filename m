From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Libata disk corruptor paths ?
Date: Fri, 30 Mar 2007 15:16:46 +0100
Message-ID: <20070330151646.539e2b7f@the-village.bc.nu>
References: <20070330151525.63a5931e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49793 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751060AbXC3NN3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Mar 2007 09:13:29 -0400
In-Reply-To: <20070330151525.63a5931e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

> There is another ugly here too ata_tf_init sets the device bits but
> doesn't set TFLAG_DEVICE. Scarily in fact the qc_reinit path that

Argh ignore this part - I meant to delete it as the tf structure is
memset to zero. The other case I believe is a genuine bug however
