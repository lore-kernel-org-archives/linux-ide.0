From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: How to test SATA NCQ feature
Date: Fri, 13 Oct 2006 10:28:30 +0200
Message-ID: <20061013082829.GH6515@kernel.dk>
References: <8202f4270610120930u2da27058u77c4384f1bd4cda2@mail.gmail.com> <311601c90610121012j165ecbgf1944da30bced51d@mail.gmail.com> <8202f4270610121655x1f88c363j34b20928d34af86f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:62047 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750810AbWJMI2Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Oct 2006 04:28:16 -0400
Content-Disposition: inline
In-Reply-To: <8202f4270610121655x1f88c363j34b20928d34af86f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Thu, Oct 12 2006, Fajun Chen wrote:
> will be aborted by LOG PAGE 10h command, but how about the commands
> enqueued but haven't been sent to the device?  In my particular

Requests not yet issued to the device, all reside in the io scheduler
queue. When the drive invalidates its hardware queue, those previously
active commands are put back in to the io scheduler queue and now reside
with those that were yet to be issued. Once device recovery is complete,
queueing at the device level resumes.

Does that answer your question? Neither libata nor the device has any
knowledge of commands queue but not sent to the device.

-- 
Jens Axboe

