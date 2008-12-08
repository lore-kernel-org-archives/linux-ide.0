From: "Borislav Petkov" <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/4] ide: remove ide-scsi remnants
Date: Mon, 8 Dec 2008 19:08:55 +0100
Message-ID: <9ea470500812081008ydcd3d44g9494bcb7140a7ca6@mail.gmail.com>
References: <1228670471-3435-1-git-send-email-petkovbb@gmail.com>
	 <20081207184316.GA30260@gollum.tnic>
	 <200812081833.00406.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:49570 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbYLHSI4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Dec 2008 13:08:56 -0500
Received: by an-out-0708.google.com with SMTP id d40so515390and.1
        for <linux-ide@vger.kernel.org>; Mon, 08 Dec 2008 10:08:55 -0800 (PST)
In-Reply-To: <200812081833.00406.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Dec 8, 2008 at 6:33 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Sunday 07 December 2008, Borislav Petkov wrote:
>> On Sun, Dec 07, 2008 at 06:21:07PM +0100, Borislav Petkov wrote:
>> > Hi Bart,
>> >
>> > here are the patches removing bits and pieces belonging to the late ide-scsi :).
>> >
>>
>> here's the correct (and not reversed :)) diffstat though:
>>
>>  drivers/ide/ide-atapi.c  |   97 +++++++++-------------------------------------
>>  drivers/ide/ide-io.c     |    3 -
>>  drivers/ide/ide-ioctls.c |    3 +-
>>  drivers/ide/ide-probe.c  |    2 -
>>  include/linux/ide.h      |   34 ++++++----------
>>  5 files changed, 33 insertions(+), 106 deletions(-)
>
> Thanks, applied (though you could have combined all patches into
> single one -- it is one logical change after all).

It was a single patch originally but it looked pretty big and
unreadable and that's why I split it.


-- 
Regards/Gruss,
Boris
