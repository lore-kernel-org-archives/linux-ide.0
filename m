From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 4/4] ide-tape: remove pipeline-specific code from
	idetape_add_chrdev_read_request()
Date: Thu, 13 Mar 2008 07:19:37 +0100
Message-ID: <20080313061937.GG4266@gollum.tnic>
References: <1205082632-3418-1-git-send-email-petkovbb@gmail.com> <200803110025.51072.bzolnier@gmail.com> <20080312055803.GD4266@gollum.tnic> <200803121451.23925.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.233]:37676 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbYCMGTw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 02:19:52 -0400
Received: by hu-out-0506.google.com with SMTP id 19so2312147hue.21
        for <linux-ide@vger.kernel.org>; Wed, 12 Mar 2008 23:19:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200803121451.23925.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Mar 12, 2008 at 02:51:23PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
>=20
> Hi,
>=20
> On Wednesday 12 March 2008, Borislav Petkov wrote:
>=20
> [...]
>=20
> > > > the read request's buffer directly thru idetape_queue_rw_tail()
> > > >=20
> > > > 3. Do next request buffer allocation (tape->merge_stage)
> > >=20
> > > Isn't idetape_init_read() taking care of 3.?
> >=20
> > i wanted to have the whole handling at one place and let _init_read=
() only
> > prepare the read. Now we don't allocate any new tape->merge_stage a=
nymore,
> > which is wrong. Originally, this happened in _init_read(), however,=
 if we do
> > idetape_queue_rw_tail(), we should alloc the new stage _after_ queu=
eing the
>=20
> The original driver doesn't do this - it just calls idetape_queue_rw_=
tail(),
> could it be a bug in the original driver?

Damn, i see it now, idetape_queue_rw_tail() queues the request and then=
 simply
_reuses_ the tape->merge_stage buffer by doing

        if (tape->merge_stage)
		idetape_init_merge_stage(tape);

so no need for reallocation. Whew! :)

--=20
Regards/Gru=DF,
    Boris.
