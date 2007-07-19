From: Tejun Heo <htejun@gmail.com>
Subject: Re: ALi SATA problem
Date: Thu, 19 Jul 2007 17:01:13 +0900
Message-ID: <469F1A49.80801@gmail.com>
References: <200707181117.41129.pavel@netsafe.cz> <200707181138.01161.pavel@netsafe.cz> <469DE14A.60101@gmail.com> <200707181423.08921.pavel@netsafe.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:39582 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760979AbXGSIBU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jul 2007 04:01:20 -0400
Received: by wa-out-1112.google.com with SMTP id v27so533189wah
        for <linux-ide@vger.kernel.org>; Thu, 19 Jul 2007 01:01:19 -0700 (PDT)
In-Reply-To: <200707181423.08921.pavel@netsafe.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Mateja <pavel@netsafe.cz>
Cc: linux-ide@vger.kernel.org

Pavel Mateja wrote:
>> Sigh... The controller is telling the driver that "there's something
>> going on this port (hotplug event), please take look".  Can you try
>> hotplug some device at those ports and report the resulting kernel log?
> 
> Hotplug was working in cca 1 of 8 attemps.

Can you attach full kernel log and annotate it with when you hotplugged
a device?

Thanks.

-- 
tejun
