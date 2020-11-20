Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15D9C64E69
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 09:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9519D2236F
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 09:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T9h+DEjk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KYtyxa1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgKTJYa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 20 Nov 2020 04:24:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgKTJY3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 Nov 2020 04:24:29 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605864268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nKeWeXqWF+qPl0zbIG9umt42PI6XyksUGhAAg3m7/dI=;
        b=T9h+DEjk8Q1Z0jfp916FViN6zn+8vFtp7h0cK9FcLyCEsnKcJWhYhxH81MqAvv6HJPeJ2i
        T/fHORVFq/cHIsGfZ131h2uVDogTrFxGpop2sxd1p0VIc2fEmFmER9rYlZCU1LR4cMOvuo
        2pqPp7A4wFCxBa2RKpkRD6V7pPe8T/vXI8ERo08MVu8GyFyytmzTPq0dtyiobsiZESDQnO
        rIzUu6sNEVk2Wg5/dA4q57HoFGMbyimB2tiVAwtJxhFvFkJNjG99OOUc/0TrDM0YwHgTHF
        /5CGD8Jh+EUwWxxcVFI5OVPWWHOaO8cssvjIk8iVIX+aJ/mv9EzpPcu+pCGLNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605864268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nKeWeXqWF+qPl0zbIG9umt42PI6XyksUGhAAg3m7/dI=;
        b=KYtyxa1lVuyBrSNe/1X9lBEy3bljdPNlFi9VaTafX250MAPGJQV1ARAktW2toa5ZIaETnx
        HOccsG1YisDg6iCQ==
To:     linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de
Subject: [PATCH v2 0/2] ide: Remove in_interrupt().
Date:   Fri, 20 Nov 2020 10:24:19 +0100
Message-Id: <20201120092421.1023428-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In the discussion about preempt count consistency across kernel
configurations:

 https://lore.kernel.org/r/20200914204209.256266093@linutronix.de/

it was concluded that the usage of in_interrupt() and related context
checks should be removed from non-core code.

This ide subsystem has two in_interrupts() checks before mutex/wait-event
invocations.

Changes since v1=20=20=20=20=20=20
  https://lkml.kernel.org/r/20201113161021.2217361-1-bigeasy@linutronix.de
  - added acks
  - added lkml to Cc:

Sebastian

