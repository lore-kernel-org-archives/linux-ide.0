From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: hpt366: mark expected switch fall-throughs
Date: Sun, 10 Mar 2019 11:13:41 -0700 (PDT)
Message-ID: <20190310.111341.101594049285839134.davem@davemloft.net>
References: <20190110163423.GA17072@embeddedor>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110163423.GA17072@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: gustavo@embeddedor.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Thu, 10 Jan 2019 10:34:23 -0600

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that, in this particular case, I removed the "else: "
> part from the comment. As we are now using Warning level 3:
> -Wimplicit-fallthrough=3, this is what GCC is expecting to
> find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
