From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: fallback to the other IDENTIFY on device error,
 take#2
Date: Sun, 13 May 2007 19:50:16 +0200
Message-ID: <46474FD8.2070100@gmail.com>
References: <20070501121703.GH5942@electro-mechanical.com> <46373AEE.6070908@rtr.ca> <20070501131818.GA18521@electro-mechanical.com> <46374354.7040307@gmail.com> <20070501172117.GA20328@electro-mechanical.com> <463F56F2.3010106@gmail.com> <4642627A.4030606@garzik.org> <46446311.3000208@gmail.com> <4644E9E5.3000402@garzik.org> <46470B48.7050101@gmail.com> <20070513161353.GB29024@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:18370 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbXEMRve (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 May 2007 13:51:34 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1578862nzf
        for <linux-ide@vger.kernel.org>; Sun, 13 May 2007 10:51:33 -0700 (PDT)
In-Reply-To: <20070513161353.GB29024@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, William Thompson <wt@electro-mechanical.com>, Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com

Dave Jones wrote:
> On Sun, May 13, 2007 at 02:57:44PM +0200, Tejun Heo wrote:
>  > Jeff Garzik wrote:
>  > > Tejun Heo wrote:
>  > >> +            if (class == ATA_DEV_ATA)
>  > >> +                class = ATA_DEV_ATAPI;
>  > >> +            else
>  > >> +                class = ATA_DEV_ATA;
>  > > 
>  > > 
>  > > the 'else' branch is obviously redundant
>  > 
>  > Why?  We can also fallback from ATAPI to ATA.
> 
> Then did you mean to write..
> 
> +            if (class == ATA_DEV_ATA)
> +                class = ATA_DEV_ATAPI;
> +            else if (class == ATA_DEV_ATAPI)
> +                class = ATA_DEV_ATA;
> 
> ?
> 
> Otherwise, as Jeff mentions, you're doing a redundant assignment
> in the else branch.

Hmmm... I'm feeling very dense today.  At that point, class is either
ATA_DEV_ATA or ATA_DEV_ATAPI.  The if-else clause tries to flip between
the two.

1. if class == ATA_DEV_ATA, the 'if' test succeeds and "class =
ATA_DEV_ATAPI" runs, so it flips correctly.

2. if class == ATA_DEV_ATAPI,  the 'if' test fails and "class =
ATA_DEV_ATA" runs, so it flips correctly.

What am I missing here?  Feel free to scream at me and hammer me into
senses.  :-)

-- 
tejun
