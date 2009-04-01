From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] at91_ide: remove custom tf_{ead|load}() methods
Date: Wed, 01 Apr 2009 23:20:17 +0400
Message-ID: <49D3BE71.2010904@ru.mvista.com>
References: <200904012317.48069.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:51310 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758276AbZDATTq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Apr 2009 15:19:46 -0400
In-Reply-To: <200904012317.48069.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Hello, I wrote:

> Since tf_{read|load}() methods of this driver have now become identical to their
> standard counterparts using MMIO accesses, there's no need to override those
> anymore...

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    Oops, the subject should've had "read" ISO "ead" -- I'll repost...

MBR, Sergei
