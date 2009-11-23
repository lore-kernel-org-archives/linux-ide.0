From: David Miller <davem@davemloft.net>
Subject: Re: drivers/ide/tx4938ide.c: use resource_size()
Date: Mon, 23 Nov 2009 10:31:25 -0800 (PST)
Message-ID: <20091123.103125.229368402.davem@davemloft.net>
References: <BD79186B4FD85F4B8E60E381CAEE190901EE5C05@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755078AbZKWSbK@vger.kernel.org>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901EE5C05@mi8nycmail19.Mi8.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hartleys@visionengravers.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Date: Mon, 23 Nov 2009 13:27:23 -0500

> Use resource_size() for devm_request_mem_region.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Applied to ide-next-2.6
