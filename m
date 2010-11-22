From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: fix use after free in ide-acpi
Date: Mon, 22 Nov 2010 11:37:29 -0800 (PST)
Message-ID: <20101122.113729.59693099.davem@davemloft.net>
References: <1290454478-5443-1-git-send-email-mk@lab.zgora.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38360
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756807Ab0KVThE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Nov 2010 14:37:04 -0500
In-Reply-To: <1290454478-5443-1-git-send-email-mk@lab.zgora.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mk@lab.zgora.pl
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mariusz Kozlowski <mk@lab.zgora.pl>
Date: Mon, 22 Nov 2010 20:34:38 +0100

> out_obj points to kfreed memory and we dereference that pointer in
> DEBPRINT/printk.
> 
> Signed-off-by: Mariusz Kozlowski <mk@lab.zgora.pl>

Applied, thanks.
