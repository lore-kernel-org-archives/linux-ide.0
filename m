From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/5] sata_mv new mv_sata_hardreset handler
Date: Thu, 03 Apr 2008 23:35:53 +0900
Message-ID: <47F4EB49.8030706@gmail.com>
References: <47F1736F.8020104@rtr.ca> <47F1755F.9000303@rtr.ca> <47F2F002.9070401@gmail.com> <47F3E3A8.10309@rtr.ca> <47F429B0.7020204@gmail.com> <47F44572.5010100@rtr.ca> <47F44BCB.7030005@gmail.com> <47F4E341.9080609@rtr.ca> <47F4E3E4.5080706@rtr.ca> <47F4E530.5040901@gmail.com> <47F4E7E3.2030108@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.191]:28434 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758854AbYDCOgE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Apr 2008 10:36:04 -0400
Received: by rn-out-0910.google.com with SMTP id e24so2066686rng.1
        for <linux-ide@vger.kernel.org>; Thu, 03 Apr 2008 07:36:01 -0700 (PDT)
In-Reply-To: <47F4E7E3.2030108@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
> Mmm.. I still need a way to handle access to the port-multiplier registers.
> We never did resolve that one fully on the earlier pass.

Yeah, I thought about that during the API change.  I think we should one 
of the following two.

1. Separate out actual reset part from ata_sff_softreset() and use it in 
sata_mv so that sata_mv can do...

mv_srst()
{
	check onlineness;
	set up PMP reg;
	return ata_sff_do_softreset();
}

2. Move link onlineness test before softreset into EH.  It's common to 
all drivers anyway.  This will allow mv to do.

mv_srst()
{
	set up PMP reg;
	return ata_sff_softreset();
}

I like #2 better but there can be exotic cases where link onlineness 
can't be tested before the link is actually reset.  I don't think it 
will really matter because hardreset is present and preferred if link 
onlineness test is valid && hardreset doesn't care about link onlineness.

Thanks.

-- 
tejun
