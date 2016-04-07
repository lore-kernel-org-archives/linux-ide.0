From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] libata-core: Allow longer timeout for drive spinup from
 PUIS
Date: Thu, 07 Apr 2016 07:00:23 -0400
Message-ID: <1460026823.20949.2.camel@HansenPartnership.com>
References: <539D1F09-E6EB-47F1-A66E-C182CA675359@hgst.com>
	 <20160330183846.GK7822@mtj.duckdns.org>
	 <D088F533-0243-4414-9B03-BC177DC1D35C@hgst.com>
	 <20160404161809.GY7822@mtj.duckdns.org>
	 <EA6FA468-118B-43C2-B6CE-2658650AE544@hgst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53684 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755384AbcDGLAb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Apr 2016 07:00:31 -0400
In-Reply-To: <EA6FA468-118B-43C2-B6CE-2658650AE544@hgst.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <Damien.LeMoal@hgst.com>, Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Thu, 2016-04-07 at 01:22 +0000, Damien Le Moal wrote:
> Tejun,
>=20
> > Applied to libata/for-4.7.  Can you please use git format-patch to
> > generate the patch file from next time?
>=20
> Thanks !
> For the patch, I used =E2=80=9Cgit show xxx > file=E2=80=9D...
> Is this not correct ? Should I be using a =E2=80=9C=E2=80=94pretty=3D=
xxx=E2=80=9D formatting ?

If you want to use git show, then you need --pretty=3Demail (depending =
on
whether you want to add the commit statistics, you can also add --stat=20
--patch).

If you have a patch series, it's often better to use

git-format-patch -n --cover-letter

Which generates a set of numbered files for the entire patch series.

James


