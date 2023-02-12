Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34B2C636D3
	for <linux-ide@archiver.kernel.org>; Sun, 12 Feb 2023 15:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBLPDZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Feb 2023 10:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLPDZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2023 10:03:25 -0500
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Feb 2023 07:03:22 PST
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D1412582
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 07:03:22 -0800 (PST)
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id C81332F87B79
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 15:53:23 +0100 (CET)
Received: from s981.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id B9B6B2E2788B
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 15:53:23 +0100 (CET)
Received: from s476.loopia.se (unknown [172.22.191.5])
        by s981.loopia.se (Postfix) with ESMTP id B8B4522B192F
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 15:53:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
Received: from s980.loopia.se ([172.22.191.5])
        by s476.loopia.se (s476.loopia.se [172.22.190.16]) (amavisd-new, port 10024)
        with LMTP id G03KoL89O6jc for <linux-ide@vger.kernel.org>;
        Sun, 12 Feb 2023 15:53:23 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: magnus@elfvendahl.com
X-Loopia-Originating-IP: 87.249.183.111
Received: from [192.168.1.175] (87-249-183-111.ljusnet.se [87.249.183.111])
        (Authenticated sender: magnus@elfvendahl.com)
        by s980.loopia.se (Postfix) with ESMTPSA id 55D8E2201821
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 15:53:23 +0100 (CET)
Message-ID: <e19a0e0a-b925-3509-0ea3-bfb2c65d4912@elfvendahl.com>
Date:   Sun, 12 Feb 2023 15:53:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-CA
To:     linux-ide@vger.kernel.org
From:   Magnus Elfvendahl <magnus@elfvendahl.com>
Subject: The SATA_ini162x.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi

Is there a workaround to activate the driver again?

We have a small production server that stopped working due to Ubuntu 
disabling access to the drives connected to the controller.

Fortunately for us, we are not using the RAID function of the unit, only 
using it as a disc-controller. That is, the pass-through function.

I have been ill for a long time and not been able to start doing 
research as the what the issue is, and I just found this information.


Best regards.

Magnus

