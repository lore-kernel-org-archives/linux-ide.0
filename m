From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/3] pdc202xx_old: use ide_dma_test_irq()
Date: Fri, 05 Jun 2009 00:45:34 +0400
Message-ID: <4A28326E.2010406@ru.mvista.com>
References: <200906042329.13000.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:27732 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751151AbZFDUpg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Jun 2009 16:45:36 -0400
In-Reply-To: <200906042329.13000.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Hello, I wrote:

> The driver's dma_test_irq() method, although tests some chip specific interrupt
> bits, finally always relies on the SFF-8038i standard interrupt bit.  I see no
> point in testing the bits that are not trusted anyway -- the driver should be
> fully able to use the standard method implemetation, ide_dma_test_irq().
>
> With this change 'pdc202xx_dma_ops' finally becomes identical to 'sff_dma_ops',
> and we can get rid of it...
>
> ---
> The patch is against the ide-2.6.git 'for-next' branch, atop of 2 patches
> sent recently...
>
> I'll probably revive the remomed code as a part of the test_irq() method...
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>   

  Oops, put signoff under tearline again. Bart, hopefully you'll be able 
to handle that... :-)


WBR, Sergei


