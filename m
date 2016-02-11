From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: fix HDIO_GET_32BIT ioctl
Date: Thu, 11 Feb 2016 10:10:30 -0500
Message-ID: <20160211151030.GW3741@mtj.duckdns.org>
References: <1455196595-3466120-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455196595-3466120-1-git-send-email-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Soohoon Lee <Soohoon.Lee@f5.com>, stable@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Feb 11, 2016 at 02:16:27PM +0100, Arnd Bergmann wrote:
> As reported by Soohoon Lee, the HDIO_GET_32BIT ioctl does not
> work correctly in compat mode with libata.
> 
> I have investigated the issue further and found multiple problems
> that all appeared with the same commit that originally introduced
> HDIO_GET_32BIT handling in libata back in linux-2.6.8 and presumably
> also linux-2.4, as the code uses "copy_to_user(arg, &val, 1)" to copy
> a 'long' variable containing either 0 or 1 to user space.

Applied to libata/for-4.5-fixes.

Thanks a lot!

-- 
tejun
