From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/4] pata_of_platform: Remove "electra-ide" quirk
Date: Sat, 23 Aug 2014 13:06:21 -0400
Message-ID: <20140823170621.GC13540@mtj.dyndns.org>
References: <1408790772-5305-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:62345 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbaHWRGZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Aug 2014 13:06:25 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so11571066qgf.21
        for <linux-ide@vger.kernel.org>; Sat, 23 Aug 2014 10:06:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408790772-5305-1-git-send-email-shc_work@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-ide@vger.kernel.org

On Sat, Aug 23, 2014 at 02:46:10PM +0400, Alexander Shiyan wrote:
> "electra-ide" is not used anywhere in the kernel and could be
> represented in devicetree in a normal way.
> This patch removes specific quirk for "electra-ide".
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied to libata/for-3.18.

Thanks.

-- 
tejun
