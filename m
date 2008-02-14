From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] pata_scc.c: add thaw ops
Date: Thu, 14 Feb 2008 11:40:09 +0900
Message-ID: <47B3AA09.10203@gmail.com>
References: <200802130254.m1D2s9bG023092@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:17972 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbYBNCkR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 21:40:17 -0500
Received: by wr-out-0506.google.com with SMTP id c48so379723wra.23
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 18:40:16 -0800 (PST)
In-Reply-To: <200802130254.m1D2s9bG023092@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: jeff@garzik.org, kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

Akira Iguchi wrote:
> This patch adds default thaw ops and fixes the freeze/thaw inconsistency.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
