From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: hdio.txt update
Date: Fri, 18 Mar 2005 16:23:27 +0100
Message-ID: <58cb370e050318072312531876@mail.gmail.com>
References: <20050302235457.GA21352@htj.dyndns.org>
	 <20050303021638.GA24150@htj.dyndns.org>
	 <58cb370e05031008307a0163c1@mail.gmail.com>
	 <20050311062908.GA11552@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.202]:13078 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261633AbVCRPXa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2005 10:23:30 -0500
Received: by wproxy.gmail.com with SMTP id 69so122159wri
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2005 07:23:27 -0800 (PST)
In-Reply-To: <20050311062908.GA11552@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

On Fri, 11 Mar 2005 15:29:08 +0900, Tejun Heo <htejun@gmail.com> wrote:
>  Greetings Bartlomiej,
> 
>  I've updated the following
> 
>  * in_flags modification when out_flags != 0 && in_flags == 0
>  * more than one -> one or more than one
>  * tf_{in|out}_flags -> {in|out}_flags as tf_* are in-kernel names
> 
>  I'll update the taskfile patch series after receiving your comments
> about the patches.  Also, if you have a big picture for the IDE
> driver, do you care to spill?  What I have in mind now are
> 
>  1. Completion-based taskfile (no direct ending/error handling of
>     requests), so that we can use it for specials/rw_disk/eh/etc...
>  2. Make specials (set_geometry, set_multmode...) more regular.
>  3. Do error-handling/resetting in a exception handler thread.
>     Maybe this and #2 should happen together.

Yep, this is the way to go.

>  So, please let me know what you think.  Updated patch for hdio.txt
> follows.

thanks, applied
