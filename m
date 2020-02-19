Return-Path: <SRS0=BS17=4H=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2778DC34050
	for <linux-ide@archiver.kernel.org>; Wed, 19 Feb 2020 14:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA96B24656
	for <linux-ide@archiver.kernel.org>; Wed, 19 Feb 2020 14:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgBSOW4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:22:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:32999 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgBSOW4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 Feb 2020 09:22:56 -0500
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j4QFZ-000220-MG
        for linux-ide@vger.kernel.org; Wed, 19 Feb 2020 14:22:53 +0000
Received: by mail-pl1-f200.google.com with SMTP id w17so251848plq.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Feb 2020 06:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=MLzunwtdiwZE8X3dSBg1bcU+Imt/wqtftJaxuJ1ldhU=;
        b=EmNyziiMCjFtT2QynVz3FvIsnAVvlEjGn2kxy3mUceiaAlGi20WlTiAy0orXur2A1V
         Ec/z/an0Zwo097LrM/VZMfN7znJ7EJbCb2e98LkWGwCGRlmQCxnhhd0bLaeBFrztyrhr
         dydy+aKtfIvZS5zxi3dwes2QNqurLK7ljMBsN4SFXgbvNsm5doYSXDTpWPg+pSMOysrV
         /jY4XozsXs8TyX1Cw4exfkx2aIZGsLShjtDhLeuRTrH15+66ymXtGLcmUcZUzEVHZ0l7
         d7NuwZ1zamzUA+v66DrYjfwP/8MYfrVnTvk45nTI5B/mnvJ+5MxOCXU5m+8VHXN+DrCy
         e4Uw==
X-Gm-Message-State: APjAAAXb1ymLxTOcftDmU72Jbn28+ZT+S9oKWugkJFetjJz6CstvIfmx
        A7xHyDpri83HxdND87sxL8KUWdaH0VyYjTIh47wnwf/eHjVpzcXFnLkDI0m3FGMsNp/cUjO2MaR
        SCApVpKSf7rpG9zfhjlBIzqG+TxlLhcVE6h2sOg==
X-Received: by 2002:a63:f84b:: with SMTP id v11mr27755929pgj.133.1582122172397;
        Wed, 19 Feb 2020 06:22:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAf9zQyTPVPbMjR6FbxyzaCj2ekLS3doKIrUEPzVc140+FEtyEVjAoXaVkdyd8BTxOWOpurg==
X-Received: by 2002:a63:f84b:: with SMTP id v11mr27755913pgj.133.1582122172066;
        Wed, 19 Feb 2020 06:22:52 -0800 (PST)
Received: from 2001-b011-380f-3214-7181-50ee-02bc-c2ee.dynamic-ip6.hinet.net (2001-b011-380f-3214-7181-50ee-02bc-c2ee.dynamic-ip6.hinet.net. [2001:b011:380f:3214:7181:50ee:2bc:c2ee])
        by smtp.gmail.com with ESMTPSA id w26sm3190144pfj.119.2020.02.19.06.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 06:22:51 -0800 (PST)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Hard Disk consumes lots of power in s2idle
Message-Id: <0955D72C-D24D-402E-884F-C706578BF477@canonical.com>
Date:   Wed, 19 Feb 2020 22:22:48 +0800
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-ide@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Kent Lin <kent.lin@canonical.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Srinivas,

Your previous work to support DEVSLP works well on SATA SSDs, so I am asking you the issue I am facing:
Once a laptop has a HDD installed, the power consumption during S2Idle increases ~0.4W, which is quite a lot.
However, HDDs don't seem to support DEVSLP, so I wonder if you know to do proper power management for HDDs?

Kai-Heng
