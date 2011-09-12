From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] ata: Make pata_of_platform.c compile again and work on
 non-PPC platforms
Date: Mon, 12 Sep 2011 18:22:24 +0400
Message-ID: <20110912142224.GA3671@oksana.dev.rtsoft.ru>
References: <1315398986-10078-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64553 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012Ab1ILOW2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Sep 2011 10:22:28 -0400
Received: by wyh22 with SMTP id 22so3549544wyh.19
        for <linux-ide@vger.kernel.org>; Mon, 12 Sep 2011 07:22:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1315398986-10078-1-git-send-email-pawel.moll@arm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: linux-ide@vger.kernel.org

On Wed, Sep 07, 2011 at 01:36:26PM +0100, Pawel Moll wrote:
> This patch adds missing #includes, makes the driver selectable on
> non-PPC OF-enabled platforms and fixes property value accesses to
> be correct in Little Endian system.
> 
> Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

On Mon, Sep 12, 2011 at 03:16:52PM +0100, Pawel Moll wrote:
> It seems your ack got lost when vger.kernel.org was down...
>
> Would you mind re-posting it?

Sure thing.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
