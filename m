From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Mon, 29 Mar 2004 13:19:02 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40686896.3000402@pobox.com>
References: <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org> <20040328181502.GO24370@suse.de> <40671FAF.6080501@pobox.com> <20040329080943.GR24370@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16773 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263039AbUC2STR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Mar 2004 13:19:17 -0500
In-Reply-To: <20040329080943.GR24370@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

I don't care how the implementation looks.  The most basic points are 
that driver writers should not have to care about the value of this 
1M-max-request-size magic number, nor is it in any way specific to SATA.

	Jeff




