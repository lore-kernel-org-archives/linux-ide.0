From: Tejun Heo <htejun@gmail.com>
Subject: Re: Port Multiplier Patch 2.6.22.1 on Alpha
Date: Sun, 09 Sep 2007 09:12:19 +0200
Message-ID: <46E39CD3.6000109@gmail.com>
References: <46D638A3.2030704@23palmer.net> <46D64290.2010306@garzik.org> <46D64AAA.7090808@23palmer.net> <46E30B95.10806@gmail.com> <46E3706A.3040102@23palmer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:11699 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbXIIHN4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Sep 2007 03:13:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1127476wah
        for <linux-ide@vger.kernel.org>; Sun, 09 Sep 2007 00:13:56 -0700 (PDT)
In-Reply-To: <46E3706A.3040102@23palmer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Evans <tom@23palmer.net>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tom Evans wrote:
> No real performance change, but the # of unaligned kernel  goes from ~14
> to zero on my system.
> 
> It's really just cosmetic I believe.

Care to post signed-off patch?

-- 
tejun
