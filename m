From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 06/10] ide-tape: unify r/w init paths
Date: Mon, 20 Apr 2009 17:20:26 +0400
Message-ID: <49EC769A.2080004@ru.mvista.com>
References: <1240099122-18381-1-git-send-email-tj@kernel.org> <1240099122-18381-7-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:57679 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755246AbZDTNTb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Apr 2009 09:19:31 -0400
In-Reply-To: <1240099122-18381-7-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hello.

Tejun Heo wrote:

> Impact: cleanup

> Read and write init paths are almost identical.  Unify them into
> idetape_init_rw().

> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
