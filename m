From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Crash in ide_do_request() on card removal
Date: Tue, 2 Aug 2005 15:28:50 +0200
Message-ID: <58cb370e05080206282af4cf0a@mail.gmail.com>
References: <42EA1AB0.6070001@imc-berlin.de> <42EF5488.9020802@imc-berlin.de>
	 <20050802111302.GH22569@suse.de> <42EF5651.1040905@imc-berlin.de>
	 <20050802112804.GJ22569@suse.de> <42EF594C.7090902@imc-berlin.de>
	 <20050802113328.GK22569@suse.de> <42EF626B.6090103@imc-berlin.de>
	 <20050802122609.GM22569@suse.de> <42EF69AD.30201@imc-berlin.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.206]:40099 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261520AbVHBN2y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2005 09:28:54 -0400
Received: by nproxy.gmail.com with SMTP id l37so322750nfc
        for <linux-ide@vger.kernel.org>; Tue, 02 Aug 2005 06:28:51 -0700 (PDT)
In-Reply-To: <42EF69AD.30201@imc-berlin.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org

On 8/2/05, Steven Scholz <steven.scholz@imc-berlin.de> wrote:
> Jens Axboe wrote:

> do_ide_request() could check hwif->present and/or drive->present.
> BUT: at this point the request is already made and the low level block layer is
> sleeping and waiting for it's completion.
> I could not figure out how to kill a request in do_ide_request() and wake up the
> block layer (sleeping in __wait_on_buffer()).
> That's why I thought preventing the generation of such reuqests would be the
> right way.
> 
> > I suggest you take it up with Bart how best to solve this. He might even
> > already have patches.
> Bart? Are you there?

IDE device unplug TODO :)
* add ide_device_get() helper which will check for drive->present
  + increase reference count on drive->gendev and ide_device_put()
  helper which will decrease reference count on drive->gendev
* propagate usage of these helpers to device drivers (ide_disk_get() etc.)
  so there won't be _new_ requests after removal of the device
* if !drive->present fail _old_ requests (as already mentioned by Jens)
* add proper locking around drive->present
* ...

first three points should be relatively easy

Bartlomiej
