Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BC4C4338F
	for <linux-ide@archiver.kernel.org>; Mon, 16 Aug 2021 17:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED26960F39
	for <linux-ide@archiver.kernel.org>; Mon, 16 Aug 2021 17:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhHPR1M (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 16 Aug 2021 13:27:12 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36635 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhHPR1L (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 16 Aug 2021 13:27:11 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKuGD-1mWVkA0DbZ-00LDLd; Mon, 16 Aug 2021 19:26:31 +0200
Date:   Mon, 16 Aug 2021 19:26:30 +0200
From:   Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] libata: Disable ATA_CMD_READ_LOG_DMA_EXT in problematic
 cases.
Message-ID: <YRqfxrWJsIeyjFed@reimardoeffinger.de>
References: <YRjN4oULwmNKI/yi@infradead.org>
 <20210815162725.15124-1-Reimar.Doeffinger@gmx.de>
 <DM6PR04MB708117F3FD8537CB6875E2C4E7FD9@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <DM6PR04MB708117F3FD8537CB6875E2C4E7FD9@DM6PR04MB7081.namprd04.prod.outlook.com>
X-Provags-ID: V03:K1:4yNXBJ9haiL7NHYiHMfxZmjgBVb9stNB9wNPMLpnAiLRJwZ5AWt
 8enEtgHI1+F9AEVwwmmoHFctYKYYpD63VN0kYwx0XfSXOcVWCvfw6KQoDydxw0RzpHI96ID
 f7XkHJRl1tglJcTHBevzldQucpa3wfFlNfVjkFJ9lo6U1T2RD1x6c+wVtiZwchcXJe0KFhc
 q33y2+GrXx3Gz4n3iv2uA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b3SXQxPEKL4=:69Y/Nl4DFbYBrY/6rfZf7b
 CRMfOHv7bEkKkZ+kL0SfKiIuOYaQr7kt0So0jVEdD9L9sqcQDD55w95b3RivMEpxriWyhpFiz
 W26KfKl8ryXCkxp66DcFTT1/qrzJ23/euYITojvmWJmOwDNFVHwnUTpVDXZCscMS8IiZjzvpq
 lPKIjpm/Cq0+iXUIqWGBhZfstq6BD8LbIJnQoEVWoXPb+DxOWMgfM2LlXzhMIb7rvZk6VZWq4
 4a3YBKvNEba6Pzt14lR4XVSQzh9LhTIBjVYHfNrOVMNYHw5UksHNam8c2tkPqv62653ZM3Afo
 nqRSFTMa2+rOSMWMCpeF8GV4jbBdKalf2vpFQOtjsm9ThU14H/zu6SthOM0MafXQybc/ygLGN
 d/EfxN2tqQ+ZcjsORQ0CSoo3v4MaR5e10U/4scWr3CTApoMzgls+qQk8Na7VjB2U6aXeKrPku
 PIXct60XBDTD00gL953JufR4/F6mIgBwNMezRJ3COzywyBh3Yeu7ljdyDBxwB8cnVg9SI9nA5
 86jmXL/EZ+caZEdz2NBxHVWQYXYDy1XN6+zhMyykVJnwxldmk+YZDIqSxAn707LIYjQVhBomP
 IOe9B6Wznf1/WEK8yofQ3PC5X64M19j6VhnLlU6h0DY1xQOS9bbnmhXk1Yb/F5xTVsO0it8dX
 IkDRQ65ntpK4oyZiZ68pSG6Isvg9AIcdcSCyVg07Kz59bl56hEwKTJJT1qsbB+3VUcribMk4v
 9G/4K1GmrCfW3JYWud8PUJ0Qo1ji5JHQDyIPjmPpb/jLf+0/0ORRu4tBBVI5ZJLBkAy7lbG1F
 FcYK2mXR5mG+8luaOD/n/c3BlFfecjQSe798LuXWNlQQoWeKtx7s4Igez8BJW8j6+jP2Rgkv4
 zMX2Xz2TPCaxtmBKcr0w==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Aug 16, 2021 at 12:10:28AM +0000, Damien Le Moal wrote:
> > +	/* Do not even attempt DMA with PATA-SATA adapters, they seem likely to
> > +	 * hang, see https://bugzilla.kernel.org/show_bug.cgi?id=195895
> > +	 */
> 
> This is not the standard kernel comment style. Multi-lines comment should start
> with a "/*" line:

Fixed, somehow I thought I had followed the surrounding style, I was
wrong.

> Also, I would remove the bugzilla reference since it is in the commit message.

Done, though long-term the commit message might be harder to find than
the comment...

> >  	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id) &&
> > +	    (ap_flags & ATA_FLAG_SATA) &&
> 
> Why is this necessary since you have the ATA_HORKAGE_NO_DMA_LOG flag ?

Not sure I understand the question right.
The patch is a best-guess + "in doubt disable" attempt at
auto-detecting.
As I mentioned the data is rather light, so I wanted to only add the
option at first.
Now it does 2 things in addition:
- disable it for Crucial MX500 because the issue was seen and confirmed
  with and without PATA converter with that device
- disable it for anything connected with a PATA converter because there
  are lots of bug reports with different devices that have a PATA
  converter in common. Unfortunately no confirmation from any of those.
  However in quick testing I could verify the MX500 issue only with
  PATA adapter myself, so it seems like an appropriate precaution,
  especially as now with the new code it is possible to override both
  ways.

(should I put something more in the commit message? I didn't want to
bloat it too much)

Aside: I don't have the ATA spec, so I can't check, but I do find it
a bit suspicious that the logs look like the code runs the
READ_LOG_DMA command before SETXFERMODE is done, and thus while the
device is still in PIO mode?

> If this is really necessary, ATA_HORKAGE_NO_DMA_LOG should be set for all
> devices that have ATA_FLAG_SATA when the device is initialized. With that, this
> additional condition can go away.

I missed the right place to do that before, I think I now found it, so
moved.

Thanks for the review,
Reimar
