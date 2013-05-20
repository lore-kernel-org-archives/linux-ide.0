From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] make ata_exec_internal_sg honor DMADIR
Date: Tue, 21 May 2013 07:02:38 +0900
Message-ID: <20130520220238.GA30556@mtj.dyndns.org>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com>
 <201305201251.20920.plr.vincent@gmail.com>
 <20130520185929.GA28226@mtj.dyndns.org>
 <201305202243.15125.plr.vincent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ye0-f179.google.com ([209.85.213.179]:57238 "EHLO
	mail-ye0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757036Ab3ETWCp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 May 2013 18:02:45 -0400
Received: by mail-ye0-f179.google.com with SMTP id l3so163927yen.38
        for <linux-ide@vger.kernel.org>; Mon, 20 May 2013 15:02:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201305202243.15125.plr.vincent@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vincent Pelletier <plr.vincent@gmail.com>
Cc: linux-ide@vger.kernel.org, Csaba =?iso-8859-1?Q?Hal=E1sz?= <csaba.halasz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hello,

On Mon, May 20, 2013 at 10:43:14PM +0200, Vincent Pelletier wrote:
> Something like this ? (2/2 - untested)
> Is "horkage" just another way to say "quirks" in this context ? Google 
> translate doesn't help, and urbandictionary has too many entries for "hork" to 
> make me confident.

I think so.  It was originally named by Alan Cox who sometimes plays
with old English dialects, Yiddish, whatnot.

> Alternatively, I would add a "dflags" field to struct ata_force_param, and 
> reuse ATA_DFLAG_DMADIR instead of defining a new enum item.
> 
> As this completely supersedes the atapi_dmadir module argument, is there a way 
> to deprecate it (if at all a good practice) ?

I'd just leave it alone.  It's not like it adds a lot of complexity.

> @@ -6498,6 +6498,8 @@ static int __init ata_parse_force_one(char **cur,
>  		{ "nosrst",	.lflags		= ATA_LFLAG_NO_SRST },
>  		{ "norst",	.lflags		= ATA_LFLAG_NO_HRST | ATA_LFLAG_NO_SRST },
>  		{ "rstonce",	.lflags		= ATA_LFLAG_RST_ONCE },
> +		{ "atapi_dmadir", .horkage_on	= ATA_HORKAGE_ATAPI_DMADIR },
> +		{ "noatapi_dmadir", .horkage_off = ATA_HORKAGE_ATAPI_DMADIR },

I don't think we need noatapi_dmadir as the default is off anyway.

Thanks.

-- 
tejun
