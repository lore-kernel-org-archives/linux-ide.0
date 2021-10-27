Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33249C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 27 Oct 2021 02:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1737160F6F
	for <linux-ide@archiver.kernel.org>; Wed, 27 Oct 2021 02:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbhJ0Ckg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 26 Oct 2021 22:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbhJ0Ckg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 26 Oct 2021 22:40:36 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D952FC061745
        for <linux-ide@vger.kernel.org>; Tue, 26 Oct 2021 19:38:11 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j10so1414819ilu.2
        for <linux-ide@vger.kernel.org>; Tue, 26 Oct 2021 19:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=81G3aLruRb0g4Z4rWqNhGldItEkLpgFA78pRM4/7ilU=;
        b=jNswkoKVNl9JVuUSwRPsXFy76A6LO+Py54NWHbywDnKJmEGNNi2GgmHhtiYvTOGQIS
         eUYuFtedpz8/xQmZqLjXdWEuMJTEehn6qj+H/wDpGbugr/OFxt4epvAE46zdXev02ZQE
         t0iJwKhK29/Hozmv0ZkcT2cUnCGo4vp/7iDUK76jEmafVt7+ZjWm9Q0yWYTMAhEhlO30
         1B0EVLyi+BRmIULQmddkXK0MhxK1rP+6DK8azCczhX7aRIkVo386uFsMTTfQK1+13XMs
         EcqIQqV/vGiUcTJNC/ukY41AbteBnupZJlEfzH3KaV9a42s9K3RC9s4Z1xoHST0xluG6
         /sDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=81G3aLruRb0g4Z4rWqNhGldItEkLpgFA78pRM4/7ilU=;
        b=MGzowueu56Uu2XbbqfrKUvDvRlLkVv3zWE3a0IhQZpnPbEV3LcmNZ6EvYeAPkPoV9p
         828vX+e3b88FCaVMCJL7+6R1Y8BRLOBllD6COsPWRS9b8B6zYDw7X/tVu/+/OL+tSGFb
         5SnnXDnengwIiXPMN1iaT0i9gxEehB5yEMTjVq9oPf1HN0rvvWIer99uioyHEGuKZZwt
         hKnG+/DOs9bHhArVDwT0Zr9q5XTrGlE0rRv2YptsN8XMN34WAdecrJqTfT+f414dV8qm
         O6a3pPNlWn4EBku3t1sA/UGLTHoQOQJ83aEo3bdPQGHM0uyPB9VWhRivefxMBniRhfl+
         zHkQ==
X-Gm-Message-State: AOAM5313GVOZdy823bzHbRUXz6nOPmQT+ediUZjTLavyjs/LB45HfFkr
        ibaTZmI1pN8Ul2T4dKepzJtL9XM4jFZUyQ==
X-Google-Smtp-Source: ABdhPJxwrUlDhLqhGiHSUrUxnVKQny13zSdbVKj8KuozIcu3Y0lKMzLF1OrlQKGCjzWuTs+KKVWZjg==
X-Received: by 2002:a05:6e02:1c0c:: with SMTP id l12mr17281351ilh.69.1635302291004;
        Tue, 26 Oct 2021 19:38:11 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id q1sm241459ilc.88.2021.10.26.19.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 19:38:10 -0700 (PDT)
Subject: Re: [PATCH v9 0/5] Initial support for multi-actuator HDDs
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20211027022223.183838-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cea34b2a-6835-d090-4f0c-3bf456a6ed00@kernel.dk>
Date:   Tue, 26 Oct 2021 20:38:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211027022223.183838-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/26/21 8:22 PM, Damien Le Moal wrote:
> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> Single LUN multi-actuator hard-disks are cappable to seek and execute
> multiple commands in parallel. This capability is exposed to the host
> using the Concurrent Positioning Ranges VPD page (SCSI) and Log (ATA).
> Each positioning range describes the contiguous set of LBAs that an
> actuator serves.
> 
> This series adds support to the scsi disk driver to retreive this
> information and advertize it to user space through sysfs. libata is
> also modified to handle ATA drives.
> 
> The first patch adds the block layer plumbing to expose concurrent
> sector ranges of the device through sysfs as a sub-directory of the
> device sysfs queue directory. Patch 2 and 3 add support to sd and
> libata. Finally patch 4 documents the sysfs queue attributed changes.
> Patch 5 fixes a typo in the document file (strictly speaking, not
> related to this series).
> 
> This series does not attempt in any way to optimize accesses to
> multi-actuator devices (e.g. block IO schedulers or filesystems). This
> initial support only exposes the independent access ranges information
> to user space through sysfs.

I've applied 1/9 for now, as that clearly belongs in the block tree.
Might be the cleanest if SCSI does a post tree that depends on
for-5.16/block. Or I can apply it all as they are reviewed. Let me
know.

-- 
Jens Axboe

