Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A005EC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  1 Mar 2022 14:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiCAOUr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Mar 2022 09:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbiCAOUq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2022 09:20:46 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374D19A9A8
        for <linux-ide@vger.kernel.org>; Tue,  1 Mar 2022 06:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646144405; x=1677680405;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vBaQ0UbZhx8vNzME+2c2QEiwGyK34ZDpHbyzSowRbV0=;
  b=X/ZcNEP/QwbA17eue5piqTzojecYQ3anz32VukypEw71D3oV00zhihP+
   K3iJ+Dh74H+7KnY2TKa1s9KQQjhYZgz8D88unXXxPB62VNcwo+XCpztb9
   i79K2xIRzlIPLRX9i1Pamj4+KbD38EgV6nUPi9ewQVd/56NAenISSmX6+
   Dur5Ij0d+YWHCqx3X8v/jgRDnLJWWjC2rRRTXmXTiBvAYq+tho8la06CU
   CQqCaVVGB03/+XtwCG1rzd3waRK2imP10DI96v8F9sVLgXKgL3IzCKH2F
   quRX1LD9JZEfm3n7Ga4YE2WW4RWyNtcrigeb19l2JMYTSWF3JlLj8S4/l
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,146,1643644800"; 
   d="scan'208";a="193127487"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2022 22:20:04 +0800
IronPort-SDR: 8xHKHFiszdS8wpBLu7ieHoQBGUPoM5V8iZsj7p2ZptGg3y64zpjKBbeHT3j3piNYCIg1zExsms
 1C61lgEvghSqmJKfJl+nLupi2tRLDz6zf2LGJQdthlUtVIIpY1LtaRBBLFI3X6PgSqaMjfstQX
 DGlXjpHDT6arb2BWoeuCv7p7LMkgMcWGn0BzYr9gqUsEH5YvvYmPEWjK9ycyHVju0RbOGvdrwc
 XoZfAgYYcSAQw4i0HC6m1oR4Qflqo5XqtzOikQ1kJYggO8R1MlT8pYvCUmT1GMiy/taLkeHg5i
 2UkRYFuo+PS1zAP6HhswklEl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:51:29 -0800
IronPort-SDR: ZjwIY8SzwAO3xAD/nUa3IoyoJsD827itMHf4T8y8J2SUrypv2oZmhuaOzPZ5fuI9eF9PqIqWLn
 cMyZf4wix1CLzODGWdZaOftrIgdXlmvh7SeCRLkdayshYkSxZdEjmjlJS+fTg/zBHLc8kvBaZQ
 7D/CwuqhpHU+uFbn+jMzZ1DlptWMUMv0xUQHv7v03n6zfvn5BFRPoEGAqh1ASxQ0sLY9/IjeND
 uVwuh/sjal2PQOzGQcu/Bi7R7LHaJIAgNQpbhd8Y/bshcmPOmiYeXihd8ggTbRJ4C8C3Yo8yDp
 xI8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 06:20:05 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K7KC84WkKz1Rwrw
        for <linux-ide@vger.kernel.org>; Tue,  1 Mar 2022 06:20:04 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646144403; x=1648736404; bh=vBaQ0UbZhx8vNzME+2c2QEiwGyK34ZDpHby
        zSowRbV0=; b=n92MS5wgF+d40BAo5D004O2+WhAqtdS1LozudLHeN5RbhyAJwS4
        kQtww3cGhEqZq/vts4Q4/3lsGTQC0bPH/yKMa29J+xXA4nsOUEnZhTgyppjS7eUw
        QYpn48UP0iC0u17961zuLKn9UmeTnvASUyoidZZ0pSvTv734B0yKylX6XpJ02/3D
        ev60HPqDXznF+wm9GeZfN165o81q4XWO+bPw0PqQ77TMCBrO99gdq+FwpiAMBEOd
        aBwlt3/n8uIWLSRQf0eeI3esvl4DZ/+jjCIgPzh4Qt23+4oEqutImiz1Yz2SHKch
        Tgo2nZFju3tXhL5o5f4tHkWFW7Rb3hsrpCA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z16ucCv1C4uy for <linux-ide@vger.kernel.org>;
        Tue,  1 Mar 2022 06:20:03 -0800 (PST)
Received: from [10.112.1.94] (c02drav6md6t.wdc.com [10.112.1.94])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K7KC639nHz1Rvlx;
        Tue,  1 Mar 2022 06:20:02 -0800 (PST)
Message-ID: <9ad7ffe0-90ed-d54e-3a20-8ab52886f4a6@opensource.wdc.com>
Date:   Tue, 1 Mar 2022 16:20:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] ata: ahci: Drop low power policy board type
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com
References: <20220228213302.2915071-1-mario.limonciello@amd.com>
 <Yh3WdvBYRTdXkyuk@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Yh3WdvBYRTdXkyuk@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/03/01 10:16, Christoph Hellwig wrote:
> I really like this and hope it can stick.  Needing quirk lists for
> sensible power policies is a bad thing.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>

I also think it makes sense. However, since we are already at rc6, I am going to
wait for the 5.18 cycle to apply this early on in rc1 so that we get plenty of
testing time and have time to revert if needed.


-- 
Damien Le Moal
Western Digital Research
