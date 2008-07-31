From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata.h: replace __FUNCTION__ with __func__
Date: Thu, 31 Jul 2008 01:50:25 -0400
Message-ID: <489152A1.2030400@pobox.com>
References: <48839ABB.3070503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42421 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbYGaFu3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 01:50:29 -0400
In-Reply-To: <48839ABB.3070503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org

Alexander Beregalov wrote:
> From: Alexander Beregalov <a.beregalov@gmail.com>
> 
> libata.h: replace __FUNCTION__ with __func__
> 
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
> 
> ---
> 
>  include/linux/libata.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

applied


