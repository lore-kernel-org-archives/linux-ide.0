Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F96C04FDE
	for <linux-ide@archiver.kernel.org>; Tue, 13 Dec 2022 10:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbiLMKiF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 13 Dec 2022 05:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiLMKiA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 13 Dec 2022 05:38:00 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61163DF8B
        for <linux-ide@vger.kernel.org>; Tue, 13 Dec 2022 02:37:55 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:37:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1670927870; x=1671187070;
        bh=ramVaX+rP6qNrHig4YOKLdGCI200iav62+xSsuuKoJM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Sc9K8GUSrV0cKSUIH6TZz63E4UqcJFoHQN4O2SqRwx/j7yzrm5Mygvi8+LUMrGo02
         CZIs/mZovNIKDlkcQ42Er6M8eLhRbN3brgzpChkIa1ql/5M1R903NA94a6MCppNtDL
         AqKSBoA8G9mCKhYL6jh1GyyL9OcafgMl32QNdoOGyCBz2vVNaXtQL/N917K0ERHk14
         F4a6ImU+Y/r1Y4KleplvJrLuSgkBYW9bbApTr/95W7cb6SV8nKrkOrJAB0Dv7/BwKo
         cedXMeLwVjroddLGdkIXplkrY9cR/M/qoDM1arixZ43hmbGFif9pge5KkdKmkWBRRI
         tKUu8bKvieT8A==
To:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
From:   Adam Vodopjan <grozzly@protonmail.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v4] ata: ahci: Fix PCS quirk application for suspend
Message-ID: <yYZw0u5_0qQf-imEIyKpbp2kriN50kP7Ig_mWjSDAUNHfPQaRlmcBdz_PLuf9vAR6EmuwLWvr15o2duq83yeE7wzcxs3TIVvWQU54-xZfWU=@protonmail.com>
In-Reply-To: <vl5wEUZGVJ2BjH9t6T0GGSs9qLIE5A7NQkpDYGJB6iFamXyhw1zjnrx-TeO-XJB2doendW_7lDvNblGJLb_YeehRZN0iyUHXyvdQ6Em1aXI=@protonmail.com>
References: <vl5wEUZGVJ2BjH9t6T0GGSs9qLIE5A7NQkpDYGJB6iFamXyhw1zjnrx-TeO-XJB2doendW_7lDvNblGJLb_YeehRZN0iyUHXyvdQ6Em1aXI=@protonmail.com>
Feedback-ID: 34388925:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Damien, have you seen this version of the patch?
