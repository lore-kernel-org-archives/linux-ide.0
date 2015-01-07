From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH][RFC] ide: pdc202xxx_new: Remove do_gettimeofday() usage for ktime_get
Date: Wed, 07 Jan 2015 22:37:50 +0100
Message-ID: <1721240.TWtHUuoOhJ@wuerfel>
References: <1420664493-7041-1-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:50606 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbbAGVhy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jan 2015 16:37:54 -0500
In-Reply-To: <1420664493-7041-1-git-send-email-john.stultz@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

On Wednesday 07 January 2015 13:01:33 John Stultz wrote:
> +       usec_elapsed = (long)ktime_to_ns(ktime_sub(end_time, start_time))/1000;
> 

This should use ktime_us_delta for brevity. Doing the 32-bit division that
you have here is probably slightly more efficient because it avoids do_div(),
but it's not performance critical.

	Arnd
