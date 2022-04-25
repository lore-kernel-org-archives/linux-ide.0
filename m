Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD4BC433FE
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 12:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbiDYMOI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Apr 2022 08:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbiDYMOE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Apr 2022 08:14:04 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE502165A0;
        Mon, 25 Apr 2022 05:10:55 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 1465620AC3D5
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 5/5] doc: admin-guide: Update libata kernel parameters
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
References: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
 <20220407123748.1170212-6-damien.lemoal@opensource.wdc.com>
Organization: Open Mobile Platform
Message-ID: <1a50f793-251e-7971-7b92-0990d91f4815@omp.ru>
Date:   Mon, 25 Apr 2022 15:10:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220407123748.1170212-6-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/7/22 3:37 PM, Damien Le Moal wrote:

> Cleanup the text text describing the libata.force boot parameter and
                   ^^^^           
   Once is enough. :-)

> update the list of the values to include all supported horkage and link
> flag that can be forced.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 71 ++++++++++++++-----
>  1 file changed, 55 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3f1cc5e317ed..30734a610b92 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
[...]
> @@ -2639,7 +2639,7 @@
>  			host link and device attached to it.
>  
>  			The VAL specifies the configuration to force.  As long
> -			as there's no ambiguity shortcut notation is allowed.
> +			as there is no ambiguity, shortcut notation is allowed.

   Dunno what you have against more informal style in the kernel... :-)

[...]
> @@ -2652,19 +2652,58 @@
[...]
> -			* dump_id: dump IDENTIFY data.
> +			* [no]setxfer: Indicate if transfer speed mode setting
> +			  should be skipped.
                                ^ (not)

[...]

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

MBR, Sergey
