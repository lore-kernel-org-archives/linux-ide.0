From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: Crash in ide_do_request() on card removal
Date: Tue, 31 Jan 2006 15:28:35 +0100
Message-ID: <43DF7413.3080505@imc-berlin.de>
References: <42EA1AB0.6070001@imc-berlin.de> <42EF5488.9020802@imc-berlin.de>	 <20050802111302.GH22569@suse.de> <42EF5651.1040905@imc-berlin.de>	 <20050802112804.GJ22569@suse.de> <42EF594C.7090902@imc-berlin.de>	 <20050802113328.GK22569@suse.de> <42EF626B.6090103@imc-berlin.de>	 <20050802122609.GM22569@suse.de> <42EF69AD.30201@imc-berlin.de> <58cb370e05080206282af4cf0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:64781 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S1750785AbWAaO2j
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Jan 2006 09:28:39 -0500
In-Reply-To: <58cb370e05080206282af4cf0a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org

Hi all,

>>> I suggest you take it up with Bart how best to solve this. He might even
>>> already have patches.
>> Bart? Are you there?
> 
> IDE device unplug TODO :)
> * add ide_device_get() helper which will check for drive->present
>   + increase reference count on drive->gendev and ide_device_put()
>   helper which will decrease reference count on drive->gendev
> * propagate usage of these helpers to device drivers (ide_disk_get() etc.)
>   so there won't be _new_ requests after removal of the device
> * if !drive->present fail _old_ requests (as already mentioned by Jens)
> * add proper locking around drive->present
> * ...

Was this "IDE device unplug" stuff added to the mainline kernel by now?
If so, would it be possible to backport it to linux-2.6.14?

Thanks.

--
Steven
