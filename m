From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: [PATCH] sata_sil: fix uninitialized variable use when
 sil_scr_read() fails
Date: Tue, 27 Oct 2009 10:37:49 +0900
Message-ID: <20091027103749.871199e8.yuasa@linux-mips.org>
References: <20091020153456.9104e044.yuasa@linux-mips.org>
	<4ADE9563.2030705@kernel.org>
	<21eaeb5a0910211717w5692ce4em74482c7e5d4f5b9c@mail.gmail.com>
	<4AE5BC6B.7060804@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:57752 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbZJ0Bhm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2009 21:37:42 -0400
Received: by ewy4 with SMTP id 4so4224439ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2009 18:37:46 -0700 (PDT)
In-Reply-To: <4AE5BC6B.7060804@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: yuasa@linux-mips.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Mon, 26 Oct 2009 16:12:43 +0100
Tejun Heo <tj@kernel.org> wrote:

> Yuasa Yoichi wrote:
> >> The first usage of that is
> >>
> >>  sil_scr_read(&ap->link, SCR_ERROR, &serror);
> >>
> >> which sets the value.  So, I don't think the patch is necessary.  If
> >> it triggers a compile warning, putting uninitialized_var() macro will
> >> be more appropriate.
> > 
> > If sil_scr_read() is error, 'serror' is not initialized.
> > After that, the wrong bits add to 'ap->link.eh_info.serror' when
> > 'serror & SERR_PHYRDT_CHG' is true.
> 
> On the controller, sil_scr_read(SCR_ERROR) can never fail.  If it ever
> fails, the whole thing will break anyway.

OK, I got it.

Thanks,

Yoichi
