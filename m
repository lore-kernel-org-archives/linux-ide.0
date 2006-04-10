From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: question : transfer size
Date: Mon, 10 Apr 2006 21:45:09 +0200
Message-ID: <5d96567b0604101245o55404b1buebcf86e0e07e5ed4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:63147 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932129AbWDJTpK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Apr 2006 15:45:10 -0400
Received: by pproxy.gmail.com with SMTP id i49so1183435pye
        for <linux-ide@vger.kernel.org>; Mon, 10 Apr 2006 12:45:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>

Jeff hello.
i have been measuring the transer size of  a request_t in
the deadline io scheduler dispatch request method.
i issued a dd of 1MB over a maxtor disk, which according
to the max_hw_sectors has 2048 sectors.
but in the scheduler i see only 1024 sectors.
So my question is:
where and how the transfer size is being determined ?
if i am going to expand the biovec size from 256 to 512
will it matter ?

thank you
--
Raz
