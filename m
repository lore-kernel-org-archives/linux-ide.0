From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata/pata_it821x: Improve handling of poorly
 compatible emulations
Date: Tue, 30 Oct 2007 13:43:37 +0000
Message-ID: <20071030134337.6d9301f4@the-village.bc.nu>
References: <20071025142116.7e38ee86@the-village.bc.nu>
	<47273128.4090406@garzik.org>
	<20071030133350.687a5360@the-village.bc.nu>
	<47273404.40802@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58152 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751671AbXJ3Nlv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 09:41:51 -0400
In-Reply-To: <47273404.40802@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

> It sounds like such a hook would be more appropriate here...  can you 
> think of any other situation or driver that could make use of a 
> pre-dev-config hook?

No - which is why I didn't add one.

Alan
