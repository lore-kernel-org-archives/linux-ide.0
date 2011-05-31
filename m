From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI driver fails to IDENTIFY in kernel 2.6.39, adapter card ASUS
 U3S6 (Marvell 1b4b:9120)
Date: Tue, 31 May 2011 23:16:08 +0900
Message-ID: <BANLkTikJwWSt6sO0zO_pjJ_yvBxbeG7kcg@mail.gmail.com>
References: <20110530135133.1642dc87@ime5.iment.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40964 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756625Ab1EaOQJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 May 2011 10:16:09 -0400
Received: by qwk3 with SMTP id 3so2099218qwk.19
        for <linux-ide@vger.kernel.org>; Tue, 31 May 2011 07:16:08 -0700 (PDT)
In-Reply-To: <20110530135133.1642dc87@ime5.iment.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Kosinski <prk@iment.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

On Tue, May 31, 2011 at 2:51 AM, Paul Kosinski <prk@iment.com> wrote:
> With the 2.6.39 kernel, the situation is reversed: the card's USB3
> works, but SATA doesn't. In particular, the booting process reports
> "failed to IDENTIFY (I/O error, err_mask=0x4)" for disks attached to
> that adapter, even after trying lower link speeds.

Does irqpoll kernel parameter make any difference?

Thanks.

--
tejun
