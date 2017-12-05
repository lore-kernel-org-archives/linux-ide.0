From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] pata_pdc2027x: Fix coding sytle error
Date: Tue, 05 Dec 2017 15:12:08 +0100
Message-ID: <1539928.BgA1Lm19hU@amdc3058>
References: <CGME20171125103419epcas5p1e02e8409d9cb34cd3c592ca4e14961eb@epcas5p1.samsung.com>
        <68e25992911d7c4d6c17b9f31524a614466d9588.1511605703.git.arvind.yadav.cs@gmail.com>
        <1823468.mnqCj3ft5Z@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49497 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbdLEOL5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Dec 2017 09:11:57 -0500
In-reply-to: <1823468.mnqCj3ft5Z@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tj@kernel.org, sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday, December 05, 2017 03:02:13 PM Bartlomiej Zolnierkiewicz wrote:
> On Saturday, November 25, 2017 04:04:07 PM Arvind Yadav wrote:
> > Fix these checkpatch.pl error:
> > ERROR: space prohibited before open square bracket '['.
> > 
> > ERROR: space prohibited after that '~' (ctx:WxW)
> > +		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));
> > 
> > ERROR: spaces required around that '?' (ctx:VxW)
> > +	long pout_required = board_idx? PDC_133_MHZ:PDC_100_MHZ;
> > 
> > ERROR: that open brace { should be on the previous line
> > +	const struct ata_port_info *ppi[] =
> > +		{ &pdc2027x_port_info[board_idx], NULL };
> > 
> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

PS two small things than still can be fixed:

* s/sytle error/style errors/ in the patch summary

* s/error/errors/ in the patch description

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

