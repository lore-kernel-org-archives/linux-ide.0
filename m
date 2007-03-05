From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] libata hpa support
Date: Mon, 05 Mar 2007 12:47:17 +0900
Message-ID: <45EB92C5.7010305@gmail.com>
References: <20070223170625.GA29931@athena.road.mcmartin.ca>	<20070223181959.56502bf2@lxorguk.ukuu.org.uk>	<20070224180047.GA6204@athena.road.mcmartin.ca> <20070225000934.71253b30@lxorguk.ukuu.org.uk> <45E0C780.7000805@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:34108 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbXCEDrU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Mar 2007 22:47:20 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1633013nze
        for <linux-ide@vger.kernel.org>; Sun, 04 Mar 2007 19:47:20 -0800 (PST)
In-Reply-To: <45E0C780.7000805@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Kyle McMartin <kyle@canonical.com>, linux-ide@vger.kernel.org, mjg59@ubuntu.com

Jeff Garzik wrote:
> Alan wrote:
>>> Right, so we can leave the policy to be just disabling it by 40p/80p
>>> cable
>>> type for now... Sigh.
>>
>> The only compatible policy is always act on it.
> 
> Agreed.

The problem here is that "always acting" is incompatible with the
"current behavior".  So, we're screwed either way.

-- 
tejun
