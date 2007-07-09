From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 03/11] libata-core: convert to use cancel_rearming_delayed_work()
Date: Tue, 10 Jul 2007 03:59:21 +0900
Message-ID: <46928589.9050502@gmail.com>
References: <200707091846.l69IkDHc001371@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:6668 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbXGIS71 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 14:59:27 -0400
Received: by nz-out-0506.google.com with SMTP id s18so765156nze
        for <linux-ide@vger.kernel.org>; Mon, 09 Jul 2007 11:59:27 -0700 (PDT)
In-Reply-To: <200707091846.l69IkDHc001371@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, oleg@tv-sign.ru

akpm@linux-foundation.org wrote:
> From: Oleg Nesterov <oleg@tv-sign.ru>
> 
> We should not use cancel_work_sync(delayed_work->work). This works, but not
> good. We can use cancel_rearming_delayed_work(), this also simplifies the
> code.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
