From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] tx493[89]ide: Remove big endian version of tx493[89]ide_tf_{load,read}
Date: Mon, 06 Apr 2009 20:22:40 +0400
Message-ID: <49DA2C50.6000108@ru.mvista.com>
References: <1239034146-3514-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:14132 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750804AbZDFQWH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 12:22:07 -0400
In-Reply-To: <1239034146-3514-1-git-send-email-anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Atsushi Nemoto wrote:

> Now tx493[89]ide_tf_{load,read} do not contain word I/O operations.
> They are endian-free now.

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

    Oops, now this clashes with my patchset (not applied to pata-2.6 AFAICS). 
I guess I'll have to repost it... Bart?

MBR, Sergei
