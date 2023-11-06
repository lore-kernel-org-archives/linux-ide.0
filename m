Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8165AC4167D
	for <linux-ide@archiver.kernel.org>; Mon,  6 Nov 2023 13:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjKFNYn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Nov 2023 08:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjKFNYm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Nov 2023 08:24:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADCBF1
        for <linux-ide@vger.kernel.org>; Mon,  6 Nov 2023 05:24:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32405C433C7;
        Mon,  6 Nov 2023 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277079;
        bh=YfG/Lyeshebus3ecFJ/efHLFHBlkiz/DFiA9xe4Uiog=;
        h=Date:From:To:Subject:From;
        b=N64ajw6Ad1fqkrHm8eVEIT3Y4dbp/UsrmaLpSjj0rd+uvLlDAVpTr9rkIpjT+y86D
         wQ80uLr6W76K6bab+Grez7ZbgsAPlfw02Actuy9o0+WHNj5ki3DCoT14KZB6FyDFVC
         sxTXLdZ9MGHP4vD8HL2aLar7gEaaUNPHz0ZICOt8=
Date:   Mon, 6 Nov 2023 08:24:38 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-ide@vger.kernel.org
Subject: PSA: migrating linux-ide to new vger infrastructure
Message-ID: <20231106-stoic-blazing-rabbit-da57fd@nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Good day!

I plan to migrate the linux-ide@vger.kernel.org list to the new infrastructure
this week. We're still doing it list-by-list to make sure that we don't run
into scaling issues with the new infra.

The migration will be performed live and should not require any downtime.
There will be no changes to how anyone interacts with the list after
migration is completed, so no action is required on anyone's part.

Please let me know if you have any concerns.

Best wishes,
-K
