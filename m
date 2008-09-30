From: "Jeffrey W. Baker" <jwbaker@gmail.com>
Subject: Re: SATA ALPM min_power causes > 10s delay on resume
Date: Mon, 29 Sep 2008 17:20:03 -0700
Message-ID: <1222734003.19009.1.camel@stinkpad>
References: <1219598870.11057.2.camel@stinkpad>
	 <48B928AC.8090007@kernel.org>
	 <fd145f7d0808301059y20e91ba7w22b9ddd6c54d9554@mail.gmail.com>
	 <48BA65E8.1080408@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:53100 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbYI3AUG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 20:20:06 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2556823rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 29 Sep 2008 17:20:05 -0700 (PDT)
In-Reply-To: <48BA65E8.1080408@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Sun, 2008-08-31 at 11:35 +0200, Tejun Heo wrote: 
> Jeffrey Baker wrote:
> > 2.6.24 (2.6.24-19-generic package in Ubuntu 8.04).
> 
> Can you please give more recent kernel a try?  2.6.26.3 preferably?

I wasn't able to try 2.6.26.3 but in 2.6.27 this seems fixed.

-jwb

