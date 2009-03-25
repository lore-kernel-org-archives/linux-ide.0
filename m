From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 04/10] ide-tape: use standard data transfer mechanism
Date: Wed, 25 Mar 2009 16:20:50 +0100
Message-ID: <9ea470500903250820x2dfbf1f0q6e7d16191923cb3c@mail.gmail.com>
References: <1237990673-8358-1-git-send-email-tj@kernel.org>
	 <1237990673-8358-5-git-send-email-tj@kernel.org>
	 <9ea470500903250812r19970910h12d197716d262c82@mail.gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f160.google.com ([209.85.217.160]:33787 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762658AbZCYP11 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Mar 2009 11:27:27 -0400
Received: by gxk4 with SMTP id 4so207417gxk.13
        for <linux-ide@vger.kernel.org>; Wed, 25 Mar 2009 08:27:24 -0700 (PDT)
In-Reply-To: <9ea470500903250812r19970910h12d197716d262c82@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org

>> =A0 =A0 =A0 =A0drive->pc_callback =A0 =A0 =A0 =3D ide_tape_callback;
>> - =A0 =A0 =A0 drive->pc_update_buffers =3D idetape_update_buffers;
>> - =A0 =A0 =A0 drive->pc_io_buffers =A0 =A0 =3D ide_tape_io_buffers;
>
> You might just as well remove those two ide_drive_t members since
> they're used only by ide-tape.

Ah, nevermind. You've done it later in patch 9/10.

--=20
Regards/Gruss,
Boris
