From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH v2] ide: pdc202xx_new: Replace timeval with ktime_t
Date: Thu, 22 Oct 2015 14:47:23 +0200
Message-ID: <4909398.MrlE5Sy5gL@wuerfel>
References: <20151022124550.GA18694@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151022124550.GA18694@amitoj-Inspiron-3542>
Sender: linux-kernel-owner@vger.kernel.org
To: y2038@lists.linaro.org
Cc: Amitoj Kaur Chawla <amitoj1606@gmail.com>, outreachy-kernel@googlegroups.com, linux-ide@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thursday 22 October 2015 18:15:50 Amitoj Kaur Chawla wrote:
> This driver uses 'struct timeval' which we are trying to remove since
> 32 bit time types will break in the year 2038 by replacing it with
> ktime_t.
> 
> This patch changes do_gettimeofday() to ktime_get() because
> ktime_get() returns a ktime_t while do_gettimeofday() returns struct
> timeval.
> 
> This patch also uses ktime_us_delta() to get the elapsed time.
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
