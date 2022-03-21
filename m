Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86466C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 21 Mar 2022 06:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbiCUG4G (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Mar 2022 02:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiCUG4F (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Mar 2022 02:56:05 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1FE3615A
        for <linux-ide@vger.kernel.org>; Sun, 20 Mar 2022 23:54:39 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5aef4e.dynamic.kabel-deutschland.de [95.90.239.78])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 33F1261E6478B
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 07:54:36 +0100 (CET)
Message-ID: <96413496-73ac-5016-026d-c07d37762fed@molgen.mpg.de>
Date:   Mon, 21 Mar 2022 07:54:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     linux-ide@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: How to enable verbose message guarded by flag `ATA_EHI_QUIET`?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear Linux folks,


`drivers/ata/libata-eh.c` contains

     int verbose = !(ehc->i.flags & ATA_EHI_QUIET);

guarding some log messages, I’d like to see for all controllers/hosts 
and links/devices.

How can I disable the flag `ATA_EHI_QUIET`? Is that what the module 
parameter `force` is for? It’d be great if you could give me an example, 
or point me to the documentation.


Kind regards,

Paul
