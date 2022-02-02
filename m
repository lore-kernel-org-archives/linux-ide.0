Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D1C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 12:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245587AbiBBMZX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 07:25:23 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:44592 "EHLO mail.acc.umu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232638AbiBBMZW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 2 Feb 2022 07:25:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by amavisd-new (Postfix) with ESMTP id 5974F44B90;
        Wed,  2 Feb 2022 13:25:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=acc.umu.se; s=mail1;
        t=1643804721; bh=GeZ215mtALRDoHttRHcLxwwcpbW2eVsLQnmWu3W4MQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmrcB+DzRmWrbS4iGNMxXcQCS+mq5SdWFjylHKxUcoXXpbmNo9jjCxcpCGsZa2NFT
         D00z/tvbLqW/ptzSJRtwj0yU/aXlJsAjfwMrW86+Q4Nc2CD6XnWt+dTce42PdhdaTk
         QFSfM8kyP7KmvGDN7EGE40QCTwoRLsXlth2ZQiSmrCOwK93aMrILOB+5FBPeL3Vdit
         yWL2ov81kNa7NWobhZ53zzQp7pkx4dW5O5VCwiZ0oExBOXUb7fFpS/9aguosQ9wnrA
         sbtUFXSJ8SReTAeqVYtKNcq1OrSVle7FEiJ6EZQe03w6iTeURrFc5O5mdAf2THXxNj
         ItzGtDojz7mBQ==
Received: by mail.acc.umu.se (Postfix, from userid 24471)
        id D6FCA44B92; Wed,  2 Feb 2022 13:25:20 +0100 (CET)
Date:   Wed, 2 Feb 2022 13:25:20 +0100
From:   Anton Lundin <glance@acc.umu.se>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH] libata: Don't issue ATA_LOG_DIRECTORY to SATADOM-ML 3ME
Message-ID: <20220202122520.GE723116@montezuma.acc.umu.se>
References: <20220202100536.1909665-1-glance@acc.umu.se>
 <bf9f47f1-08c4-370b-446a-1ae9efdc772a@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf9f47f1-08c4-370b-446a-1ae9efdc772a@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 02 February, 2022 - Damien Le Moal wrote:

> On 2/2/22 19:05, Anton Lundin wrote:
> > Back in 06f6c4c6c3e8 ("ata: libata: add missing ata_identify_page_supported() calls")
> > a read of ATA_LOG_DIRECTORY page was added. This caused the
> > SATADOM-ML 3ME to lock up.
> > 
> > In 636f6e2af4fb ("libata: add horkage for missing Identify Device log")
> > a flag was added to cache if a device supports this or not.
> > 
> > This adds a blacklist entry which flags that these devices doesn't
> > support that call and shouldn't be issued that call.
> > 
> > Cc: stable@vger.kernel.org # v5.10+
> > Signed-off-by: Anton Lundin <glance@acc.umu.se>
> > Depends-on: 636f6e2af4fb ("libata: add horkage for missing Identify Device log")
> 
> I do not think so. See below.
> 
> > ---
> >  drivers/ata/libata-core.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index 87d36b29ca5f..e024af9f33d0 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -4070,6 +4070,13 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
> >  	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
> >  	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
> >  
> > +	/*
> > +	 * This sata dom goes on a walkabout when it sees the
> > +	 * ATA_LOG_DIRECTORY read request so ensure we don't issue such a
> > +	 * request to these devices.
> > +	 */
> > +	{ "SATADOM-ML 3ME",		NULL,	ATA_HORKAGE_NO_ID_DEV_LOG },
> 
> This flag only disables trying to access the identify device log page,
> it does *not* avoid access to the log directory log page in general. The
> log directory will still be consulted for other log pages beside the
> identify device log page, from any function that calls
> ata_log_supported() (e.g. ata_dev_config_ncq_send_recv() and
> ata_dev_config_ncq_non_data())

Non of those code paths are called for this device, probably due to some
other flag disqualifying them.
 
> So it will be a lot more solid to define a ATA_HORKAGE_NO_LOG_DIR flag
> and test for it in ata_log_supported(), completely preventing any access
> to the log directory page for this drive type.

That was my first thought but then I found ATA_HORKAGE_NO_ID_DEV_LOG
which was in the calling path that actually triggered this issue.

But, yes, I totally agree that's a more solid solution preventing this
kind of issue to crop up again.

> > +
> >  	/* End Marker */
> >  	{ }
> >  };
> 
> Note: if you need this fix sent to linux-stable, add "Cc: stable@..."
> and a Fixes tag.

I'd think it's fitting to send it to linux-stable, because it prevents
those DOM's from working in v5.15.5+.

Ok. I must have missed that part when I read submitting-patches doc.

I'll rework and re-submit the patch.


//Anton
