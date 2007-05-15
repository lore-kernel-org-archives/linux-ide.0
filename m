From: "Francesco Pretto" <ceztko@gmail.com>
Subject: Re: [PATCH] libata: track spindown status and skip spindown_compat if possible
Date: Tue, 15 May 2007 18:44:27 +0200
Message-ID: <e5ab0f710705150944x1202d21ehee566f458fa07c39@mail.gmail.com>
References: <46498B82.1030802@gmail.com>
	 <loom.20070515T133840-438@post.gmane.org> <4649A180.1050100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:35395 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757398AbXEOQo2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 12:44:28 -0400
Received: by nz-out-0506.google.com with SMTP id r28so215549nza
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 09:44:28 -0700 (PDT)
In-Reply-To: <4649A180.1050100@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

2007/5/15, Tejun Heo <htejun@gmail.com>:
> Yeah, it's a big mess.  With this patch applied, what happens is...
>
> * If your shutdown(8) does issue STANDBYNOW : you get the big fat
> warning and kernel won't issue STANDBYNOW.
>
> * If your shutdown(8) doesn't issue STANDBYNOW : kernel issues FLUSH
> CACHE followed by STANDBYNOW and all is well and dandy without any
> userland modification.
>
> I think it isn't too bad.  Any better ideas?
>

Seems good for a transitional period. However, as it appeared evident
(and with a bit of luck), probably no distributions are trying to
issuing STANDBYNOW after all.
Eventually, IMO, even this tracking for spindown status could be
removed as only one shutdown(8) behavior should be supported: that of
doing nothing and leaving all responsibility of spindown only to
kernel.

As upstart author pointed in the concerning bug report:
> We have an inherent preference for the cleanest and simplest
> implementation, obviously :-)  If that means no userspace code, and
> just call reboot(), WIN!
