From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2/2] ide: replace GFP_ATOMIC by GFP_KERNEL
Date: Thu, 9 Apr 2015 16:53:48 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1504091652420.2598@hadrien>
References: <1428579988-10167-1-git-send-email-lambert.quentin@gmail.com> <1428579988-10167-3-git-send-email-lambert.quentin@gmail.com> <20150409123633.GN10964@mwanda> <55268DCB.3010201@gmail.com> <20150409145035.GC16501@mwanda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150409145035.GC16501@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Quentin Lambert <lambert.quentin@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org



On Thu, 9 Apr 2015, Dan Carpenter wrote:

> Sorry, my last email was bad.
>
> Splitting patches into logical parts is a bit tricky.  Let me try
> explain better.
>
> Every patch should sort of make sense on its own.  In the original code
> it's using GFP_ATOMIC but that's because the original API was bad and
> we had no choice.  In the 1/1 patch we're using GFP_ATOMIC explicitly
> by choice and it's wrong.  In patch 2/2 we fix this problem but we
> shouldn't introduce bad code even if we fix it in later patches.

But if Quentin's analysis is wrong, then we have to undo the GFP_KERNEL
choice, and with only one patch we end up back at the pci API?

julia
