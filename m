From: Tejun Heo <htejun@gmail.com>
Subject: Re: Timeout error, disk gone
Date: Tue, 13 Mar 2007 23:21:52 +0900
Message-ID: <45F6B380.2020704@gmail.com>
References: <et5nhr$3ul$1@sea.gmane.org> <20070313130450.489f9e86@lxorguk.ukuu.org.uk> <20070313132115.GY1527@smurf.noris.de> <45F6B22A.80500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:18059 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030383AbXCMOV7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 10:21:59 -0400
Received: by ug-out-1314.google.com with SMTP id 44so292344uga
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 07:21:57 -0700 (PDT)
In-Reply-To: <45F6B22A.80500@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: smurf@smurf.noris.de
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> smurf@smurf.noris.de wrote:
>> Hi,
>>
>> Alan Cox:
>>> What model and what firmware ? There are some problem firmware releases
>>> around with older SATA drives
>> Samsung SP2004C, firmware version unknown -- how do I find out?
> 
> Please post the result of 'lspci -nn' and full boot log.  Samsung
> firmwares tend to be pretty good but I've seen earlier ones occasionally
> lock up after certain PHY events.  Removing power and reapplying puts it
> back into sane state.

Oh and I'm pretty sure it was the drive which locked up.  If you connect
the harddrive to different working port without removing power, the same
timeouts happen while the original port detects and works fine with
another hotplugged drive.  And for the record, among the earlier SATA
drives, samsung ones were definitely in the better group.

Also, please include full log of failure.  Thanks.

-- 
tejun
