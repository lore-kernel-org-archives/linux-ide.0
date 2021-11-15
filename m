Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5E9C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 15 Nov 2021 08:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE7461BFD
	for <linux-ide@archiver.kernel.org>; Mon, 15 Nov 2021 08:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhKOISC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Nov 2021 03:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhKOIR6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 Nov 2021 03:17:58 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C33C061746;
        Mon, 15 Nov 2021 00:15:03 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id t127so8649699vke.13;
        Mon, 15 Nov 2021 00:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xW/67NTDls+AQBecTda6JoZytjWJ644lT/RbFu2z3fY=;
        b=hTnkAyzdW22Hcal9RqXHw9g67fPiEEhJ7Jr2a4MPzrCaluIRScv3scJMJKVk+IsZSP
         ABGP/bITlvsSOijmyfabGbUebX8C4PyfZMxV2LJQsh8DX5i3y68Q+uG8ajlDYHquNMT6
         83wd1uGIiDbjcTWS9IfSLgoHAFuz17oN7Ewp0BuePodCo36IL+P3PytFv6KDUOs8KmOD
         ehfuK7VgT9FFj5nQVmAF8X7hPFTml5x6Ba5vhDSf+/lNQQf4gb0VrH9sUllsQHMXBc8s
         IBwbz/J94ws2T8IRPhXlYiwgzjk9YNiN4343CI8ks866BUO10kfZlboSXtWmDRaHSXbL
         kKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xW/67NTDls+AQBecTda6JoZytjWJ644lT/RbFu2z3fY=;
        b=R4sKH0d1DdP0Z68j4sNuhfpzUEd+VXgjCJKYZCByNP/+F2cf489oUQJuiFS66gJPz8
         n2F2rIfb7FyvPwC3NCCsbPVdHOGfUDo8FibYLZEPpM6kI7Y2zwucgq1ms7RLeFWludAA
         /K5Sl1Jsn3kUeIU0laOj6+cwvQOgdQkjUawZ2cVZGX9BLHiOUgxs4Rob7qzYrfKsQ4U7
         n/wqiBhxeAvngT+41WFxGSEoB5hL2mzbh4YConctPsHdALdL5cmUhaNZA65/tOuGi0y2
         jdK4VUGFKctG3SY74AF+ErpropZgVK2rLof6sKvnu/Jz3Grf8NzbHTdfoH0H4VkdaL49
         eocg==
X-Gm-Message-State: AOAM532WP3xP0KA+TIIBOXsfbRsO+K5RIpP+MS8NN9WvwKme+PFZDzXj
        9PqKl2385nleR1RX0cG6nMzcRCB0fH/Ua+GVAZAm93rD
X-Google-Smtp-Source: ABdhPJyYG51GdeIH12hPpxNe7LoSy8M5VHKjtJOXH/PCAydAxorFEYz4RDwkS4aYCg7y9cygsxBHPKHnyvwSpKoxb8U=
X-Received: by 2002:a05:6122:884:: with SMTP id 4mr55829588vkf.6.1636964101899;
 Mon, 15 Nov 2021 00:15:01 -0800 (PST)
MIME-Version: 1.0
References: <YZABtvQab/M2CCQd@msi.localdomain> <14b22c98-dc4c-fe3b-fa20-b3dd78afd5cc@opensource.wdc.com>
In-Reply-To: <14b22c98-dc4c-fe3b-fa20-b3dd78afd5cc@opensource.wdc.com>
From:   "Nikolas L." <knv418@gmail.com>
Date:   Mon, 15 Nov 2021 11:14:50 +0300
Message-ID: <CAMJR_v6igrNZMzXpio27PpA6rQvo+efAVd2nM5GNg2+agQa9=A@mail.gmail.com>
Subject: Re: PROBLEM: [drivers/ata] Read log page failed (boot error message)
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

> This error is not fatal. It simply means that the drive does not support the
> INDENTIFY DEVICE log page. Nothing to worry about.
I suppose it's not the reason to log error, maybe warn or notice.
> Attempting to read this log should be avoided in this case though. I will send a
> patch to fix that.
Thank you! Got it.
> However, the files you attached show that you are using
> kernel 5.12
According to almost any file in attachment, I'm using 5.15.2.
Error happens only since 5.15, tested on 5.14.16.
> You can ignore the read log error, unless your drive is not functional ?
Yes I can and I will. Entire problem is just about redundant noise
with error level in kernel log.
