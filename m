From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/4] pata_platform: Use 16-bit wide data transfer
Date: Thu, 18 Sep 2014 13:29:34 -0400
Message-ID: <20140918172934.GE13573@mtj.dyndns.org>
References: <1408790772-5305-1-git-send-email-shc_work@mail.ru>
 <1408790772-5305-3-git-send-email-shc_work@mail.ru>
 <20140823165326.GA13540@mtj.dyndns.org>
 <1408814955.452399984@f133.i.mail.ru>
 <20140825193454.GD21688@htj.dyndns.org>
 <20140825204817.0b8cdf68@alan.etchedpixels.co.uk>
 <20140918204020.6a7d5e7ab6b8eb8c88aa5aa6@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:43296 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756669AbaIRR3i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Sep 2014 13:29:38 -0400
Received: by mail-qg0-f49.google.com with SMTP id j5so1510436qga.22
        for <linux-ide@vger.kernel.org>; Thu, 18 Sep 2014 10:29:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140918204020.6a7d5e7ab6b8eb8c88aa5aa6@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello, Alexander.

On Thu, Sep 18, 2014 at 08:40:20PM +0400, Alexander Shiyan wrote:
> I did not understand a bit of the final solution...
> I hope I have clearly explained the original problem, which was written for
> this patch? This is not theory.

The solution is implementing separate 16 and 32 bit operations and
apply 16 bit ones only to the controllers which require 16bit
operation for correctness.

Thanks.

-- 
tejun
