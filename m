Return-Path: <SRS0=qPb7=XG=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151DCECDE27
	for <linux-ide@archiver.kernel.org>; Wed, 11 Sep 2019 06:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD43D21D79
	for <linux-ide@archiver.kernel.org>; Wed, 11 Sep 2019 06:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V114r1ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfIKGeS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 11 Sep 2019 02:34:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfIKGeS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 11 Sep 2019 02:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NxumLBXKhrGkKG+AaEhaA8oeauVpGtQmaHSyRChfT+8=; b=V114r1kuPMlvjEw4v9UNHSVrJ
        VyNjaELEOptpWTHvwQq8l4sfwQ/VOY5/A+HYIM+R7opzz8CtsdP0fXlboO1DPiG8cM8S+XfDaBLnh
        pUV8pI1KuMTeCj17yIfaoyB5tXvS53XpznFnFSVrP8rC37hCIP2NcON32JedzH1TRGJ7X4EPmmiQ0
        YZjp6cscxXULe2SWA5LBOj5eGUyZHKj6AMfnynD6HbjicvCNm7NKAO5zrUZrZ1Y1+dWZCMRwAuwFv
        VDlWlLi8K3bfmfal/1Y+qMOUjHukofuDEXZtDzmCqhPCnHolWziRh2TRrhJam3IHggsG0SpJCQ3Ec
        Rs4psXQLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i7wCm-0007W1-3a; Wed, 11 Sep 2019 06:34:16 +0000
Date:   Tue, 10 Sep 2019 23:34:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bryan Gurney <bgurney@redhat.com>
Cc:     Jorge Fernandez Monteagudo <jorgefm@cirsa.com>,
        Christoph Hellwig <hch@infradead.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SATA errors accessing hidden partitions
Message-ID: <20190911063416.GA25673@infradead.org>
References: <AM6PR10MB33991CE19828429C676C0296A1C40@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <AM6PR10MB339928C6DF7AF88789F904EFA1B70@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <20190910055333.GA32641@infradead.org>
 <AM6PR10MB339977CEF9AB4C3726AF3124A1B60@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <CAHhmqcSGK2W0Gz9CM=cKYH6PjtGnOwnWtadG7qOwYmQLjGwNAQ@mail.gmail.com>
 <AM6PR10MB3399036D93B32666191730D1A1B60@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <CAHhmqcTF1wBq037v2dDrKOs8tNhAMzw4_nY_52KY65NvCqWDXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhmqcTF1wBq037v2dDrKOs8tNhAMzw4_nY_52KY65NvCqWDXw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Sep 10, 2019 at 11:12:36AM -0400, Bryan Gurney wrote:
> Oh, okay.  I'm pretty sure that blkid checks regions near the end of a
> device (for example, GPT has what looks like a backup of the "EFI
> PART" boot record near the end of the device).  Therefore, it may be
> worthwhile to double-check the size of the partition, in case they're
> not 4 GB, for some strange reason.

Some MD RAID suprblocks also are at the end.  Either way I'm pretty
sure this is legitimate probing and not a bug.

> Why is there an "Illegal Request - Unaligned write command" sense
> error from sd, right after the failed ata command "READ FPDMA QUEUED"?
>  Is this an expected failure mode for a read to a locked range?  (I'm
> not familiar with TCG Opal drives, so unfortunately I don't have
> enough context.)

It could be that we are just having issues translating the errors,
especially given that we don't use sense data in ATA except for ZAC
drives.
