From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Add VIA VT6410 support
Date: Tue, 30 Aug 2005 17:12:22 +0200
Message-ID: <58cb370e05083008121f2eb783@mail.gmail.com>
References: <43146CC3.4010005@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.192]:23752 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932182AbVH3PM1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Aug 2005 11:12:27 -0400
Received: by nproxy.gmail.com with SMTP id x37so393895nfc
        for <linux-ide@vger.kernel.org>; Tue, 30 Aug 2005 08:12:22 -0700 (PDT)
In-Reply-To: <43146CC3.4010005@gentoo.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru

On 8/30/05, Daniel Drake <dsd@gentoo.org> wrote:
> Jeff/Bart,
> 
> Can of you please apply this to a git tree and get this included in 2.6.14.
> The patch is about 6 months old and has been included in Gentoo kernels for
> about 3 months, and we've recieved multiple success reports.
> 
> I sent a mail to Bart at the end of June asking about this, and Sergey Vlasov
> recently asked the same question on LKML. If the patch isn't acceptable then
> please at least say _something_ :)

Same thing as with VT6420 support:

I'm still concerned about VIA IDE chipset + VT6410 combo
(AFAIR I've also seen VT6410 on PCI add-on card but I can be wrong).

via82cxxx.c needs to be fixed to support multiple controllers first.

Thanks,
Bartlomiej
