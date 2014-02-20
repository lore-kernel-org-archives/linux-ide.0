From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: libahci: replace obsolete simple_strtoul() with
 kstrtouint()
Date: Wed, 19 Feb 2014 19:09:23 -0500
Message-ID: <20140220000923.GU10134@htj.dyndns.org>
References: <3360211.AJuXnUkblU@daeseok-laptop.cloud.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:64161 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbaBTAJ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Feb 2014 19:09:27 -0500
Content-Disposition: inline
In-Reply-To: <3360211.AJuXnUkblU@daeseok-laptop.cloud.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daeseok Youn <daeseok.youn@gmail.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com

On Thu, Feb 20, 2014 at 08:28:45AM +0900, Daeseok Youn wrote:
> From 4a31953389769f685db08f93473fcbe732baaefc Mon Sep 17 00:00:00 2001
> From: Daeseok Youn <daeseok.youn@gmail.com>
> Date: Wed, 19 Feb 2014 13:44:24 +0900
> Subject: [PATCH] ata: libahci: replace obsolete simple_strtoul() with
>  kstrtouint()
> 
> Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
