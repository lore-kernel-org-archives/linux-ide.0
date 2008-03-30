From: Tejun Heo <htejun@gmail.com>
Subject: Re: Analysis of EH on Andi's dying disk and stuff to discuss about
Date: Sun, 30 Mar 2008 20:03:07 +0900
Message-ID: <47EF736B.5010700@gmail.com>
References: <20080328093055.GA16736@basil.nowhere.org> <47EDECE5.50309@gmail.com> <47EEAC3F.2070004@rtr.ca> <47EEB0B4.2050808@garzik.org> <20080330070319.GA7156@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:15908 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbYC3LDO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Mar 2008 07:03:14 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1389291wah.23
        for <linux-ide@vger.kernel.org>; Sun, 30 Mar 2008 04:03:13 -0700 (PDT)
In-Reply-To: <20080330070319.GA7156@basil.nowhere.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, ric@emc.com

Andi Kleen wrote:
>> Also, ATAPI sometimes takes quite a while to respond, I've seen, when 
>> media is in the driver.
> 
> Surely ATAPI could get other defaults than disks?

The driver doesn't know if it's an ATA or ATAPI during probing reset but 
after detection, yeah, we can use 10s, 10s, 15s timing for ATAs.

-- 
tejun
