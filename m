From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: correctly handling failed allocation
Date: Thu, 31 Dec 2015 21:34:31 -0500
Message-ID: <20160101023431.GA3779@htj.duckdns.org>
References: <1451424075-19654-1-git-send-email-wuninsu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34393 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbcAACef (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Dec 2015 21:34:35 -0500
Content-Disposition: inline
In-Reply-To: <1451424075-19654-1-git-send-email-wuninsu@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Insu Yun <wuninsu@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu, changwoo@gatech.edu

On Tue, Dec 29, 2015 at 04:21:15PM -0500, Insu Yun wrote:
> Since kzalloc can be failed in memory pressure, return error when failed.
> 
> Signed-off-by: Insu Yun <wuninsu@gmail.com>

Applied to libata/for-4.5.

Thanks.

-- 
tejun
