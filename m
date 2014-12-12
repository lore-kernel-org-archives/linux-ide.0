From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Fri, 12 Dec 2014 16:35:41 +0800
Message-ID: <CACVXFVNYBVb-AiKKNXnc17uo+oa7At6o6kQUCoK_Ng8h5q=pcw@mail.gmail.com>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
	<20141204170611.GB2995@htj.dyndns.org>
	<yq14mtahmil.fsf@sermon.lab.mkp.net>
	<20141205145148.GI4080@htj.dyndns.org>
	<1418184578.2121.3.camel@HansenPartnership.com>
	<20141210142927.GA6294@htj.dyndns.org>
	<yq1oarbcj6f.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:45042 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbaLLIfm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Dec 2014 03:35:42 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp4so7169303obc.6
        for <linux-ide@vger.kernel.org>; Fri, 12 Dec 2014 00:35:41 -0800 (PST)
In-Reply-To: <yq1oarbcj6f.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Thu, Dec 11, 2014 at 5:02 AM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Tejun" == Tejun Heo <tj@kernel.org> writes:
>
> Tejun> If raid consistency truly is the only reason for this, that
> Tejun> approach seems way more fruitful to me than playing this optional
> Tejun> feature game with hardware vendors which so often leads to
> Tejun> eventual abysmal outcomes.
>
> The other use case is the filesystem one where it is common to zero
> block ranges for bitmaps, etc. In many workloads there's is a
> significant win to trimming over writing out many blocks of zeroes.

Yes, looks mkfs is using the feature.

Thanks,
Ming Lei
