From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 3/3] implement PMP support, take 2
Date: Mon, 24 Jul 2006 15:56:58 +0900
Message-ID: <44C46F3A.10203@gmail.com>
References: <11523382873130-git-send-email-htejun@gmail.com> <44BE9805.10604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:58906 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751203AbWGXJ4k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 05:56:40 -0400
Received: by py-out-1112.google.com with SMTP id t32so2506051pyc
        for <linux-ide@vger.kernel.org>; Mon, 24 Jul 2006 02:56:06 -0700 (PDT)
In-Reply-To: <44BE9805.10604@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Modulo the comments sent, this patchset looks pretty good...

Thanks.  Glad to hear that.  I'll work on the commented stuff.  As 
powersave/hp-poll stuff seems to have more issues to resolve, I think 
merging PMP first is better.  As things have pretty much settled for 
PMP, I won't separate easy patches out.

-- 
tejun

