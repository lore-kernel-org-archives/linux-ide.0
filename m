From: Jack Williams <jacwil014@gmail.com>
Subject: Re: [PATCH] [BUG] libata: NULL pointer panic in ata_eh_link_report()
Date: Fri, 23 Jan 2015 00:38:53 -0800
Message-ID: <CABzz894zot6AXFbUFjhWo3SVYrGnRpeRvw1Vb9zSe85izyQXsg@mail.gmail.com>
References: <1421972514-2034-1-git-send-email-jacwil014@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f195.google.com ([209.85.223.195]:61385 "EHLO
	mail-ie0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbbAWIiz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2015 03:38:55 -0500
Received: by mail-ie0-f195.google.com with SMTP id rd18so1057206iec.2
        for <linux-ide@vger.kernel.org>; Fri, 23 Jan 2015 00:38:55 -0800 (PST)
In-Reply-To: <1421972514-2034-1-git-send-email-jacwil014@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jack Williams <jacwil014@gmail.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

All,

Sorry for the noise. Please disregard the prior email I sent. Not only
did a fix already exist in the 'scsi/for-next', but it was merged into the
Linux-next tree a few hours ago. Oh, and I Cc'd wrong people for
bonus points. :(
