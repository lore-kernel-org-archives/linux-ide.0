From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-core: Allow longer timeout for drive spinup from
 PUIS
Date: Thu, 7 Apr 2016 13:46:36 -0400
Message-ID: <20160407174636.GG7822@mtj.duckdns.org>
References: <539D1F09-E6EB-47F1-A66E-C182CA675359@hgst.com>
 <20160330183846.GK7822@mtj.duckdns.org>
 <D088F533-0243-4414-9B03-BC177DC1D35C@hgst.com>
 <20160404161809.GY7822@mtj.duckdns.org>
 <EA6FA468-118B-43C2-B6CE-2658650AE544@hgst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:36820 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbcDGRqj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Apr 2016 13:46:39 -0400
Received: by mail-yw0-f181.google.com with SMTP id o66so14723098ywc.3
        for <linux-ide@vger.kernel.org>; Thu, 07 Apr 2016 10:46:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <EA6FA468-118B-43C2-B6CE-2658650AE544@hgst.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <Damien.LeMoal@hgst.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Thu, Apr 07, 2016 at 01:22:19AM +0000, Damien Le Moal wrote:
> >Applied to libata/for-4.7.  Can you please use git format-patch to
> >generate the patch file from next time?
>=20
> Thanks !
> For the patch, I used =E2=80=9Cgit show xxx > file=E2=80=9D...
> Is this not correct ? Should I be using a =E2=80=9C=E2=80=94pretty=3D=
xxx=E2=80=9D formatting ?

I always use git format-patch.  For a single patch, you can simply do
"git format-patch HEAD^".

Thanks.

--=20
tejun
