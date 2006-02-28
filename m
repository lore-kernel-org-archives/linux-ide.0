From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Feature request: HDD status
Date: Wed, 1 Mar 2006 01:55:30 +0200
Message-ID: <41840b750602281555q493323c1y37d3d3fb25e3d087@mail.gmail.com>
References: <E1FEESA-0002vG-00@porton.narod.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.180]:51176 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932697AbWB1Xzb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Feb 2006 18:55:31 -0500
Received: by pproxy.gmail.com with SMTP id i49so969059pye
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 15:55:30 -0800 (PST)
In-Reply-To: <E1FEESA-0002vG-00@porton.narod.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Victor Porton,,," <porton@ex-code.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 3/1/06, Victor Porton,,, <porton@ex-code.com> wrote:
> Linux would be able (if this is possible for software) to
> deliver to the user the state of the HDD, whether it is
> active.
>
> I mean that Linux would have a module which would export to
> user space a boolean flag (probably a semaphore) which would
> be true while the HDD red lamp is shining and false while it
> is dark.

You can get a fair approximation of that information by monitoring
/proc/diskstats or the relevant counter files under /sys. Simply turn
on the logical LED if the IO counter has been incremented in the last
(say) 30ms. The only time this is likely to be noticable different
than the physical LED is when the drive is in some initialization
state or error condition.

For an amusing ready-made graphical version, try the gkhdplop plugin of gkrellm.

  Shem
