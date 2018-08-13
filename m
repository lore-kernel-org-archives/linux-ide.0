From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide-tape: remove redundant variable buffer_size
Date: Mon, 13 Aug 2018 11:50:38 -0700 (PDT)
Message-ID: <20180813.115038.2070003569481963697.davem@davemloft.net>
References: <20180702100026.16007-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702100026.16007-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: colin.king@canonical.com
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon,  2 Jul 2018 11:00:26 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable buffer_size is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'buffer_size' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
