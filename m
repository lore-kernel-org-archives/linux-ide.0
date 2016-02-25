From: Tejun Heo <tj@kernel.org>
Subject: Re: kernel crash with lite-on sata controller Dell XPS 13 9343
Date: Thu, 25 Feb 2016 16:51:30 -0500
Message-ID: <20160225215130.GK6092@mtj.duckdns.org>
References: <56CF75E6.5070803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34904 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcBYVvc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Feb 2016 16:51:32 -0500
Received: by mail-yw0-f180.google.com with SMTP id g127so54467450ywf.2
        for <linux-ide@vger.kernel.org>; Thu, 25 Feb 2016 13:51:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56CF75E6.5070803@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carolin Latze <carolin.latze@gmail.com>
Cc: hdegoede@redhat.com, linux-ide@vger.kernel.org

Hello, Carolin.

On Thu, Feb 25, 2016 at 10:45:10PM +0100, Carolin Latze wrote:
...
> Since the beginning (started with 3.19.x kernels on this notebook) I had
> problems with this sata controller:
> 
> 03:00.0 SATA controller: Lite-On Technology Corporation Device 0224 (rev 10)
> 
> Very often during boot, the boot just failed with error messages like
> 
> ata1.00: exception... (I was only able to capture them by taking a picture:
> https://launchpadlibrarian.net/227876135/IMG_20151128_230313.jpg)
> 
> Then I keep trying, sometimes I boot into Windows inbetween, and eventually,
> the kernel comes up.
> 
> Then, when running and putting a lot of load on the disk (e.g. running dump
> or a simple update via apt-get upgrade), the system looses its disk and I
> have to hard reset.
> 
> The machine runs perfectly fine under Windows, so I don't believe it is a
> hardware issue.
> 
> I hope there is a solution to this issue.

Can you please boot with libata.force=noncq and if that fails post the
kernel messages of the failure?

Thanks.

-- 
tejun
