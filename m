From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ide: pdc202xxx_new: Remove do_gettimeofday() usage for
 ktime_get
Date: Thu, 12 Mar 2015 21:16:07 +0300
Message-ID: <5501D7E7.6040603@cogentembedded.com>
References: <1426181032-2397-1-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426181032-2397-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>, lkml <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 03/12/2015 08:23 PM, John Stultz wrote:

> As part of the y2038 cleanups, this patch removes the do_gettimeofday
> usage replacing it with ktime_get.

> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>   drivers/ide/pdc202xx_new.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

> diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
> index df73cbd..94bd05f 100644
> --- a/drivers/ide/pdc202xx_new.c
> +++ b/drivers/ide/pdc202xx_new.c
[...]
> @@ -273,8 +274,7 @@ static long detect_pll_input_clock(unsigned long dma_base)
>   	 * Calculate the input clock in Hz
>   	 * (the clock counter is 30 bit wide and counts down)
>   	 */
> -	usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 +
> -		(end_time.tv_usec - start_time.tv_usec);
> +	usec_elapsed = (long)ktime_to_ns(ktime_sub(end_time, start_time))/1000;

    Please add spaces around / to be consistent with this file's (and general 
kernel) coding style.

>   	pll_input = ((start_count - end_count) & 0x3fffffff) / 10 *
>   		(10000000 / usec_elapsed);
>

MBR, Sergei
