From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 10/10] libata: fix (hopefully) all the remaining problems
 with devices failing setup/identify
Date: Tue, 23 Oct 2007 16:35:49 +0900
Message-ID: <471DA455.2030909@gmail.com>
References: <200710022053.l92Kr5Rj021706@imap1.linux-foundation.org> <4703FF2E.5080409@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:25133 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbXJWHf6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 03:35:58 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1414008rvb
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 00:35:58 -0700 (PDT)
In-Reply-To: <4703FF2E.5080409@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Jeff Garzik wrote:
> akpm@linux-foundation.org wrote:
>> From: Alan <alan@lxorguk.ukuu.org.uk>
>>
>> Two fixes in this test patch.  One of them allows old CF cards to refuse
>> pio mode setting, and one to wait for the drive to settle after a set
>> features changes the speed settings, which is based upon the workarounds
>> used by drivers/ide.
>>
>> Please test and report back if you have an afflicted system.  This patch
>> isn't for merging just testing.
>>
>> The CF card fix will still display errors when the card works (got fixes
>> for that once I know the cure works) but should then be found/usable.
>>
>> Not signed off by anyone, not for merging
> 
> applied to libata-dev.git#for-testing, a throwaway branch for things
> like this

(It has been quite some time.  I'm catching up after a series of family
events and moving.)

I don't think this would make any difference.  Transfer mode
configuration is done using polling to work around problems like this
and because some controllers and devices raise IRQ too early.

-- 
tejun
