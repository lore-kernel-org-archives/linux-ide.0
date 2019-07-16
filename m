Return-Path: <SRS0=eAlM=VN=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E044C7618F
	for <linux-ide@archiver.kernel.org>; Tue, 16 Jul 2019 14:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BE520693
	for <linux-ide@archiver.kernel.org>; Tue, 16 Jul 2019 14:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yObKvC/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfGPOOb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:14:31 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33672 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfGPOOb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jul 2019 10:14:31 -0400
Received: by mail-pl1-f179.google.com with SMTP id c14so10169495plo.0
        for <linux-ide@vger.kernel.org>; Tue, 16 Jul 2019 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g5W5c9h5rEAna9FYX8o5KrkhH9q8qIi2HGrrRE+1uDc=;
        b=yObKvC/YpYLvnj4Ut+R4aGVEyw0egJ0/juKocfCtCcjgT/+x2J4gi3qfetGgi4aXTf
         XWprf92gjNemRg6NTVtywAeR67rX1UDVNQoC6tfWjOG4hWh04aInSLbCxj7kKRGxchAL
         w1KiRIfip38+LlT9xcLtTlxh/5zNEpjbfgshxet2AYvX8NNeh2uQ5v1pGvedlUxzoFJ3
         CyINhJzdEUS2m4eA75mbDAmsMgdW205TVvWeQaLGpSgRoXHRNBCF4Xj4ejAQlPX4ZASV
         QHmo6lneoqUwqAyM7fI7jAmWVd7G1Sjffu/eUPrUPFOpXuV2rCF4no9VkHbWJoPWT3bl
         M5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g5W5c9h5rEAna9FYX8o5KrkhH9q8qIi2HGrrRE+1uDc=;
        b=krhbwnB889PNMLUAk/gCL6QtJZxYunIjxoOMLhRB3jHVqjloOg8nAv9fLSmMO0cs6k
         6oq3YKUC4ct443m4mSuRpuL6Tx6S8KMLX38seXSEehL09MZ4QL4Ln/PL9H8urdavjIyl
         eMw5TxzowxvAm29vEEWr78EODELODoCSa5nLzpeMCE3q3NrwJfH+jbFWAxQDGUN0hdm3
         TAXUaLrimCmRkUBGrQEUa8vqiDPUYd48XJOVRA70DiBcOEg6/G6CXJ2yVas8XldoEG4y
         5yWL4tOvNrNiSwCbm9yYLe6aKi2cTluaC7NIGG135CirMDWbbf8ysxjLOtvgkSrUBOtX
         7LQQ==
X-Gm-Message-State: APjAAAVi4ErPCoa/ShFruMFJenG2dFHedef+t4OL1kSMwAwDH1QyFMNb
        by6cZs6gU5vGFS8GfCkg0anCYINasvk=
X-Google-Smtp-Source: APXvYqydAOkHKt2eRDYLw8RfG2Njxgiwow31G4vj88RzPwLzjTbPntCblFlcy4E3p7cyI6nA2qQ1/w==
X-Received: by 2002:a17:902:b20c:: with SMTP id t12mr36112320plr.285.1563286470866;
        Tue, 16 Jul 2019 07:14:30 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 21sm9638336pfj.76.2019.07.16.07.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:14:29 -0700 (PDT)
Subject: Re: [PATCH] ata: libahci_platform: remove redundant dev_err message
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>, hdegoede@redhat.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1563270848-11223-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1ed44587-ffaf-6774-8954-cdffff881f5d@kernel.dk>
Date:   Tue, 16 Jul 2019 08:14:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563270848-11223-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/16/19 3:54 AM, Ding Xiang wrote:
> devm_ioremap_resource already contains error message, so remove
> the redundant dev_err message

Applied, thanks.

-- 
Jens Axboe

