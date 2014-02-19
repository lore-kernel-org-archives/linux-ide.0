From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] atm: libahci: replace obselete simple_strtoul() with
 kstrtouint()
Date: Wed, 19 Feb 2014 16:40:49 +0400
Message-ID: <5304A651.6080701@cogentembedded.com>
References: <1983660.RVkLooTtjT@daeseok-laptop.cloud.net> <20140219.010509.484470671732800480.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:53536 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaBSMkp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Feb 2014 07:40:45 -0500
Received: by mail-lb0-f175.google.com with SMTP id p9so244118lbv.20
        for <linux-ide@vger.kernel.org>; Wed, 19 Feb 2014 04:40:44 -0800 (PST)
In-Reply-To: <20140219.010509.484470671732800480.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>, daeseok.youn@gmail.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 19-02-2014 10:05, David Miller wrote:

>>  From 18bd7236f36a248a0871f810cec3c1e98f098a91 Mon Sep 17 00:00:00 2001
>> From: Daeseok Youn <daeseok.youn@gmail.com>
>> Date: Wed, 19 Feb 2014 13:44:24 +0900
>> Subject: [PATCH] atm: libahci: replace obselete simple_strtoul() with
>>   kstrtouint()

>> Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>

> Please fix your Subject line, you meant "ata: " not "atm: "

    And "obsolete". :-)

WBR, Sergei

