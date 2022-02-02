Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957F6C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 19:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346876AbiBBTKp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 14:10:45 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:56178 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346887AbiBBTKm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 14:10:42 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru CAD5A20A88A5
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] libata: ata_host_suspend() always returns 0
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <b690e385-0e2b-d476-2590-01b2abf4811f@omp.ru>
 <e6dbc236-a8b5-7b2a-a016-71523d72c0ce@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <dc260159-fbb4-4006-a3d0-7147d70f5e6c@omp.ru>
Date:   Wed, 2 Feb 2022 22:10:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e6dbc236-a8b5-7b2a-a016-71523d72c0ce@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/2/22 10:47 AM, Damien Le Moal wrote:

>> ata_host_suspend() always returns 0, so the result checks in the drivers
>> are pointless.  However I chose not to change ata_host_suspend() to *void*
>> not to have to change
>>
>> 	return ata_host_suspend(...);
>> to
>> 	ata_host_suspend(...);
>> 	return 0;
> 
> Nice cleanup, I like it. But given how simple ata_host_suspend() is, I
> would prefer that it is turned into a void function...
> 
> My view is: if the function returns an int error code, it should be
> checked, always. If said function always return "success", then it
> should be void. This makes it clear for the users (the different
> drivers) how the function should be used.
> 
> With your change, anybody looking at the driver code and at
> ata_host_suspend() interface in the header file may think "the error
> check is missing", unless the person also look at the function code...

  This isseu largely eavdes me as I use Emacs' support of the TAGS file. :-)

> So let's simplify and make ata_host_suspend() a void function. There are
> not that many call sites to change. Not all users do "return
> ata_host_suspend()".

   OK, I've prepared 2 variants of this patch in anticipation of your reaction --
will just post the 2nd one. :-)

>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
[...]

MBR, Sergey
