From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH v2 00/13] removing the on-stack struct request
Date: Fri, 2 May 2008 16:04:54 +0200
Message-ID: <20080502140454.GC22899@gollum.tnic>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.236]:38437 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935093AbYEBONl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2008 10:13:41 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1110217hue.21
        for <linux-ide@vger.kernel.org>; Fri, 02 May 2008 07:13:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org, jens.axboe@oracle.com, bzolnier@gmail.com

Hi,

On Thu, May 01, 2008 at 09:27:57PM +0900, FUJITA Tomonori wrote:
> This is an updated version of the patchset to clean up the asymmetry
> of blk_get/put_request usage:
>=20
> http://marc.info/?l=3Dlinux-ide&m=3D120882410712466&w=3D2
>=20
> This patchset removes the code calling blk_put_request against the
> requests that are not allocated via blk_get_request. They can use
> __GFP_WAIT allocation so we can easily convert them to
> use blk_get/put_request properly.
>=20
> This patchset enables us to remove the following hack in
> blk_put_request:
>=20
> /*
>  * Gee, IDE calls in w/ NULL q.  Fix IDE and remove the
>  * following if (q) test.
>  */
> if (q) {
> 	spin_lock_irqsave(q->queue_lock, flags);
> 	__blk_put_request(q, req);
> 	spin_unlock_irqrestore(q->queue_lock, flags);
> }
>=20
> The major changes are:
>=20
> - I remove the ide_wait/head_wait path in ide_do_drive_cmd(). It does
> the same thing that blk_execute_rq() does.

Are you sure about that? Not that I'm that familiar with the blk layer =
internals
but at a glance blk_execute_rq() calls blk_execute_rq_nowait() and in i=
t, the
rq is added to the elevator and the device queue is being plugged (4th =
arg
to __elv_add_request(...,1)) and after the last returns the device is b=
eing
unplugged again: __generic_unplug_device(q). This way no rq's are getti=
ng merged
and it might hurt performance, IMHO.

--=20
Regards/Gru=DF,
    Boris.
