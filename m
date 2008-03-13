From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [RFC] Disk shock protection (revisited)
Date: Thu, 13 Mar 2008 15:51:59 +0100
Message-ID: <8763vq8ynk.fsf@denkblock.local>
References: <87skzgd1zk.fsf@denkblock.local> <20080226123946.75dbe3d2@core>
	<87mypl8p49.fsf@denkblock.local> <20080228111349.6831925c@core>
	<87bq5qfm2v.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:40948 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204AbYCMOxZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Mar 2008 10:53:25 -0400
In-Reply-To: <87bq5qfm2v.fsf@denkblock.local> (Elias Oltmanns's message of
	"Fri, 07 Mar 2008 19:03:36 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Elias Oltmanns <eo@nebensachen.de> wrote:
[...]
> I'm going to send a first draft of a patch series in reply to this
> email. It is a stripped down version intended to get the general idea
> across.

Have you had got round to looking at these patches yet?

> The first of these four patches will eventually need to be modified to
> actually abort in flight commands and clear up the mess afterwards.
> However, first and foremost I'd like to draw your attention to the use
> of REQ_TYPE_LINUX_BLOCK requests as demonstrated in the other three
> patches. The question is whether the underlying concept is right.
> Although the question how to handle REQ_TYPE_LINUX_BLOCK requests in
> the scsi subsystem has been raised on the linux-scsi ml, it has never
> been answered really because this request type was deemed unsuitable
> for the application in question. See, for instance, the thread
> starting at [1]. My patch approach has been partly inspired by the
> patch discussed there. Before I raise this issue yet again, I'd like
> to know whether REQ_TYPE_LINUX_BLOCK is the right choice for my
> application in your opinion or whether another mechanism might be more
> suitable as James suggested a while ago (see [2]).
>
> Regards,
>
> Elias
>
> [1] http://permalink.gmane.org/gmane.linux.scsi/30049
> [2] http://permalink.gmane.org/gmane.linux.scsi/37951

Sorry, I got these two the wrong way round. [1] should be [2] and vice
versa.

Regards,

Elias
