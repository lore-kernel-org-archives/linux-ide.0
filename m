From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: unregister idepnp driver on unload
Date: Thu, 18 Jan 2007 19:49:31 +0100
Message-ID: <58cb370e0701181049hff38d17g638affc2c530ac54@mail.gmail.com>
References: <20070118081925.GQ10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:55132 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbXARStd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jan 2007 13:49:33 -0500
Received: by ug-out-1314.google.com with SMTP id 44so254069uga
        for <linux-ide@vger.kernel.org>; Thu, 18 Jan 2007 10:49:32 -0800 (PST)
In-Reply-To: <20070118081925.GQ10987@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On 1/18/07, Tejun Heo <htejun@gmail.com> wrote:
> idepnp driver is registered as a pnp driver on ide init but doesn't
> get unregistered on ide unload causing driver list corruption and
> eventually oops.  Fix it.
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied to my tree, thanks
