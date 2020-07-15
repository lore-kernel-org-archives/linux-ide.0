Return-Path: <SRS0=C1w+=A2=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A7C433DF
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jul 2020 21:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E894620672
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jul 2020 21:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=octiron.net header.i=@octiron.net header.b="ecj/kQR7";
	dkim=pass (2048-bit key) header.d=octiron.net header.i=@octiron.net header.b="ylJXN1zV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgGOVVp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:21:45 -0400
Received: from djelibeybi.uuid.uk ([45.91.101.70]:53820 "EHLO
        djelibeybi.uuid.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOVVp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2020 17:21:45 -0400
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2020 17:21:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20180214; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EhgG2CTQfcvprQjhPT7XeqhEzStobaQ7jP786fGmLKY=; b=ecj/kQR7Z70erhemGvXu4P1wac
        FrdBrZo2hm4RJgYaWBumHD6y6PPBslakIDNWE1jBYowKPGzO2QvkY8xa3cDtcjo5ORYYokRW/4IRB
        PQyENqCxANS3GY7cyi3uO3CSAFO75oel29TJINAs55gKJNlXB0hkErgaRZwACcpRwTUkiT4MgaMxd
        6K+ddxICXUOeNkRkqWA7zj0Hy1jPyuBr2ryTMK8waGoag3trr3PUpL/rcyq/7WcW74reRU08J8E2M
        TZcDfXnNWLNVPUUYL8lJz4SHE97VAh/gflLyQHZ9xLXg3bXThfmHRAfPp9JRXZbzMSIUhnxB1Rcc7
        REwfLN9w==;
Received: by djelibeybi.uuid.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <simon@octiron.net>)
        id 1jvohp-0005vV-Rx; Wed, 15 Jul 2020 22:12:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20180214; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
        bh=EhgG2CTQfcvprQjhPT7XeqhEzStobaQ7jP786fGmLKY=; b=ylJXN1zVTcXtEUvEGvkox9xu9i
        tyvpJWVYWnL8ErM+Bqe1FHnNZGBJaSpN3xUwnv7uMdmeSPzrfNl0nfTLXqX9wYKRlp4kX2PanCJb9
        fWrqk4HxWdX+kR3fJPgUlKyEYlM7CUw6hfkGuhWwzdJUk1lL60FXatLkLzN5xvQSDvQuGymhsLL60
        B7kO7/Xa8dWys2KB13+xnMXH46LTZ5ZCIrgX8g2R92TGrJXVJVZe0njteSqYQ9rGzUEUXSEM8FGpv
        bLsjD/utnPizQp6PU1vuPJSF7HDwLaisPDOB1lHVgGbB4g9rB0hjFWMtmQHC7aP0sOhOvv8nHDl3w
        qEw+mXcQ==;
Received: by tsort.uuid.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <simon@octiron.net>)
        id 1jvohn-0008II-40; Wed, 15 Jul 2020 22:12:43 +0100
Subject: Re: [PATCH] ata: Disable queued TRIM for Samsung 860 SSDs
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Park Ju Hyung <qkrwngud825@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <9324ef33-eedd-b965-37e8-b82e06778aab@0882a8b5-c6c3-11e9-b005-00805fc181fe>
 <yq1blkgo6y0.fsf@ca-mkp.ca.oracle.com>
From:   Simon Arlott <simon@octiron.net>
Message-ID: <5059c002-2452-f427-76da-7b08a02748dc@0882a8b5-c6c3-11e9-b005-00805fc181fe>
Date:   Wed, 15 Jul 2020 22:12:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <yq1blkgo6y0.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 15/07/2020 21:53, Martin K. Petersen wrote:
>> Despite the unsubstantiated claim from Samsung that "the improved
>> queued trim enhances Linux compatibility" this does not appear to be
>> true, even on Intel SATA controllers:
> 
> I am aware of several people using 860 drives with queued TRIM. And I
> haven't heard any complaints outside of the bug you referenced.
> 
> Also, I have tested both 860 2.5" Pro and 860 mSATA EVO on a few
> different systems in my lab without any problems. See:
> 
>     https://lore.kernel.org/stable/yq1h87du82d.fsf@oracle.com/T/

I've just checked and it happens on both my SATA 860s:
  860 EVO 2TB (RVT04B6Q) on Intel Z170
  860 PRO 1TB (RVM02B6Q) on Intel H170

> I really wish we had some more data to work with :(

Is there a reliable way of reproducing this?

I have a Marvell 88SE9235 that I could try with the EVO.

> Lacking a proper heuristic I guess we don't have any choice to disable
> the feature. But that's sad news for the people who currently don't have
> problems since their performance will inevitably suffer.

Samsung need to identify what the problem is before claiming that their
Linux support is better, especially if specific chipsets are known to
have issues...

-- 
Simon Arlott
