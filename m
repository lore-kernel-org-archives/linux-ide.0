From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/4] ide-tape: remove pipeline-specific code from idetape_add_chrdev_read_request()
Date: Wed, 12 Mar 2008 14:51:23 +0100
Message-ID: <200803121451.23925.bzolnier@gmail.com>
References: <1205082632-3418-1-git-send-email-petkovbb@gmail.com> <200803110025.51072.bzolnier@gmail.com> <20080312055803.GD4266@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:47915 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbYCLNhg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2008 09:37:36 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1152627nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 12 Mar 2008 06:37:35 -0700 (PDT)
In-Reply-To: <20080312055803.GD4266@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Wednesday 12 March 2008, Borislav Petkov wrote:

[...]

> > > the read request's buffer directly thru idetape_queue_rw_tail()
> > > 
> > > 3. Do next request buffer allocation (tape->merge_stage)
> > 
> > Isn't idetape_init_read() taking care of 3.?
> 
> i wanted to have the whole handling at one place and let _init_read() only
> prepare the read. Now we don't allocate any new tape->merge_stage anymore,
> which is wrong. Originally, this happened in _init_read(), however, if we do
> idetape_queue_rw_tail(), we should alloc the new stage _after_ queueing the

The original driver doesn't do this - it just calls idetape_queue_rw_tail(),
could it be a bug in the original driver?

[ ditto for idetape_queue_rw_tail() for writes ]

> request, which means it cannot happen _init_read() now and should take place
> afterwards, i.e. as it was in the original patch, or?
