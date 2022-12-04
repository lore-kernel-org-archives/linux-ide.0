Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07393C4332F
	for <linux-ide@archiver.kernel.org>; Sun,  4 Dec 2022 10:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiLDKWn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 4 Dec 2022 05:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiLDKWl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 4 Dec 2022 05:22:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD17D2719
        for <linux-ide@vger.kernel.org>; Sun,  4 Dec 2022 02:22:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CF8F60CEB
        for <linux-ide@vger.kernel.org>; Sun,  4 Dec 2022 10:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D70C433C1;
        Sun,  4 Dec 2022 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670149358;
        bh=5cbdQ9gMSoN2h1h7pudkAKiouwwiCDanBbjGSD4svH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3ulMdYgJTxF3TVxQ4vXoAtDDJuxLYIiD/SZ1qdYtIRz6CbsE2Ams4lCE4HSFxOpz
         7IiPxRZji0H8v8AYCge0R8z/Z17oxkceHy9bkKMcWrgpBEuiDdgD+vKx2uK5R62uG2
         ujHTT/E61mMcnS3mL5iG7eIaa2LHd45YyUiIOGc8g/nwsVuq1nfcUBjvANzFrxUAge
         kiyiCqEZqrt361/owh8S27iQDajF6YQJMkyCgT/0fVF9HBCwKknYlHG3QIEKpCBp+R
         OEppm/rBBHjiVk4raXQIiZtdhWVn4Lu/vmn6lpt1LHsDHJQz1qZhaqgU8GMh7frLEO
         xtRyxqSoOxJ7g==
Received: by pali.im (Postfix)
        id 5D5C6895; Sun,  4 Dec 2022 11:22:35 +0100 (CET)
Date:   Sun, 4 Dec 2022 11:22:35 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     marius@psihoexpert.ro
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Subject: Re: Bug report for ahci-mvebu driver
Message-ID: <20221204102235.n4z2fjmxk5hbjiwd@pali>
References: <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sunday 04 December 2022 01:41:20 marius@psihoexpert.ro wrote:
> So, it works!

Perfect! So you found it.

> What next? Should I contact David Milburn <dmilburn@redhat.com> (the commit author) and ask for a better fix?

That is a good idea.

> @ Pali Rohar:
> I could't find the errata you mentioned. If you have it, please take a look at the commit above and see if it is affected in any. Thanks.

I do not have more details than what I already wrote in previous email.

Errata documents are in most cases available on Marvell Customer Portal.
You need to register for accessing them. https://www.marvell.com/portal

Documents which were available publicly without registration are here:
https://www.kernel.org/doc/html/latest/arm/marvell.html
(errata for a38x was not publicly available)
