From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide-cd question
Date: Thu, 3 Feb 2005 22:03:39 +0100
Message-ID: <58cb370e050203130352dbbc8b@mail.gmail.com>
References: <7A8F92187EF7A249BF847F1BF4903C04010EE861@ausx2kmpc103.aus.amer.dell.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.197]:19842 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261182AbVBCVDo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 16:03:44 -0500
Received: by wproxy.gmail.com with SMTP id 67so354134wri
        for <linux-ide@vger.kernel.org>; Thu, 03 Feb 2005 13:03:39 -0800 (PST)
In-Reply-To: <7A8F92187EF7A249BF847F1BF4903C04010EE861@ausx2kmpc103.aus.amer.dell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Stuart_Hayes@dell.com" <Stuart_Hayes@dell.com>
Cc: linux-ide@vger.kernel.org

On Thu, 3 Feb 2005 14:34:42 -0600, Stuart_Hayes@dell.com
<Stuart_Hayes@dell.com> wrote:
> 
> Why does ide-cd use "DRIVER(drive)->end_request()" instead of
> "cdrom_end_request()" in the function ide_cdrom_error when it wants to
> end a request that's exceeded ERROR_MAX errors?  (See code below.)

Please always give the kernel version you are referring to.
ide_cdrom_error() is gone in 2.6.11-rc2.

If there is a bug, it is in ide_cdrom_driver declaration.
.end_request is not set to ide_cdrom_error.

> With certain requests (GET_CONFIGURATION (0x46), in particular),
> DRIVER(drive)->end_request() is not actually ending the request, because
> rq->bio is not NULL--but it also is not clearing rq->errors, so this
> request ends up getting retried forever, but no more resets are
> attempted because rq->errors has exceeded ERROR_MAX.

I don't get this, maybe I'm looking at the wrong kernel version?

Bartlomiej
