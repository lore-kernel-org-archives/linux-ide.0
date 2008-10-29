From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646
Date: Wed, 29 Oct 2008 20:26:00 +0100
Message-ID: <200810292026.00739.bzolnier@gmail.com>
References: <200810272058.54522.bzolnier@gmail.com> <49064D53.8050106@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:51068 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbYJ2T3K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 15:29:10 -0400
Received: by gv-out-0910.google.com with SMTP id e6so99787gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 12:29:09 -0700 (PDT)
In-Reply-To: <49064D53.8050106@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 28 October 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Set IDE_HFLAG_SERIALIZE explictly for CMD646.
> >   
> 
>   Was that some kernel.org bug that this is fixing?

Nope (AFAIK).
