Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44216C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2802082E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="N3pK6s9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgA3Fsc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:48:32 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:18546 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgA3Fsb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 00:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580363310;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:Cc:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=VbxIk49PwwJL/PpB59nJmX7k7w8iLmssMnvRwXtUHLM=;
        b=N3pK6s9zFhNTv/q8bt0kVBnbEyYrYA5EfWVuZOzB3ilyyVqnk9wpL9N70xhjhOPzAr
        GcRy1/amyNUd5VC7/HoUJDeOhyd0extTUyqz8nn1q9dtuY9FoEyUcMWkUz3Ab5koavfA
        2ksy3zDRVYZJARYOezAG7QRBZW/Z3junexDR+YUaM2+DTQaQDE681GYM15ObuIQhH9qS
        WRhudTcwRmyfiqOxb6Tqzc/mO2bHzfS/6cMKnMX52QNQW2gLOCNBFwPn6xYD5EKoY0G1
        n4LmpfT12bWEj6N2QOhxBci5iWlrUgkxkg9Y5AnGeCwfU/0KS2CGu9vFjQdvQoWQLfn5
        oG+w==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhRLvX2C+0zn1U71blMv0pYsVjxhg=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:2820:4e0f:3a13:7fa7]
        by smtp.strato.de (RZmta 46.1.8 AUTH)
        with ESMTPSA id 20a669w0U5mS2Tp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 30 Jan 2020 06:48:28 +0100 (CET)
Subject: Re: [PATCH] Using of new SanDisk High (>8G) CF cards with the
 pata_pcmcia driver
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Christian Zigotzky <info@xenosoft.de>
References: <c88372ea-1cb7-6ae4-21dd-ff67304c7885@xenosoft.de>
 <24ffb33b-8ccb-3dfb-7a18-bb791f020e08@kernel.dk>
Cc:     "R.T.Dickinson" <rtd2@xtra.co.nz>,
        "contact@a-eon.com" <contact@a-eon.com>,
        Darren Stevens <darren@stevens-zone.net>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <960a3eb7-a290-eb8a-8cec-c2f8141bd5fe@xenosoft.de>
Date:   Thu, 30 Jan 2020 06:48:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <24ffb33b-8ccb-3dfb-7a18-bb791f020e08@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 30 January 2020 at 04:55 am, Jens Axboe wrote:
> On 1/28/20 1:49 AM, Christian Zigotzky wrote:
>> Add new SanDisk High (>8G) CF cards to the pata_pcmcia driver.
> This patch is corrupt, you need to check your mailer setup. I've
> applied it by hand, thanks.
>
Thanks a lot for applying the patch and thanks for the hint because of 
my mailer setup. I will check it.
