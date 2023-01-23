Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4C0C05027
	for <linux-ide@archiver.kernel.org>; Mon, 23 Jan 2023 14:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjAWOFN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Jan 2023 09:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAWOFM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2023 09:05:12 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8968040F2
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2023 06:05:11 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 36so9014103pgp.10
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2023 06:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rPTKRw4vaCXH+c58imr82AJLumb+jLT5z1/ANZ9MJqg=;
        b=aAdR8QL6poCFHbJPJIYSClVH9PsKwI5oYqNKCG/TkY0BoiVrwjP5qzNW0fz1dtOiyy
         OUIlRigPO4e2Fk4Y9qKz7G1o5DjDjVhhMGfFfe4eubjnzOn8i9nyUqvI6eeZgMhQ9ONX
         QNUbfe4kizUEr5aJNL1zus4RjR+p0hcE4GppAMzHyplFRAQCx8ckTDU09lS7iPJi+jDF
         LG057KdoVv8GHwpjK8joGuwpYeIGbnMbSo97f7QsO8QTdY0MzDlOQI0hvQYSidhmhiCP
         N0fAGrmtD8rFUFPGiGBGUXjuvAdo4I7HZe4nmgW5crOaDE5pJre+7fHAM8YRCOX003tM
         wsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPTKRw4vaCXH+c58imr82AJLumb+jLT5z1/ANZ9MJqg=;
        b=m8uzLPYQNBZShivX++syRJyZwwaVyITOmVeBDL3KrwFxul19eIOi73smrz0xfi/V86
         lotZBHda5NXIdJRa3vBPEoVIkuo9Ov82fzUkNjcRh5d/j+TSCxSXuiTU6ESqdZ3EDh2X
         vO/ZawMCDYfmfIYM6kw4Z298jEWoDwdGBsfa0p2NJ2+G/qBqugC86mI+aboa5/qEQn3E
         aI+9zcrJeJ5QKkRpikcnQMVOCC8Qkq7+A3rH3R22+BDxCaQlflw9dSQ+eABo6qrIaYBL
         fdlTR76hh77c1SzSnw/2xrWJPZHctuJs0KQ4QAnt2UNVd0D7TWOTMXlxrdPxeBHi+0zJ
         nhxQ==
X-Gm-Message-State: AFqh2kq0J8xqghDMGnNGEmqvZJX97KktwgVIFXp1WXVT0LzBIdbXDTa2
        L9t6w3870LM0L6QrdQqnHrhCkg==
X-Google-Smtp-Source: AMrXdXudjdGBMdeZ91zQe4dGWth+Npl7Zx+hAMeaQ1vE6rcqpOTlrhIK8uFkMrwxpQ6DuZYh02s36g==
X-Received: by 2002:aa7:8c51:0:b0:582:d97d:debc with SMTP id e17-20020aa78c51000000b00582d97ddebcmr6298054pfd.3.1674482710960;
        Mon, 23 Jan 2023 06:05:10 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79f86000000b0057726bd7335sm24811739pfr.121.2023.01.23.06.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 06:05:10 -0800 (PST)
Message-ID: <5220ea3b-1508-e7a7-f532-fcd6b9b07d94@kernel.dk>
Date:   Mon, 23 Jan 2023 07:05:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230121225314.32459-1-linux@zary.sk>
 <20230122075710.GA4046@lst.de>
 <38af9155-b940-d4df-b6cd-7420d1183927@kernel.dk>
 <20230123065207.GA30529@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230123065207.GA30529@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/22/23 11:52 PM, Christoph Hellwig wrote:
> On Sun, Jan 22, 2023 at 11:24:32AM -0700, Jens Axboe wrote:
>> Since Ondrej is probably one of the few (maybe the only) user of this
>> code, why don't we just kill off the paride code in a separate patch
>> right after?
> 
> That seems a little too fast too me.  I'd give it at least another merge
> window if not two.

It's not going to matter in this case. If we do it immediately or after
two releases, nobody else is going to have noticed that message and
decided "Oh, let me just switch over and test the other one". And since
it's stuff that hasn't been released since the 90s, let's just get it
done.

-- 
Jens Axboe


