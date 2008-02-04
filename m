From: Stephen Kitt <steve@sk2.org>
Subject: Re: (fwd) Bug#11922: I/O error on blank tapes
Date: Mon, 4 Feb 2008 22:49:30 +0100
Message-ID: <20080204224930.543a4c53@sk2.org>
References: <20080204142206.GB5532@stro.at>
	<20080204212835.GA29286@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1-g19.free.fr ([212.27.42.27]:35061 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755784AbYBDVtc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Feb 2008 16:49:32 -0500
In-Reply-To: <20080204212835.GA29286@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: maximilian attems <max@stro.at>, linux-ide@vger.kernel.org, bzolnier@gmail.com

Hi Boris,

On Mon, 4 Feb 2008 22:28:35 +0100, Borislav Petkov <petkovbb@googlemail.com>
wrote:
> we're currently in the process of aggressively cleaning up ide-tape.
> However, this brings (almost) no functional changes to the driver and we
> haven't looked at any bugs that might exist. Actually, I wanted to probe
> the community to see whether anyone is using ide-tape at all, and if not,
> to remove it completely.
> 
> Since i don't have the hardware, i'm gonna have to ask you (or Stephen) to
> wait until all changes have entered mainline and then to try to reproduce
> the bug again after having enabled debugging (IDETAPE_DEBUG_LOG) and send
> me the syslog output.

There's been a misunderstanding somewhere along the line: Debian bug #11922
(http://bugs.debian.org/11922), which I responded to, isn't related to
ide-tape - the original bug reporter and myself use(d) SCSI tape drives.

Regards,

Stephen
