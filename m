From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] ide: sgiioc4: Staticize ioc4_ide_attach_one()
Date: Thu, 05 Sep 2013 15:38:48 -0400 (EDT)
Message-ID: <20130905.153848.2072832640295810658.davem@davemloft.net>
References: <002c01ce932d$791b80a0$6b5281e0$@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:40643 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363Ab3IETiu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Sep 2013 15:38:50 -0400
In-Reply-To: <002c01ce932d$791b80a0$6b5281e0$@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jg1.han@samsung.com
Cc: linux-ide@vger.kernel.org

From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 07 Aug 2013 14:17:55 +0900

> ioc4_ide_attach_one() is used only in this file.
> Fix the following sparse warnings:
> 
> drivers/ide/sgiioc4.c:603:5: warning: symbol 'ioc4_ide_attach_one' was not declared. Should it be static?
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.
