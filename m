From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: remove duplicated assignment to 'cursg'
Date: Mon, 29 Jan 2018 14:39:42 -0500 (EST)
Message-ID: <20180129.143942.1100860144218349617.davem@davemloft.net>
References: <20180116175422.19722-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180116175422.19722-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: colin.king@canonical.com
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Tue, 16 Jan 2018 17:54:22 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer cursg is initialized to cmd->cursg and again re-assigned the
> same value a few lines later, hence the second assignment is redundant
> and can be removed.
> 
> Cleans up clang warning:
> drivers/ide/ide-taskfile.c:229:22: warning: Value stored to 'cursg'
> during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied, thanks Colin.
