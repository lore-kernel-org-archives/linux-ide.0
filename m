Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904D4C636CC
	for <linux-ide@archiver.kernel.org>; Tue, 31 Jan 2023 07:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjAaH2O (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Jan 2023 02:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjAaH2N (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jan 2023 02:28:13 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3AC11EA4
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 23:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675150092; x=1706686092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3ESuML21Vo+lVaZRwWJlv63h9XhTG4VjGVnTXl+S7A4=;
  b=l94yXHIbNGtf1g57kuEWwIOclFyLpu8yEva9S4auPAzyVSPh43cmlGK4
   XePjNCXSG3p0K2yaA14G8ReCSj9o+3Y56t6D+WFSCRLDpPto6mlpxpcbc
   GR+3cTND4k4WZo2ojL1hzdmzY+g3srHpur3gJ20Xbm3Y+S2JsRu+9nPbM
   pGuHuUSER16xPu+Do36GqXrRVzy5WK+3TK7b0K32KADKYHGrPwxIkOz4r
   qbRcs8Z/07b8mFKgNnwABjYww+FcYA2Adkaty0Pqi0ZNfm2yCf47wLfE8
   c5Gk9URRQ3t0u8SmBZ0uW6FcJpYl8KfoZpz8vutIxZngGBhZ0qbu05x14
   g==;
X-IronPort-AV: E=Sophos;i="5.97,259,1669046400"; 
   d="scan'208";a="220483207"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 15:28:11 +0800
IronPort-SDR: 6CwDN1kFtDftR0ko3PewoaF5KwYc5li0doPkBqSU1iYUq9nOLO1FvCHylLgWYXVvN6gLAozvZk
 Zi3fTUzMycNNPYrrpl9HmCYH4/QhgfIYf2DUrZJpYK+52GbLcUskNs/MEMwBWMlieoPiHF/H/u
 sP2b2EbcYVXw4d3NiW63MQecCRVmqRtymtIju46AYbKapBErQN5L4Yx6ThmIr0s2FSKGj2gZS/
 6ZJP+kFRFr/LAHmLmcOjGFu8GvPuDl/ShZlCv74sHo+OJrA7KD/YvXXlUqVMvIiXmS00NjwV44
 k10=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 22:45:36 -0800
IronPort-SDR: Yw5LmFfGvMNBVqksEm9sQVZUFqusI7nAHl4at8tl5hcUovwd9az9e7uifuvtQp5B2fOcmEJ7Qz
 NCY/tSZLt9PVb6fqhsWfOuVaZagc2q6QfQk8kHUl11UIFsh+TeMG1XTNHrKfMJVquVvhTXA8Nm
 WDkdai+/eNY3Z7sy/WZk9j0mk3+6cws70f569d7i625X0Qk0enxaYnd1C7xtYoZJP76ai3UtGJ
 53xEVaWfcep4ZZz684ih6p090DZUcAjv6bksDGpM6irezGgGHrlbx/mVMsIKbpYdDUWfX5JdZl
 DlE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 23:28:10 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P5c8q2hQ4z1RvTr
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 23:28:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675150091; x=1677742092; bh=3ESuML21Vo+lVaZRwWJlv63h9XhTG4VjGVn
        TXl+S7A4=; b=EU3tgUbBrcg8OuCI2J2LjO9CpdUWaZhweCi8qXFMXqYQ6G60JYI
        58PxThl43LXb92idV3AhlJIcuml6/eoAelMw7D+mlXPWoBtOrnakDUzaTOnsGqHn
        sGv6cUy4CgiOLmS5VxXaySMBZa50JPpvptPWvp+eNnDn6lknv1u1xOL27/g01BpW
        oQdCNjiJA/p3UiEpJdmQzAK+ASa0Oeo+Jp1kONxIyMKLJqA6RwfsGq1wXQW7AaFJ
        /asT3E7e5DX+z2UuMHScZ/8m0hRBfZqtm77/CPcJn/Er2H5OStjdaHxK1cZLK47Z
        oj+NpD2TmN7MTT5qryTyA7hfool2cS19sSA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mb7DVQrXgrZD for <linux-ide@vger.kernel.org>;
        Mon, 30 Jan 2023 23:28:11 -0800 (PST)
Received: from [10.225.163.70] (unknown [10.225.163.70])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P5c8p4VWLz1RvLy;
        Mon, 30 Jan 2023 23:28:10 -0800 (PST)
Message-ID: <1e069565-a391-0f33-0714-ba9cc3792a42@opensource.wdc.com>
Date:   Tue, 31 Jan 2023 16:28:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <1831eb01-5c84-54f1-7950-9b8e9bf0a046@opensource.wdc.com>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
 <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
 <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
 <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
 <7fe0b96f30bf787d339ba656d5d2df01@psihoexpert.ro>
 <db3fa398d4a1dcadb9df02d1001a61c6@psihoexpert.ro>
 <c7e1b214fca6c2a08dbce60006442dd8@psihoexpert.ro>
 <009822d6-24b8-739d-e7ee-13adc1c7d548@opensource.wdc.com>
 <55834657003f5a4579b326ee61fe1e80@psihoexpert.ro>
 <8cd8066ac1059ae0fef280a3cf6ab03c@psihoexpert.ro>
 <9490768bca8f5a213d89214ca9324fa0@psihoexpert.ro>
 <071bf5d4-4007-6779-60fd-82ec58dd44fe@opensource.wdc.com>
 <d8abdd49a63106081b4f899f8bc53dbe@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d8abdd49a63106081b4f899f8bc53dbe@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/31/23 16:20, marius@psihoexpert.ro wrote:
> January 31, 2023 1:22 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
> wrote:
>> 
>> I sent the official patch and CC-ed you. Can I add your "Tested-by: Marius
>> Dinu <marius@psihoexpert.ro>" tag to the patch and queue it ?
>> 
>> -- Damien Le Moal Western Digital Research
> 
> Yes, I was planning to reply myself, but I'm not done testing yet. At this
> point I can only say it's working on mvebu / Armada 385. I plan to backport
> to v5.15 and test with the other router that I have (mvebu / Armada XP), a
> laptop and two x86_64 desktops, one of which has various PATA and SATA
> controllers in all sorts of weird configurations. I hope to do it all this
> weekend. Thank you for the patch!
I did testing on Intel & AMD machines with different adpaters/drives/pmp that I
have (AHCI, ASMedia and Marvell adapters). Everything was OK on my end.

The tag is for this kernel only. If backporting to 5.15 does not solve the
issue, we will need to take that separately and redo debugging on that version.
I would like to send the patch to Linus by the end of the week...

> 
> Marius Dinu
> 

-- 
Damien Le Moal
Western Digital Research

