From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646
Date: Wed, 29 Oct 2008 22:42:38 +0100
Message-ID: <200810292242.39729.bzolnier@gmail.com>
References: <200810272058.54522.bzolnier@gmail.com> <200810292026.00739.bzolnier@gmail.com> <4908C8F2.9040004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.183]:64355 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229AbYJ2VrR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 17:47:17 -0400
Received: by ik-out-1112.google.com with SMTP id c29so221061ika.5
        for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 14:47:15 -0700 (PDT)
In-Reply-To: <4908C8F2.9040004@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 29 October 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>Hello.
> 
> >>Bartlomiej Zolnierkiewicz wrote:
> 
> >>>* Set IDE_HFLAG_SERIALIZE explictly for CMD646.
> 
> >>  Was that some kernel.org bug that this is fixing?
> 
> > Nope (AFAIK).
> 
>     User report then?

Nope as far as my inbox tells me.

However http://bugzilla.kernel.org/ may know more.
