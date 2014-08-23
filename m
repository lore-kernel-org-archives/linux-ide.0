From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] pata_platform: Use devm_ioremap_resource()
Date: Sat, 23 Aug 2014 12:58:37 -0400
Message-ID: <20140823165837.GB13540@mtj.dyndns.org>
References: <1408790772-5305-1-git-send-email-shc_work@mail.ru>
 <1408790772-5305-2-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:42363 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbaHWQ6l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Aug 2014 12:58:41 -0400
Received: by mail-qg0-f45.google.com with SMTP id f51so11590626qge.32
        for <linux-ide@vger.kernel.org>; Sat, 23 Aug 2014 09:58:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408790772-5305-2-git-send-email-shc_work@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-ide@vger.kernel.org

On Sat, Aug 23, 2014 at 02:46:11PM +0400, Alexander Shiyan wrote:
> Use devm_ioremap_resource() calls.
> This will provide a more reasonable exit codes in case of errors.

It also reserves the mem region.

Thanks.

-- 
tejun
