From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 07/10] ide-tape: use byte size instead of sectors on rw
 issue functions
Date: Mon, 20 Apr 2009 17:39:19 +0400
Message-ID: <49EC7B07.3050000@ru.mvista.com>
References: <1240099122-18381-1-git-send-email-tj@kernel.org> <1240099122-18381-8-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:58439 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754211AbZDTNiY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Apr 2009 09:38:24 -0400
In-Reply-To: <1240099122-18381-8-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Tejun Heo wrote:

> Impact: cleanup

> Byte size is what most issue functions deal with, make
> idetape_queue_rw_tail() and its wrappers take byte size instead of
> sector counts.  idetape_chrdev_read() and write() functions are
> converted to use tape->buffer_size instead of ctl from tape->cap.

> This cleans up code a little bit and will ease the next r/w
> reimplementation.

> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
