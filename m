From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide-tape: fix misprint in failure handling in
 idetape_init()
Date: Tue, 26 Jul 2016 15:26:11 -0700 (PDT)
Message-ID: <20160726.152611.2020576477783367199.davem@davemloft.net>
References: <1461967872-14968-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461967872-14968-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: khoroshilov@ispras.ru
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-ide@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Sat, 30 Apr 2016 01:11:12 +0300

> If driver_register() failed there is no sense to call driver_unregister().
> unregister_chrdev() should be called here.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Applied.
