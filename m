From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/8] ide: convert bus code to use dev_groups
Date: Tue, 08 Oct 2013 01:00:36 -0400 (EDT)
Message-ID: <20131008.010036.748831303031980348.davem@davemloft.net>
References: <1381195662-28009-1-git-send-email-gregkh@linuxfoundation.org>
	<1381195662-28009-2-git-send-email-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:42220 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab3JHFAh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Oct 2013 01:00:37 -0400
In-Reply-To: <1381195662-28009-2-git-send-email-gregkh@linuxfoundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon,  7 Oct 2013 18:27:35 -0700

> The dev_attrs field of struct bus_type is going away soon, dev_groups
> should be used instead.  This converts the ide bus code to use the
> correct field.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: <linux-ide@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> 
> David, I can take this through my driver-core tree if you don't want to
> take it through yours, just let me know what works best for you.

Yep, please take it, that works for me:

Acked-by: David S. Miller <davem@davemloft.net>
