Return-Path: <SRS0=MoT+=UX=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF592C4646C
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 20:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26F220656
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 20:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561409833;
	bh=pz3TyMxp0rK+lUgdIduXiQAPkiEmUPOe3XXhcswbjbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ld7cnCyzCpr4TiSMNLGfJZ2u+ZgwS7n+qZsvtStK0j6030MBOYgS10CDzP62DZksh
	 lglIhXiHxiSnXVd5j2saVJ8daQWSgyZcfWFLTLjHy/SE0vsAZ1sWTKdgD+0VTc1g9y
	 GPSme1YbcyPeygt9SFkzw//FN7MUAlCTcT6y6dxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfFXU5N (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:57:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40971 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFXU5N (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2019 16:57:13 -0400
Received: by mail-qk1-f196.google.com with SMTP id c11so10885116qkk.8
        for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2019 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w2+tn8HCNol89djwY+jruWYrx4o7m/kBbcrpU8XimuQ=;
        b=pFteJswfiqXmP9E2y19bIRdbf6yOng9N5mwW64cQveen0U2Xzs0pmgTm9NxmoLXYM2
         SL8MvJufhx7I8ZQS73bMh1YppDoodts9of2LtVPzPGLDWReRERMGMcP8VMgdwJk5zZ19
         UArYxFbFHHtjVEAUhLfoKb+o65U63pKwcFDUeiclxlOO24YKa2yFJrSTDLETksfPASUM
         NaOWsMKrsSxo/1BTdAfKitfEibXCh9cNgk+1hdJogc94tpEjck7PbYf36lTzhXctzNQo
         J86OviGHPzq2y/frx3RBG9JnWe4P1UPyBGzSRORittdXFIyhOb0jAlJRO/cLhOuci1vy
         Gtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=w2+tn8HCNol89djwY+jruWYrx4o7m/kBbcrpU8XimuQ=;
        b=NTl6YBORcPj8YszIqd/JxycronPT1wzTySFXHbw7m0YRlkuLf8g0Lmryjl3RBbh+iS
         MCM4n0iOpi+UqBQbu6SkI9/MD7efFZVBYXwfHoO4GaPOrG22pBPMa9fhG4PeFnVM51zZ
         OL9cwhLX0NjgpLJMdZpzA2Lx1bnaWJpwInmXH55YYAgMVmQ2y9y7/j+VU+Lo1fGF6X87
         NvmovFMCUpJ830HONGLmY7rpDD1d2vETcU5ugCpmLK/RHShc25xIhYnILhEHNciyPZdR
         OhbmH0iMnpQMlbPAvFv2vxSQc8+8nAdgcYsq0Vs3OcipctzzXHHB34d+sz1UPgvXpjvl
         hVkA==
X-Gm-Message-State: APjAAAXvRuD/fX8XWAWXYGhbmywv+WAhu1jY+TwZ06gTNB7kDR10HpkA
        8jwv0Rp5J/T8gNUzDkgswpQ=
X-Google-Smtp-Source: APXvYqw5c346Egps3IaD4W6/UTZsbF4Rfui33Oju03sCni9W7DjSpeiPJio0Oro3oW30MGTUi0HrLQ==
X-Received: by 2002:a05:620a:12ca:: with SMTP id e10mr68477246qkl.237.1561409832046;
        Mon, 24 Jun 2019 13:57:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::2c48])
        by smtp.gmail.com with ESMTPSA id m6sm6530877qte.17.2019.06.24.13.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 13:57:10 -0700 (PDT)
Date:   Mon, 24 Jun 2019 13:57:08 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] libata: don't request sense data on !ZAC ATA devices
Message-ID: <20190624205708.GS657710@devbig004.ftw2.facebook.com>
References: <20190624163250.GP657710@devbig004.ftw2.facebook.com>
 <BN8PR04MB5812F774A3C047B8899AD4A1E7E00@BN8PR04MB5812.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR04MB5812F774A3C047B8899AD4A1E7E00@BN8PR04MB5812.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello, Damien.

On Mon, Jun 24, 2019 at 08:27:02PM +0000, Damien Le Moal wrote:
> For NCQ commands, I believe it is mandatory to request sense data for the failed
> command to get the device out of error mode. So isn't this approach breaking

Hah, that's a news to me.  We never had that code path before ZAC
support was added, so I'm kinda skeptical that'd be the case.

> anything for well behaving drives ? Wouldn't it be better to blacklist the
> misbehaving SSD you observed the problem with ?

Provided I'm not wrong with the assumption, there's virtually no
benefit in doing this and that's gonna be a *really* difficult
blacklist to develop.

Thanks.

-- 
tejun
