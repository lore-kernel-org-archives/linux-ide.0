From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH 2/3] IDE: Replace __FUNCTION__ with __func__
Date: Mon, 25 Feb 2008 10:14:36 +0330
Message-ID: <4d8e3fd30802242244s54e478acw1e582f7edf870b88@mail.gmail.com>
References: <20080224221113.5ddfe371@paolo-desktop>
	 <1203897888.19319.143.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:2136 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbYBYGoh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Feb 2008 01:44:37 -0500
Received: by wf-out-1314.google.com with SMTP id 28so787790wff.4
        for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2008 22:44:37 -0800 (PST)
In-Reply-To: <1203897888.19319.143.camel@localhost>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On 2/25/08, Joe Perches <joe@perches.com> wrote:
> On Sun, 2008-02-24 at 22:11 +0100, Paolo Ciarrocchi wrote:
> > -	"driver.\n", __FUNCTION__, drive->name);
> > +	"driver.\n", __func__, drive->name);
>
> Is there consensus on this style conversion?

I did that in a separate patch because i'm not sure about that.

> Right now, there's 629 uses of __FUNCTION__ and 439 uses of __func__.

Checkpatch.pl indicate the conversion as a janitorial task.

Ciao,
--
Paolo
http://paolo.ciarrocchi.googlepages.com/
