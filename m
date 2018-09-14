From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] IDE: ide-dma: fix coding style issues with spaces
Date: Fri, 14 Sep 2018 14:16:50 -0700 (PDT)
Message-ID: <20180914.141650.1899234204768709995.davem@davemloft.net>
References: <20180914202540.11977-1-r.aviolat@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180914202540.11977-1-r.aviolat@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: r.aviolat@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Romain Aviolat <r.aviolat@gmail.com>
Date: Fri, 14 Sep 2018 22:25:40 +0200

> Fixing multiple coding style issues:
> 	* prohibited spaces before that ','
> 	* spaces before tabs
> 
> Signed-off-by: Romain Aviolat <r.aviolat@gmail.com>

This kind of coding style fix has very little value for a subsystem
which is essentially frozen from changes, and to which the less
changes that happen to it the better in order to avoid potential
regressions.

Therefore I am not applying this patch, sorry.
