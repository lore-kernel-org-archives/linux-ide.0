Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15D7C4332F
	for <linux-ide@archiver.kernel.org>; Thu, 12 May 2022 06:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350599AbiELG6B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 May 2022 02:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbiELG57 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 May 2022 02:57:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708EC1836F;
        Wed, 11 May 2022 23:57:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2EED421CA1;
        Thu, 12 May 2022 06:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652338676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8cuhc70WJhGVRlyqcGiXhEgWuGjboKttKdlKZeYH/k=;
        b=08FotzP/dZFOaguP7NtLoygRK6Z0DNF7JuTX6Hs4U6OeU5bxgna/sEAHeOUX+wfid/ikMd
        tAwOQx+iApOHrA0cSkWx6SdP+JAxXV3W4z7C2/Vc0fPgcFgskZUlRoLM5wwSazZJ9S43/d
        znh3k6yUQLHrheIbk4etcVbt9hJ6YyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652338676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8cuhc70WJhGVRlyqcGiXhEgWuGjboKttKdlKZeYH/k=;
        b=XMybFq3x0miy40f2Szg2tI7gwpnNWNWAtzHsQy/X21tXWL3lpk7ulNUUcFUz+cEJl8fb73
        ppSC7JGuZ9ed4vCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0B0513A97;
        Thu, 12 May 2022 06:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8tHBNfOvfGLNWQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 06:57:55 +0000
Message-ID: <7fd1c122-12b2-adff-856f-50ffc5fc6bd1@suse.de>
Date:   Thu, 12 May 2022 08:57:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 13/23] ata: libahci: Extend port-cmd flags set with
 port capabilities
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-14-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-14-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/12/22 01:18, Serge Semin wrote:
> Currently not all of the Port-specific capabilities listed in the
> PORT_CMD-enumeration. Let's extend that set with the Cold Presence
> Detection and Mechanical Presence Switch attached to the Port flags [1] so
> to closeup the set of the platform-specific port-capabilities flags.  Note
> these flags are supposed to be set by the platform firmware if there is
> one. Alternatively as we are about to do they can be set by means of the
> OF properties.
> 
> While at it replace PORT_IRQ_DEV_ILCK with PORT_IRQ_DEV_MPS and fix the
> comment there. In accordance with [2] that IRQ flag is supposed to
> indicate the state of the signal coming from the Mechanical Presence
> Switch.
> 
> [1] Serial ATA AHCI 1.3.1 Specification, p.27
> [2] Serial ATA AHCI 1.3.1 Specification, p.7
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>   drivers/ata/ahci.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
You might want to adapt the subject line, as this patch doesn't touch 
libahci at all.
Other than that:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
