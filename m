From: David Miller <davem@davemloft.net>
Subject: Re: [patch] ide: missing break statement in set_timings_mdma()
Date: Tue, 26 Jul 2016 15:26:24 -0700 (PDT)
Message-ID: <20160726.152624.1129190524778208462.davem@davemloft.net>
References: <20160714104802.GI18175@mwanda>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20160714104802.GI18175@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: dan.carpenter@oracle.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 14 Jul 2016 13:48:02 +0300

> There was clearly supposed to be a break statement here.  Currently we
> use the k2 ata timings instead of sh ata ones we intended.  Probably no
> one has this hardware anymore so it likely doesn't make a difference
> beyond the static checker warning.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.
