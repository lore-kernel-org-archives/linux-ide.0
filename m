From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 18/35] drivers/ide: Convert remaining uses of
 pr_warning to pr_warn
Date: Fri, 17 Feb 2017 10:20:36 -0500 (EST)
Message-ID: <20170217.102036.2065698824076906227.davem@davemloft.net>
References: <cover.1487314666.git.joe@perches.com>
        <94a040b80eec22d9d2b5cf929fe06880ab0bc31a.1487314667.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94a040b80eec22d9d2b5cf929fe06880ab0bc31a.1487314667.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joe@perches.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Thu, 16 Feb 2017 23:11:31 -0800

> To enable eventual removal of pr_warning
> 
> This makes pr_warn use consistent for drivers/ide
> 
> Prior to this patch, there were 2 uses of pr_warning and
> 0 uses of pr_warn in drivers/ide
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: David S. Miller <davem@davemloft.net>
