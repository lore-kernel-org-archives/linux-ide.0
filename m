From: Tejun Heo <tj@kernel.org>
Subject: Re: [Patch] enable AHCI mode on certain ich chipsets
Date: Fri, 18 Feb 2011 15:42:43 +0100
Message-ID: <20110218144243.GL21209@htj.dyndns.org>
References: <20110216090548.GQ5778@Redstar.dorchain.net>
 <20110217100330.GO19830@htj.dyndns.org>
 <87aahtsamv.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33879 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab1BROmt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2011 09:42:49 -0500
Received: by bwz15 with SMTP id 15so778886bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2011 06:42:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87aahtsamv.fsf@nemi.mork.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: linux-ide@vger.kernel.org

(please always reply-to-all)

On Fri, Feb 18, 2011 at 03:03:20PM +0100, Bj=F8rn Mork wrote:
> Tejun Heo <tj@kernel.org> writes:
>=20
> > I'm not particularly inclined toward including this patch in upstre=
am
> > as long as it can't be enabled by default.  It's just gonna be an
> > extra piece of code to carry around which only a handful of people =
use
> > and nobody really knows on which hardware it works or not and to wh=
at
> > extent.
>=20
> Then enable it by default :-)

That's the point tho.  We can't enable it by default.  It's too
dangerous.  If there's a way we can safely, I'd be happy to do it.

--=20
tejun
