From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] sgiioc4: fix error cleanup path
Date: Mon, 20 Oct 2008 14:17:21 +0400
Message-ID: <48FC5AB1.8090908@ru.mvista.com>
References: <200810192213.57242.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:27935 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750911AbYJTKR1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Oct 2008 06:17:27 -0400
In-Reply-To: <200810192213.57242.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Hello, I wrote:

> The driver "forgot" to call iounmap() if request_mem_region() call failed in
> sgiioc4_ide_setup_pci_device(). While fixing this, rename the 'err' label to
> 'alloc_err' and get rid of the 'err_free' label altogether...
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

   Don't apply these 2 patches yet, I'm going to recast them to avoid 
changing the same code twice...

MBR, Sergei


