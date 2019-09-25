Return-Path: <SRS0=6af8=XU=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12833C432C1
	for <linux-ide@archiver.kernel.org>; Wed, 25 Sep 2019 07:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80A52082F
	for <linux-ide@archiver.kernel.org>; Wed, 25 Sep 2019 07:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLP1GszK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405459AbfIYHRM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:17:12 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:43185 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405047AbfIYHRM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Sep 2019 03:17:12 -0400
Received: by mail-pf1-f172.google.com with SMTP id a2so2823561pfo.10
        for <linux-ide@vger.kernel.org>; Wed, 25 Sep 2019 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZGG+XhdJwc3mnkny0UBwkeQgZR0mVnH4Mrbj8XI+dZs=;
        b=CLP1GszKkMdGbE5CtYBCvQlokQT82xjaiG6AwVwzdwMG/NBOyN2bXpD5G29ltPICYE
         TwudbZWuorPDVYCrVt8nEmWCQCC7clXp2JWXd8MZlk4sjT2C19GGu8zgeekFS3K3Ov3G
         XqOxkaKe2QyZ0HuoomGKRhToVameDncHvkHrxAUzQAoLI7QTKezdSZvNQ125db3A8bcV
         n83Ku9fMNJPNwxCE1FNt/NfXrbPQEZBDpN1jDm6SlUHDZS3pMwYn/8+16nyBk74tCES0
         405TNFw0RgEY0YGk7ewb1FH5FSuyICM5qp4mNjPH8XVAvld3MNMENf8zqhSbQN45Htcq
         JKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZGG+XhdJwc3mnkny0UBwkeQgZR0mVnH4Mrbj8XI+dZs=;
        b=ssmKarcGnUOLrClGst5FqcdL8pQbRKu7gV/V2hzjqbRMNFZOQZ7/fy8fS+8zkKJ8X4
         IMaXxjPs61BiJFMFTEeZvpBPHg3m7ws2dTg+rgZOaXbSOUP9Oubsi4fuqn38HVywJkqZ
         QncqOYp8pAy6bZOhdwQh5/OQXSk0EiHegmMjmcKSLe0DA8qM594yV5YQtTOxYuh3EaKd
         PxrN7mRgqWu1kBGaE6pTE5XZuN0eIbubOLP+RC7DPuaR7sAefeRXoOHlZ2kznMxqGt1U
         DjDYxSSBSzkDuFqC7ey9RipsFsYU6T+x630RNa4r1L2PEtJnhU30zNOAgWMDlqy6YZTm
         2bPQ==
X-Gm-Message-State: APjAAAURfN8O7183KVBYZMII2E9gHoGsISjdveEgwqrbKbnrjvbnHL4w
        9w72v3esniBRYj7h5cEifno=
X-Google-Smtp-Source: APXvYqzZ+W0DJgZbvOydt6hDLohi+Y66QwXNXJNTAwiB3qNqD5kYJ3kFmxUDHy1+Hg6H4KKY9A5sow==
X-Received: by 2002:a62:f249:: with SMTP id y9mr8112029pfl.147.1569395831816;
        Wed, 25 Sep 2019 00:17:11 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id q204sm3431502pfc.11.2019.09.25.00.17.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Sep 2019 00:17:11 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 57AE1360079; Wed, 25 Sep 2019 19:17:07 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com
Subject: [PATCH v2 0/2] Convert Atari Falcon IDE driver to platform device
Date:   Wed, 25 Sep 2019 19:17:03 +1200
Message-Id: <1569395825-29426-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


As suggested by Geert, at least one of the drivers available for the Falcon
IDE interface should be converted to a platform device driver (to enable
module autoloading by the Debian installer).

Add platform device for Falcon IDE (patch 1), and rewrite the present
libata driver to make use of that device (patch 2).

Incorporated review comments by Geert, and fixed mismatch between platform
resource and platform driver name that prevented the earlier version from
loading as builtin driver.
  
Tested on ARAnyM with only the pata_falcon driver builtin.

Cheers,

	Michael
