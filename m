From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: mark expected switch fall-throughs
Date: Mon, 13 Aug 2018 11:50:24 -0700 (PDT)
Message-ID: <20180813.115024.92823174930370367.davem@davemloft.net>
References: <20180703192305.GA3413@embeddedor.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703192305.GA3413@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gustavo@embeddedor.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 3 Jul 2018 14:23:05 -0500

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
