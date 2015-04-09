From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/2] ide: replace GFP_ATOMIC by GFP_KERNEL
Date: Thu, 9 Apr 2015 17:50:35 +0300
Message-ID: <20150409145035.GC16501@mwanda>
References: <1428579988-10167-1-git-send-email-lambert.quentin@gmail.com>
 <1428579988-10167-3-git-send-email-lambert.quentin@gmail.com>
 <20150409123633.GN10964@mwanda>
 <55268DCB.3010201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55268DCB.3010201@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Lambert <lambert.quentin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Sorry, my last email was bad.

Splitting patches into logical parts is a bit tricky.  Let me try
explain better.

Every patch should sort of make sense on its own.  In the original code
it's using GFP_ATOMIC but that's because the original API was bad and
we had no choice.  In the 1/1 patch we're using GFP_ATOMIC explicitly
by choice and it's wrong.  In patch 2/2 we fix this problem but we
shouldn't introduce bad code even if we fix it in later patches.

regards,
dan carpenter
