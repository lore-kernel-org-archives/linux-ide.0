From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] swsusp: allow drivers to determine between write-resume
 and actual wakeup
Date: Mon, 05 Jun 2006 20:50:56 +0900
Message-ID: <44841AA0.4060404@gmail.com>
References: <20060605091131.GE8106@htj.dyndns.org> <20060605092342.GI5540@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:9923 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751011AbWFELvH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jun 2006 07:51:07 -0400
Received: by wr-out-0506.google.com with SMTP id i22so945573wra
        for <linux-ide@vger.kernel.org>; Mon, 05 Jun 2006 04:51:06 -0700 (PDT)
In-Reply-To: <20060605092342.GI5540@elf.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Pavel Machek wrote:
> If you want to know if you RESUME was after normal FREEZE or if it is
> after reboot, there's better patch floating around to do that.

Yeap, this is what I'm interested in.  Care to give me a pointer?

Thanks.

-- 
tejun
