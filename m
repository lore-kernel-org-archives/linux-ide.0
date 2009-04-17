From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 02/15] ide-tape: remove back-to-back REQUEST_SENSE
	detection
Date: Fri, 17 Apr 2009 13:03:31 +0200
Message-ID: <9ea470500904170403n621f84det8cfec405131d893c@mail.gmail.com>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
	 <1239960802-31978-3-git-send-email-tj@kernel.org>
	 <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com>
	 <49E85B6F.7080603@kernel.org> <49E85CA7.2060801@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f176.google.com ([209.85.218.176]:57038 "EHLO
	mail-bw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbZDQLDe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Apr 2009 07:03:34 -0400
Received: by bwz24 with SMTP id 24so486341bwz.13
        for <linux-ide@vger.kernel.org>; Fri, 17 Apr 2009 04:03:32 -0700 (PDT)
In-Reply-To: <49E85CA7.2060801@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hi

On Fri, Apr 17, 2009 at 12:40 PM, Tejun Heo <htejun@gmail.com> wrote:
> Tejun Heo wrote:
>> I don't really care one way or the other but the error condition
>> itself looked somewhat pointless to me, so I just killed it. =A0Is t=
he
>> error messasge really worth guaranteeing drive->pc can be accessed
>> after completion? =A0That's a nasty and fragile guarantee. =A0If suc=
h
>> check is really necessary, the proper way to do it would be recordin=
g
>> whether the last command was request sense in some persistent data
>> structure not trying to access a data structure which the code doesn=
't
>> own anymore.

Honestly, I don't know. The code predates even the initial git commit o=
f the
kernel so I guess nobody knows? And yeah, such a check looks a bit too =
much so I
won't have any problem with removing it. Nevertheless, we need the smal=
l fix
above in the ->do_request callback for all other packet commands since =
ide-tape
uses currently ide_queue_pc_tail() for sending those. I know, I know, i=
t is ugly
and we're working on it :).


> Yet another problem is that idetape_flush_tape_buffers() uses pc whic=
h
> is on stack which drive->pc ends up pointing directly to, so it won't
> work. =A0Nobody expects that the pointer it passed into an API should=
 be
> accessible by the API implementation after it was done with it.
> That's just a silly thing to do.

The whole on stack passing should be pass=E9 :) soon since we're about =
to kill
those ide_atapi_pc's. As I said before, this is very old code that is r=
eally
rusty and we're trying to janitor it slowly.

--=20
Regards/Gruss,
Boris
