From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fwd: Re: libata pmp support
Date: Mon, 27 Aug 2007 19:34:42 +0900
Message-ID: <46D2A8C2.4020204@gmail.com>
References: <0E3B1CAFCEB8484D8071762F8538E90320D12E@ELTIMAIL.elta.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:64398 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbXH0Ket (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Aug 2007 06:34:49 -0400
Received: by wa-out-1112.google.com with SMTP id j4so2005515wah
        for <linux-ide@vger.kernel.org>; Mon, 27 Aug 2007 03:34:48 -0700 (PDT)
In-Reply-To: <0E3B1CAFCEB8484D8071762F8538E90320D12E@ELTIMAIL.elta.co.il>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Weksler Izik <weksler@elta.co.il>
Cc: linux-ide@vger.kernel.org

Hello,

Weksler Izik wrote:
> I did it yesterday with the 2.6.22.5 vanilla from kernel.org. It 
> works. I don't have the dmesg output here - I'll send it to you in 
> the evening. Generally: It defines ATA2 as Config disk but doesn't 
> wait for device ID and doesn't perform several resets - no delay 
> during the boot. Which actually has been the target of the fix. 
> Otherwise the kernel boots OK and performs well.

Good to hear that.

> Do you want more info besides the dmesg? What other test do you want 
> me to run with the new kernel?

dmesg should be enough for now.

> As a matter of fact with this kernel looks like many things work
> faster. Is it because of the performance improvements or because it
> is without SUSE patches?

Hmmmmm.... Can you be more specific about 'many things work faster'?  If
anything is slower on SUSE, I'd like to hear about that.  They're paying
my lazy ass after all.  :-)  Please file a bug report at
bugzilla.novell.com and cc teheo@novell.com.

Thanks.

-- 
tejun
