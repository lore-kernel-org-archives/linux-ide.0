From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: How to test SATA NCQ feature
Date: Fri, 13 Oct 2006 09:38:44 -0600
Message-ID: <8202f4270610130838n74b5bc8akae9ddcc1564eeb6@mail.gmail.com>
References: <8202f4270610120930u2da27058u77c4384f1bd4cda2@mail.gmail.com>
	 <311601c90610121012j165ecbgf1944da30bced51d@mail.gmail.com>
	 <8202f4270610121655x1f88c363j34b20928d34af86f@mail.gmail.com>
	 <20061013082829.GH6515@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:16946 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751227AbWJMPjT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Oct 2006 11:39:19 -0400
Received: by py-out-1112.google.com with SMTP id n25so1154816pyg
        for <linux-ide@vger.kernel.org>; Fri, 13 Oct 2006 08:38:45 -0700 (PDT)
In-Reply-To: <20061013082829.GH6515@kernel.dk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Thanks, Jens. This answered my question.

Fajun

On 10/13/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Thu, Oct 12 2006, Fajun Chen wrote:
> > will be aborted by LOG PAGE 10h command, but how about the commands
> > enqueued but haven't been sent to the device?  In my particular
>
> Requests not yet issued to the device, all reside in the io scheduler
> queue. When the drive invalidates its hardware queue, those previously
> active commands are put back in to the io scheduler queue and now reside
> with those that were yet to be issued. Once device recovery is complete,
> queueing at the device level resumes.
>
> Does that answer your question? Neither libata nor the device has any
> knowledge of commands queue but not sent to the device.
>
> --
> Jens Axboe
>
>
