From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: fix drive side 80c
 cable check, take 3
Date: Fri, 13 Jul 2007 13:12:39 +0900
Message-ID: <4696FBB7.2030806@gmail.com>
References: <20070205074535.GE1625@htj.dyndns.org> <20070205105744.6f22fc7d@localhost.localdomain> <20070205124106.GK1625@htj.dyndns.org> <20070205132706.1ff6d761@localhost.localdomain> <20070205142119.GM1625@htj.dyndns.org> <4696758F.7040403@ru.mvista.com> <469677EC.703@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:4219 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbXGMEMo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 00:12:44 -0400
Received: by wa-out-1112.google.com with SMTP id v27so438344wah
        for <linux-ide@vger.kernel.org>; Thu, 12 Jul 2007 21:12:43 -0700 (PDT)
In-Reply-To: <469677EC.703@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org

Sergei Shtylyov wrote:
>>    Wrong, wrong as well! The correct value to compare with would be
>> 0x4000.
> 
>    Sorry for the false alarm -- those opposite senses on CBLID- have
> really confused me. :-<

Yeah, all those cable detection mess plays tricks on minds.  PATA is
really screwed up in that area.

-- 
tejun
