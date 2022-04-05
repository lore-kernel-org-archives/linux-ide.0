Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4228CC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  5 Apr 2022 04:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiDEEhh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Apr 2022 00:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiDEEhW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Apr 2022 00:37:22 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDDE65BB
        for <linux-ide@vger.kernel.org>; Mon,  4 Apr 2022 21:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649133285; x=1680669285;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vaxdEvOIKTPP9ACiHd6DRhWXVl5w76xkSLjz1eIi0NU=;
  b=kqoqjvDM0aajCD8TfMMf/8WMIwOI14MEDfr6X9QA+DAYg0dQN45367np
   4lak9f85tUE8DrwAos7g0XzXdKEFqUy+fk01yekZwUW93lAXNNZsTZnVQ
   ebG6K42YXDLTrcb57ihtomBNEfI0nVWdjI440HejXs+dOTLTps2NL7oBC
   tuVHhab4nx8gYskYKjaJhpCo5ZNiXQOxttQwcCwtDcsq2Ye3690TihXbA
   Ef6zDwjKd12Zt9uUQQxIRSp2/YHaB9RV7xHwWQTNoSqJMBwaGKu5rTgeY
   Zkj13zIgj9eOvxOdjYJcORuDGppshWRdtgH5mZRMtS1KJBMNwHiAhMhJX
   w==;
X-IronPort-AV: E=Sophos;i="5.90,235,1643644800"; 
   d="scan'208";a="309062974"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Apr 2022 12:34:44 +0800
IronPort-SDR: v8xXQUeyNbNzP3Yg4vqa7KQVCqy1E/DBGCQZQ0iiFHwEsfvWiftJFgmfnZ76VaTi92vbvkT2Ni
 tKe2138hZPm65K9YjEv3zAAYuMwfog1pP5wv9pMnNXX2siCBFPrq+D3jehwYqYQUKFJxfs6hDC
 kdpGMJuISrmuhYjn8da7p/DXxHsnCKjLMIxPYkAEzN7t26MS3ESNbOpxCkS7k3VRpvuFopCnYC
 o3t0bbwqof+tZEveGa3vg+BOqLCI6HSjuoJcVrcBAksyOzamKWQfIBFwmxfNq+63plX0cZUHAL
 wkhUXmrLeM8LoyUrM+HL1VJy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 21:05:28 -0700
IronPort-SDR: 4rdl9bMU9+8LYBaquu1jmxe44XL8tXmNTmuTk0k6wkRs+H6DQutc1LLHnzJ7kiY1i5a9j2GTOK
 XIY/S54YM3fuHdY7lcAHV07yHwxbqL6ku1c3XjqB+Nb25yx90NMedkYrFsjAl2gFHRXyV2d/KN
 ZeBXHxDYtWdzFCIPdbK3tWs8lesvyOp9dzVho7BI6JOxkcMN701Rr3k+wiLiZMywXbs7Lxqg11
 nLfRRnY6vyzXOm/WGNE0kyy/AbvSFxp5dz9uUxDrRext0SQFU1Kcyk/WkdVVz9xBygDLFQQAa8
 eBo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 21:34:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KXZYc2k76z1Rwrw
        for <linux-ide@vger.kernel.org>; Mon,  4 Apr 2022 21:34:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649133283; x=1651725284; bh=vaxdEvOIKTPP9ACiHd6DRhWXVl5w76xkSLj
        z1eIi0NU=; b=PpVNb133lJQ9lLmbH8WCbuzDy8iC3/0GfkXemwMTx0kgdX9TR81
        WK+h7IAHWWmYZMGqpRkkI4HkWPo882KnBBQ/9/YJ+854Wix64D7Q/Ux82VKxtQOd
        kPLPYMeChhOvpCPnaNzsdTseuzrPHkVsrfBX1DJYbhQSkKdqfgKMLSz0FZVfUQZW
        /K5MoY+sJLdPga5NzTTp2MqGJzyQfqKu1rmE22MGxzwf6FCOZTMsB8YjiIncV6+n
        Hl0bfYUqT6ZRTl0/zON+bKxWT4m2avtQSG5uUlplwRRAX2WTq7Wvnjc2ZM4wF1Bp
        wGy72RQOVWCxEGYUPUC4phh3lgHQUPV4PyQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nfPTu0vHe_7p for <linux-ide@vger.kernel.org>;
        Mon,  4 Apr 2022 21:34:43 -0700 (PDT)
Received: from [10.225.163.2] (unknown [10.225.163.2])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KXZYb0VB2z1Rvlx;
        Mon,  4 Apr 2022 21:34:42 -0700 (PDT)
Message-ID: <a0598c8f-692a-fcb8-9553-32f6947a8fc3@opensource.wdc.com>
Date:   Tue, 5 Apr 2022 13:34:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] ata: ahci: Rename CONFIG_SATA_LPM_POLICY
 configuration item back
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com
References: <20220404200202.9388-1-mario.limonciello@amd.com>
 <20220404200202.9388-2-mario.limonciello@amd.com>
 <YkvGp7c8QLf5i/j0@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YkvGp7c8QLf5i/j0@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/5/22 13:33, Christoph Hellwig wrote:
> On Mon, Apr 04, 2022 at 03:02:02PM -0500, Mario Limonciello wrote:
>> CONFIG_SATA_LPM_MOBILE_POLICY was renamed to CONFIG_SATA_LPM_POLICY in
>> commit 4dd4d3deb502 ("ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY
>> configuration item").
>>
>> This caused some pain as users would invisibly lose configuration policy
>> defaults when they built the new kernel.  To help alleviate that, switch
>> back to the old name (even if it's wrong).
> 
> Note that for this to be useful it would have to go into 5.18.

Yep, that's the plan. I will send it for rc2.

-- 
Damien Le Moal
Western Digital Research
