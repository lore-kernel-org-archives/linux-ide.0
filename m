Return-Path: <SRS0=Eprx=45=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB3CC10DCE
	for <linux-ide@archiver.kernel.org>; Thu, 12 Mar 2020 13:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF7A2067C
	for <linux-ide@archiver.kernel.org>; Thu, 12 Mar 2020 13:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0+qXPbtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCLNoy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:44:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35184 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLNoy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 Mar 2020 09:44:54 -0400
Received: by mail-io1-f66.google.com with SMTP id h8so5730622iob.2
        for <linux-ide@vger.kernel.org>; Thu, 12 Mar 2020 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jSod36pOWDs7X6aIKTPYmJy2lYb5ks2I2R+9h0FGWFU=;
        b=0+qXPbtGwDNE2YoNE0/9VIQd8MBavMQgoIxqFLu3EY73F2R3ZlDW7Gd3co7LH0Ul1a
         G+NbPTk12xnDTBtWv8RvV13XG61ItjUpzps9ExMctG060ZIss78OP2m2PNU4PLUJI8IM
         FHY36kGwS586lRSR9BCxgZbEpkYDxCZFbmfrLcCbPjR9c6m87/ft2eVyqEy+9v4mAYkw
         pv0qFd3LE9AlAIkcSoPczCGDeGvI4dL4D3o1plsYgrSMeezl+uFeMID2zw1eE6174Plp
         gbNNSpq/DYxQ7AzFFNUIMBgBSIrPyVeOadoCU/SAvR7dS51stOKlgMGaBKuQ1MUk7of6
         WugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jSod36pOWDs7X6aIKTPYmJy2lYb5ks2I2R+9h0FGWFU=;
        b=KYOwVLF7AUG9O2WS2MSsgWZu83Dw8M+crSS8QjoCehR5sZWNoQ0ulnEKCKiniOaE6P
         6i5Em76fr6Y5eGM8JR8CDrNuDZSdydGPklOXKDKfocpT8VnDNJOYzlp4JktQV0Wvgjug
         WZUfiOc1f5GV6n69d6dm1Nn+1+W0AoTG/FrAnxaoLIZgqRsWoOPHlYWQZPNGP64zvWk0
         rvth7DSd80E1/o87BaOwyp54rsHWVrPVMGpHyEomqAeNXL9COSf+tLh5shP6yNUTQucE
         V2If8k0DMk42hLxVcgvxXciUsYsYe+IREZHgzT1BDXBAxAtMI575SXYyOCadU8h5R3JV
         xWeg==
X-Gm-Message-State: ANhLgQ0/OFSRcvPV0tgyGsCy5VrF2Foxsw14MmI3kd2gp574FzEQGpC0
        6wqysE9vChLjOlwpq1mxQNqukCs2lUC3Qg==
X-Google-Smtp-Source: ADFU+vtkdkvvhK1Qd+AjLgeTPV6ydTaQgxfR/zxzfvz+3djEa3i9d5g8qDxKTYrXRZCJwr4GdUbzVw==
X-Received: by 2002:a02:3f4c:: with SMTP id c12mr1230937jaf.115.1584020693065;
        Thu, 12 Mar 2020 06:44:53 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q6sm5341596ild.70.2020.03.12.06.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:44:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] AHCI: Add support for Loongson 7A1000 SATA controller
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <1583844608-30029-1-git-send-email-yangtiezhu@loongson.cn>
 <1583844608-30029-2-git-send-email-yangtiezhu@loongson.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <12315c32-4e97-8d05-2dff-709fad3b0d38@kernel.dk>
Date:   Thu, 12 Mar 2020 07:44:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1583844608-30029-2-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/10/20 6:50 AM, Tiezhu Yang wrote:
> Loongson 7A1000 SATA controller uses BAR0 as the base address register.

Applied with the pci vendor addition for 5.7, thanks.

-- 
Jens Axboe

