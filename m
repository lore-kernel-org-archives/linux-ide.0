From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] cs5536: use module_pci_driver to simplify the code
Date: Wed, 10 Oct 2012 11:37:48 -0400 (EDT)
Message-ID: <20121010.113748.1650953424894878640.davem@davemloft.net>
References: <CAPgLHd-Cx5k566XJ2C-VrmLUJ4AVPV=w52ZVfLATONv_sqbMaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:49987 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab2JJPhw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2012 11:37:52 -0400
In-Reply-To: <CAPgLHd-Cx5k566XJ2C-VrmLUJ4AVPV=w52ZVfLATONv_sqbMaA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: weiyj.lk@gmail.com
Cc: yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org


Sorry, the IDE device layer is in deep freeze state, no simplifications,
no cleanups.

I'll accept changes that address kernel-wide API adjustments, but that's
it.
