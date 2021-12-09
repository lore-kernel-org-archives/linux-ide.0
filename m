Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E00C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 11:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhLILSL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 06:18:11 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38232 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhLILSK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 06:18:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9D6141F37D;
        Thu,  9 Dec 2021 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639048476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EYYfG4Ge59mtOFawYdnxPvLo7ZuwV+NFT/UzA2JQORE=;
        b=mKAioFO2RbO1WuynN0g8NQIcxv0oC/8x/4E9GJ/iDbF2gYM6uopC2WVdmEbaDbO64FxGLZ
        s+H0vSJvACW5+bdYsZfVc+NNJxpv0bE48O4N2D2GWaFve0S2ixF7/jzo1dz0wkdoEASv5r
        rL/aKC2nR2PZxrBuY6hhXrx+G52m1jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639048476;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EYYfG4Ge59mtOFawYdnxPvLo7ZuwV+NFT/UzA2JQORE=;
        b=ZSY/PoxHWLHZXlFOdTNHsGY9rym+uqd+lRTLlEPIJMaOF1p+WBQ0BojpSMwLgPgp2uF64N
        iSG/oiVe3vmztKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9111013343;
        Thu,  9 Dec 2021 11:14:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TIsnIxzlsWF5QQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 09 Dec 2021 11:14:36 +0000
Subject: Re: [PATCH 22/73] libata: add qc_prep tracepoint
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-23-hare@suse.de>
 <116f7933-5dbc-4aae-a300-fa544f0b1b0d@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3ccaa939-2a9a-e063-ff68-ed8b1eedb687@suse.de>
Date:   Thu, 9 Dec 2021 12:14:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <116f7933-5dbc-4aae-a300-fa544f0b1b0d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/21 9:42 AM, Sergei Shtylyov wrote:
> On 08.12.2021 19:32, Hannes Reinecke wrote:
> 
>> Add tracepoint for ata_qc_prep().
> 
>    You're also adding a tracepoint for ata_qc_issue...
> 
Actually, no.

I'm converting the existing tracepoint for ata_qc_issue into a template,
and then adding tracepoints for ata_qc_prep and ata_qc_issue based on
that template.

But I can make a note of this in the patch description.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
