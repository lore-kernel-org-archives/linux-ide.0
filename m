From: Tejun Heo <htejun@gmail.com>
Subject: Re: dvd-r detection problem with port multiplier
Date: Tue, 17 Oct 2006 13:49:49 +0900
Message-ID: <453460ED.4070903@gmail.com>
References: <KMS--2023338046-2588@mail.norwalkdist.com> <451A272B.60500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.224]:31900 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423051AbWJQEt6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Oct 2006 00:49:58 -0400
Received: by hu-out-0506.google.com with SMTP id 28so1095356hub
        for <linux-ide@vger.kernel.org>; Mon, 16 Oct 2006 21:49:56 -0700 (PDT)
In-Reply-To: <451A272B.60500@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Trent George <trent@norwalkdist.com>
Cc: linux-ide@vger.kernel.org

Hello,

New round of PMP patches are out now.

http://article.gmane.org/gmane.linux.ide/13503  (the subject line is wrong)

I first included your fix but noticed that it slowed down the whole 
device detection regardless of attached device.  I'm also waiting for 
SIMG to respond on the issue.

Can you cook something up which doesn't slow down detection for all devices?

Thanks.

-- 
tejun
