From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Enable SB600 64bit DMA on MSI K9A2 Platinum
Date: Mon, 26 Oct 2009 14:25:04 +0100
Message-ID: <4AE5A330.3080506@kernel.org>
References: <65a6ef750910252203s58af446fv268c857191e698d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54957 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754656AbZJZNYE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Oct 2009 09:24:04 -0400
In-Reply-To: <65a6ef750910252203s58af446fv268c857191e698d3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hello,

Mark Nelson wrote:
> Like the Asus M2A-VM, MSI's K9A2 Platinum (MS-7376) can also support 64bit
> DMA. According to MSI tech support, 64bit DMA is known to work with BIOS
> versions 1.7 and later.

Have you verified it?  I'd really like for someone to actually verify
it works before committing the patch as it's pretty nasty when it
doesn't work.

Thanks.

-- 
tejun
