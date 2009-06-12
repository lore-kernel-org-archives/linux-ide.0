From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7/9] pdc202xx_old: implement test_irq() method
Date: Fri, 12 Jun 2009 18:20:19 +0200
Message-ID: <200906121820.19163.bzolnier@gmail.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906102301.09022.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:64035 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbZFLQXh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jun 2009 12:23:37 -0400
Received: by bwz9 with SMTP id 9so2190785bwz.37
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2009 09:23:38 -0700 (PDT)
In-Reply-To: <200906102301.09022.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 10 June 2009 21:01:09 Sergei Shtylyov wrote:
> Implement test_irq() method based on the driver's former dma_test_irq() method.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch is atop of ide-2.6.git 'for-next' branch.
> Bart, it wouldn't hurt to check this against the documentation...

no luck with the docs again, they list all those bits as reserved..
