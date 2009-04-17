From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/15] ide-tape: remove back-to-back REQUEST_SENSE 	detection
Date: Fri, 17 Apr 2009 19:40:39 +0900
Message-ID: <49E85CA7.2060801@gmail.com>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>	 <1239960802-31978-3-git-send-email-tj@kernel.org> <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com> <49E85B6F.7080603@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:54278 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760621AbZDQKkq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Apr 2009 06:40:46 -0400
Received: by ti-out-0910.google.com with SMTP id 11so551712tim.23
        for <linux-ide@vger.kernel.org>; Fri, 17 Apr 2009 03:40:45 -0700 (PDT)
In-Reply-To: <49E85B6F.7080603@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> I don't really care one way or the other but the error condition
> itself looked somewhat pointless to me, so I just killed it.  Is the
> error messasge really worth guaranteeing drive->pc can be accessed
> after completion?  That's a nasty and fragile guarantee.  If such
> check is really necessary, the proper way to do it would be recording
> whether the last command was request sense in some persistent data
> structure not trying to access a data structure which the code doesn't
> own anymore.

Yet another problem is that idetape_flush_tape_buffers() uses pc which
is on stack which drive->pc ends up pointing directly to, so it won't
work.  Nobody expects that the pointer it passed into an API should be
accessible by the API implementation after it was done with it.
That's just a silly thing to do.

Thanks.

-- 
tejun
