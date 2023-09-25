Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D8BCE7A89
	for <linux-ide@archiver.kernel.org>; Mon, 25 Sep 2023 09:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjIYJNv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Sep 2023 05:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjIYJNt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Sep 2023 05:13:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C374CDA
        for <linux-ide@vger.kernel.org>; Mon, 25 Sep 2023 02:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695633222; x=1727169222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hdx1sv1qk4ihOuSHAwbiqgOADdenQYLnXMVbLMCCE0w=;
  b=PkUiLIpj4Lwnh0rzoAosZ+Qjm3hWJvPYAUw30rZI0yBlKt4NC1dvjvsy
   mvKMgw6l1cReIjoKoH9TdOhH9PYimH5SWjOJz0xBYcK7WX09hs/Tiwsl9
   PbpBrj4/MC+fPJCqi6lxKuRKqZWKocyVIwLgH9O/XDQq0LK/vinJFuHFP
   BER37gcuvxCsLk8IsU0eDJgvqTJTRb1UE+wb5Jnii///oO9NEHXQUSs6S
   PaJXbZ1mGkmRlWX9+CQlEI07HB+HhFU0b5EPvsoHWgDWmjFVJz5Y3316e
   lAcccqRBVtDR1lG22+B76bUtpaxC7uQRGCcx0CoT8Uy25vxpSq5LJ0C8n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360588174"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="360588174"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 02:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="751604174"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="751604174"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 25 Sep 2023 02:13:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A6AD21C7; Mon, 25 Sep 2023 12:13:39 +0300 (EEST)
Date:   Mon, 25 Sep 2023 12:13:39 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, Koba Ko <koba.ko@canonical.com>
Subject: Re: [PATCH] ata: ahci: Add Intel Alder Lake-P AHCI controller to low
 power chipsets list
Message-ID: <20230925091339.GM3208943@black.fi.intel.com>
References: <20230925080538.2894982-1-mika.westerberg@linux.intel.com>
 <e58ddf0f-3b7e-9599-dd7d-c6ed322d1184@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e58ddf0f-3b7e-9599-dd7d-c6ed322d1184@kernel.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On Mon, Sep 25, 2023 at 11:09:01AM +0200, Damien Le Moal wrote:
> On 2023/09/25 10:05, Mika Westerberg wrote:
> > Intel Alder Lake-P AHCI controller needs to be added to the mobile
> > chipsets list in order to have link power management enabled. Without
> > this the CPU cannot enter lower power C-states making idle power
> > consumption high.
> > 
> > Cc: Koba Ko <koba.ko@canonical.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Looks OK, but given that there is a tendency of the low power stuff to be buggy,
> was this well tested ?

Yes it was tested (Koba Cc'd can confirm this). We also confirmed from
Intel AHCI folks that the ADL (and RPL) AHCI controllers fully support
this configuration.

> Also, does this need a Fixes/CC stable tag ? If not, I
> will queue this for 6.7.

Up to you :) Typically PCI ID additions can go to stable as well. No
fixes tag needed, though (there is no commit that this one fixes).

Thanks!
