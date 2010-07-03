From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH]ata:ahci.c Fix warning: comparison between 'enum <anonymous>'
 and 'enum <anonymous>'
Date: Sat, 03 Jul 2010 16:30:26 +0200
Message-ID: <4C2F4982.1080501@kernel.org>
References: <1278167365-16011-1-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34330 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab0GCOac (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jul 2010 10:30:32 -0400
In-Reply-To: <1278167365-16011-1-git-send-email-justinmattock@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On 07/03/2010 04:29 PM, Justin P. Mattock wrote:
> The below patch casts ATA_MAX_QUEUE to int because GCC will 
> give a warning message about the two different enum blocks:
>   CC      drivers/ata/ahci.o
> drivers/ata/ahci.c: In function 'ahci_init_one':
> drivers/ata/ahci.c:1045:2: warning: comparison between 'enum <anonymous>' and 'enum <anonymous>'
>  
> Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
