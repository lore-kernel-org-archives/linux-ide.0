From: Tejun Heo <htejun@gmail.com>
Subject: Re: Ubuntu 9.04 (2.6.28-14) and eSATA Port Multiplier (PMP) Not
 working
Date: Fri, 14 Aug 2009 18:06:44 +0900
Message-ID: <4A852924.3050000@gmail.com>
References: <e3fccfde0908101354y4e98a985nc119d8941e8b1665@mail.gmail.com>	 <4A8242C5.3060605@gmail.com> <e3fccfde0908121530j4f7abe0as34b0f7e3813f8e53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:8957 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbZHNJGs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Aug 2009 05:06:48 -0400
Received: by wa-out-1112.google.com with SMTP id j5so287678wah.21
        for <linux-ide@vger.kernel.org>; Fri, 14 Aug 2009 02:06:49 -0700 (PDT)
In-Reply-To: <e3fccfde0908121530j4f7abe0as34b0f7e3813f8e53@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris K <kayex@rogers.com>
Cc: linux-ide@vger.kernel.org

Hello,

Chris K wrote:
> I gave the 2.6.30-2 kernel a try and I received the same error message
> as quoted below - it just happened a bit later on in the boot process.
> (not at the "starting.." screen)

Does libata.force=1.5Gbps kernel parameter make any difference?

Thanks.

-- 
tejun
