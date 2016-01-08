From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] drivers: libata-core: Use usleep_range() instead of
 msleep() for short sleeps (<20 ms)
Date: Fri, 8 Jan 2016 10:36:18 -0500
Message-ID: <20160108153618.GO1898@mtj.duckdns.org>
References: <1452230332-14926-2-git-send-email-danielwa@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452230332-14926-2-git-send-email-danielwa@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Walker <danielwa@cisco.com>
Cc: Anil Veliyankara Madam <aveliyan@cisco.com>, xe-kernel@external.cisco.com, Shikha Jain <shikjain@cisco.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jan 07, 2016 at 09:18:52PM -0800, Daniel Walker wrote:
> From: Anil Veliyankara Madam <aveliyan@cisco.com>
> 
> Since msleep() may sleep longer than intended time for values less
> than 20ms, this patch allows the use of usleep_range for waits less
> that 20ms. usleep_range is a finer precision implementation of
> msleep and is designed to be a drop-in replacement for udelay
> where a precise sleep/busy-wait is unnecessary.
> 
> More details can be found at http://lkml.org/lkml/2007/8/3/250
> and in Documentation/timers/timers-howto.txt.
> 
> This change has been done to improve the performace in PIO6 mode
> which is used by viking flash.
> 
> Cc: xe-kernel@external.cisco.com
> Signed-off-by: Anil Veliyankara Madam <aveliyan@cisco.com>
> Signed-off-by: Shikha Jain <shikjain@cisco.com>

Applied to libata/for-4.5.

Thanks.

-- 
tejun
