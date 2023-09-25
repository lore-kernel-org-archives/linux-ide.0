Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3920CE7A81
	for <linux-ide@archiver.kernel.org>; Mon, 25 Sep 2023 09:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjIYJ12 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Sep 2023 05:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjIYJ11 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Sep 2023 05:27:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3F7E3
        for <linux-ide@vger.kernel.org>; Mon, 25 Sep 2023 02:27:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AE7C433C7;
        Mon, 25 Sep 2023 09:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695634040;
        bh=1xOQZqn1hcw4yF0b3i0TmZXBS/WlT/rjIWJ/9ILJx8Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eZMh6dcD3pBeW1kTdPUs9uWkY7a9VvtNoxQiQ2tKfkA2pnAl/k1giW8F8G5xl+g6f
         BL0BzDbPdPKRSYwmTjeSFDP+YeNrmDEnoXkj8J8oh31BtbLg+2qvxdV0EQV+zY5Wj8
         i83Ts49XFxNApGfAxx/pEpOJk0hai3eBQ1+EHdlEjN60aEq8NaZ8+C1AsMZXwlRz66
         usgmNHToFFpr9DkQ/XRSR74jg5m/7ZVnHVHXtYv3OcfgTAM+BODqVYQnFptdE72icB
         qGlYBcKMlSxCz1MjJNaepAOaLnKTZIwKUHk4hamOtyRytWC32ZnOocoDVjMN3mF/ae
         hdSgOxshcn69g==
Message-ID: <385141b8-4d02-cecb-7393-7375f095198f@kernel.org>
Date:   Mon, 25 Sep 2023 11:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] ata: ahci: Add Intel Alder Lake-P AHCI controller to low
 power chipsets list
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-ide@vger.kernel.org, Koba Ko <koba.ko@canonical.com>
References: <20230925080538.2894982-1-mika.westerberg@linux.intel.com>
 <e58ddf0f-3b7e-9599-dd7d-c6ed322d1184@kernel.org>
 <20230925091339.GM3208943@black.fi.intel.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230925091339.GM3208943@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/09/25 11:13, Mika Westerberg wrote:
> Hi,
> 
> On Mon, Sep 25, 2023 at 11:09:01AM +0200, Damien Le Moal wrote:
>> On 2023/09/25 10:05, Mika Westerberg wrote:
>>> Intel Alder Lake-P AHCI controller needs to be added to the mobile
>>> chipsets list in order to have link power management enabled. Without
>>> this the CPU cannot enter lower power C-states making idle power
>>> consumption high.
>>>
>>> Cc: Koba Ko <koba.ko@canonical.com>
>>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> Looks OK, but given that there is a tendency of the low power stuff to be buggy,
>> was this well tested ?
> 
> Yes it was tested (Koba Cc'd can confirm this). We also confirmed from
> Intel AHCI folks that the ADL (and RPL) AHCI controllers fully support
> this configuration.
> 
>> Also, does this need a Fixes/CC stable tag ? If not, I
>> will queue this for 6.7.
> 
> Up to you :) Typically PCI ID additions can go to stable as well. No
> fixes tag needed, though (there is no commit that this one fixes).

OK. I will not add a CC stable for now. If requested, we can trivially backport
this later.

> 
> Thanks!

-- 
Damien Le Moal
Western Digital Research

