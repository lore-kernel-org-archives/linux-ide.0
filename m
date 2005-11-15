From: Rahul Siddharthan <rsidd@online.fr>
Subject: Re: Buggy IDE / ATA drive on 2.6? DMA timeouts, 2.4 is fine
Date: Tue, 15 Nov 2005 15:27:58 +0100
Message-ID: <1132064878.4379f06eb17e4@imp4-g19.free.fr>
References: <1132054925.4379c98d390e4@imp4-g19.free.fr> <58cb370e0511150458t1748b396sd70c7a27d93111a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6-g19.free.fr ([212.27.42.36]:5021 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751425AbVKOO2B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Nov 2005 09:28:01 -0500
In-Reply-To: <58cb370e0511150458t1748b396sd70c7a27d93111a5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

> > The other reports I see on the net also seem to refer to 2.6.10 and above,
> > so perhaps something happened in 2.6.10.
>
> Care to give some pointers?

Eg,
http://lists.debian.org/debian-kernel/2005/08/msg00104.html
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=132584
(I don't get the "losing ticks" message in the latter report but
otherwise the error is just the same)


> It seems that your drive is failing (reallocated sectors) and you've noticed
> it with linux-2.6 because it stresses the hardware the most...

Ok... I'll take regular backups

Thanks
Rahul

