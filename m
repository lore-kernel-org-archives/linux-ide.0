From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC: 2.6 patch] remove BLK_DEV_HD_ONLY
Date: Tue, 27 May 2008 21:14:12 +0200
Message-ID: <200805272114.12763.bzolnier@gmail.com>
References: <20080519215357.GH17716@cs181133002.pp.htv.fi> <20080519225018.1df63bef@core>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:33106 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429AbYEZTX0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 May 2008 15:23:26 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1646628mue.1
        for <linux-ide@vger.kernel.org>; Mon, 26 May 2008 12:23:25 -0700 (PDT)
In-Reply-To: <20080519225018.1df63bef@core>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@kernel.org>, linux-ide@vger.kernel.org

On Monday 19 May 2008, Alan Cox wrote:
> On Tue, 20 May 2008 00:53:57 +0300
> Adrian Bunk <bunk@kernel.org> wrote:
> 
> > This was the oldest and most limited of the three IDE drivers we ship.
> 
> NAK - it isn't just an IDE driver it's an MFM/RLL driver as well. It's
> one of the few things suitable for rescuing ancient drives so should be
> retained.

I tend to disagree:

- there is nothing wrong with using an older kernel for rescue operations
  on MFM/RLL drives

- it should be relatively easy to add MFM/RLL support to IDE subsystem
  or libata layer (or even both)

If there is no consensus about hd.c removal I think that the appropriate
alternative would be to move it to drivers/block/ as it has nothing to do
with IDE subsystem code.

Thanks,
Bart
