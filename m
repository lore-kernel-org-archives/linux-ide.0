From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2.6.38-rc5 2/2] block: blk-flush shouldn't call
 directly into q->request_fn() __blk_run_queue()
Date: Fri, 18 Feb 2011 10:49:03 +0100
Message-ID: <20110218094903.GF21209@htj.dyndns.org>
References: <20110217111511.GQ19830@htj.dyndns.org>
 <20110217111619.GR19830@htj.dyndns.org>
 <AANLkTi=rPKN25yZTziv1dz=Ke0db8ZOwUgKFNzWn9+x7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33372 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab1BRJtN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2011 04:49:13 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=rPKN25yZTziv1dz=Ke0db8ZOwUgKFNzWn9+x7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Snitzer <snitzer@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Beulich <JBeulich@novell.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Feb 17, 2011 at 10:01:51AM -0500, Mike Snitzer wrote:
> Hi Tejun,
>=20
> On Thu, Feb 17, 2011 at 6:16 AM, Tejun Heo <tj@kernel.org> wrote:
>=20
> > Jens, this is applicable to v2.6.37 and 38. =A0The new implementati=
on
> > for 39 would need similar fix but I couldn't find where the tree is=
=2E
> > Which branch is it?
>=20
> for-2.6.39/core

Right, thanks.  Jens, after you apply the two fixes for 2.6.38, I can
create a merge branch for for-2.6.39/core which you can pull.  Would
that work for you?

Thanks.

--=20
tejun
