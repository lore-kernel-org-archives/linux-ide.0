From: Tejun Heo <htejun@gmail.com>
Subject: Re: Detection of hot plugging of e-SATA on a port multiplier
Date: Tue, 26 Jul 2011 08:29:51 +0200
Message-ID: <20110726062951.GU2622@htj.dyndns.org>
References: <CAL33XeQQZdknYVJN=XfvnLwdWxBwf1dBbKwQe+MKA7Deo3jsrA@mail.gmail.com>
 <20110721083926.GD3455@htj.dyndns.org>
 <CAL33XeRpPdr3PQYAnP8xGfSuotcns6wCLb8J8otJUYn9WXP2gg@mail.gmail.com>
 <20110722075942.GD2622@htj.dyndns.org>
 <CAL33XeSUnNUtbmMYW8NNc0epx-Q6jLYC-Aj-TVJk+5n6Sp818w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:60131 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab1GZG34 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jul 2011 02:29:56 -0400
Received: by eye22 with SMTP id 22so165887eye.2
        for <linux-ide@vger.kernel.org>; Mon, 25 Jul 2011 23:29:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL33XeSUnNUtbmMYW8NNc0epx-Q6jLYC-Aj-TVJk+5n6Sp818w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: vinit bidkar <vinitbidkar@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello, Vinit.
> I had some success in hotplug case. Loose connector was one of the issue.
> With the new connector, the kernel consistently does eror handling.
> I get following messages from kernel on hotplug.

You're looking at heavily patched driver on a kernel which is
half-a-decade old.  I'm afraid you wouldn't find much help here unless
you can somehow map the problem to upstream.

Good luck!

-- 
tejun
