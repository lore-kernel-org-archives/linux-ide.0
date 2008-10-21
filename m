From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH #upstream-fixes] libata-eh: fix slave link EH action mask
 handling
Date: Tue, 21 Oct 2008 14:47:00 +0400
Message-ID: <48FDB324.1050701@ru.mvista.com>
References: <48FD5EE0.9040407@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:59662 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752611AbYJUKrH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2008 06:47:07 -0400
In-Reply-To: <48FD5EE0.9040407@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Hello.

Tejun Heo wrote:

> Slave link action mask is transferred to masater link and all the EH
>   

   s/masater/master/

MBR, Sergei


