From: Tejun Heo <htejun@gmail.com>
Subject: Re: Timeout error, disk gone
Date: Tue, 13 Mar 2007 23:16:10 +0900
Message-ID: <45F6B22A.80500@gmail.com>
References: <et5nhr$3ul$1@sea.gmane.org> <20070313130450.489f9e86@lxorguk.ukuu.org.uk> <20070313132115.GY1527@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:64090 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030346AbXCMOQP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 10:16:15 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2018392wxd
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 07:16:14 -0700 (PDT)
In-Reply-To: <20070313132115.GY1527@smurf.noris.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: smurf@smurf.noris.de
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

smurf@smurf.noris.de wrote:
> Hi,
> 
> Alan Cox:
>> What model and what firmware ? There are some problem firmware releases
>> around with older SATA drives
> 
> Samsung SP2004C, firmware version unknown -- how do I find out?

Please post the result of 'lspci -nn' and full boot log.  Samsung
firmwares tend to be pretty good but I've seen earlier ones occasionally
lock up after certain PHY events.  Removing power and reapplying puts it
back into sane state.

-- 
tejun
