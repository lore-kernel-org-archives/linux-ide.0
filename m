From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Thu, 24 May 2007 16:53:02 +0200
Message-ID: <4655A6CE.2010300@gmail.com>
References: <4655923E.5000409@effenberger.org> <46559713.9070201@gmail.com> <46559C62.2040509@effenberger.org> <46559F5B.4090700@gmail.com> <4655A588.40500@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:60231 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbXEXOxQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 10:53:16 -0400
Received: by py-out-1112.google.com with SMTP id a73so899857pye
        for <linux-ide@vger.kernel.org>; Thu, 24 May 2007 07:53:16 -0700 (PDT)
In-Reply-To: <4655A588.40500@effenberger.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Florian Effenberger wrote:
> Hi,
> 
>> Data integrity wise there should be no problem but your error rate is
>> pretty high and eventually will make libata turn off NCQ and/or speed
>> down PHY speed.
> 
> switching ports is not easy. Both on-board SATA controllers are being
> used, and the error seems to occur on all ports.

Hmmmm...

>> Yeap, your data is safe.  With timeouts, data transfer speed can be much
>> lower tho.  It definitely seems something is wrong with your hardware
>> setup.
> 
> I will try to use another test disk. Right now we use different models
> of Western Digital "RAID edition".
> 
> Any other debug information I could gather?

If you let the system run, libata will turn off NCQ and/or lower PHY
speed to 1.5Gbps.  Do errors disappear after that happens?

-- 
tejun
