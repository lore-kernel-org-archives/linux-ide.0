Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F4CC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 09:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4790B60EBD
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 09:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbhJKJFd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 05:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbhJKJFc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 05:05:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066A9C061570
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 02:03:33 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w14so13207572edv.11
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=iTKf9DjdX7ML7oblVR6PfUkecF3hAuiXfMlow5WBY5M=;
        b=fM3OFN1NcNSQHmhbZgC5OTj5gsEMcRzZ8HxHGbDp6wavW8C0zD2dZm0cAi3KnD+nTL
         301EgNcohzawcxfJ6gAUIg9EmJeZ1lWlhp6bq4o6qpFAAag6cxKUn5lfKLmcAup/ivvw
         UQcVHiX8zwq07/uquWvPtpFOheadrVZaNOJGFspj7HDG5lrsJQ5MKogpNxGrEQAnZpJj
         kUdyAEBCGn3YF0gpM7eUf4SCsWY/IJO1rCNDHs/457hGb8XKQRQ6XCSQ6LBCsyzAXMG5
         rQmJztyDwEdITkCtq6QYt4oXEUS9io6dAuFFebP9wL9bpHaD0tk3hKzMq2PooEkMqWsa
         z/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=iTKf9DjdX7ML7oblVR6PfUkecF3hAuiXfMlow5WBY5M=;
        b=n1LJa7PA5zTIe9+SYmjnK3ANkQtIjxE12TC1g6jQOwHBRyzP2zuzRiqqnpn3W9zyn3
         zJCsXprWOVftIi5yjo1DqgRiZHO3NuPfPVTlK/ML8ZmiQBje91V9q6YhaVOvS79g0WKy
         JZgiUoem0RQxa/FMgjm5Hr1u63I0cmD8GQZ5VZDovpewFIyH4eRZEIKkFwqxs0RsCtEU
         6IVh3ZKnAWyilatbFDDSCJqreKNIqK3qlYEBUn3kj7Sc7z0w/Zw4q89ztzSfXSlLY3wo
         nJ/6P0GKrWQrylGGDzqf6Ypc0zAYsreqWtIYA1N0y7UO2Xecf9vI5LjW+3xNaJGTiBQ6
         HGiQ==
X-Gm-Message-State: AOAM533GY6ap5i2auLEKow7UtBXT/7b9SBISlABM/3WUGcpqgrUQeznG
        Snim02OugxYVb9PEX32in84=
X-Google-Smtp-Source: ABdhPJz6ZsYwCQc6BtDG/MRzVsNGtWXc/Cp6f6vaGAxo4ubXBeDPRTdbUkYuhApi9iG3e0vJW9Q53g==
X-Received: by 2002:a05:6402:b84:: with SMTP id cf4mr1395370edb.385.1633943011528;
        Mon, 11 Oct 2021 02:03:31 -0700 (PDT)
Received: from ipc5 (netacc-gpn-204-127-150.pool.telenor.hu. [5.204.127.150])
        by smtp.googlemail.com with ESMTPSA id e11sm3911278edl.70.2021.10.11.02.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 02:03:30 -0700 (PDT)
Message-ID: <88ba8f60e5b13b1708b189a7c798571929cd7657.camel@gmail.com>
Subject: Re: Asmedia 0x0624 support in linux kernel - news, test results
From:   =?ISO-8859-1?Q?Pongr=E1cz_Istv=E1n?= <pongracz.istvan@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-ide@vger.kernel.org
Date:   Mon, 11 Oct 2021 11:03:29 +0200
In-Reply-To: <42b5a0ad-3adf-83d1-1973-c50d8843e2dc@opensource.wdc.com>
References: <8f4b17c763cb2742c6699d54d7577834b411722b.camel@gmail.com>
         <ab2fde897de1bbbafcec8cf81e05346430c782a4.camel@gmail.com>
         <YVx5aRInLEvV3eaQ@slm.duckdns.org>
         <23d115f656a3834c24180621667ba87da4d6620f.camel@gmail.com>
         <42b5a0ad-3adf-83d1-1973-c50d8843e2dc@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

>>     /* Asmedia */
>>     { PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },   /* ASM1060 */
>>     { PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },   /* ASM1060 */
>>     { PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },   /* ASM1061 */
>>     { PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },   /* ASM1062 */
>>     { PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
>>     { PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
>> +   { PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci }, 
> Similarly to the other entries above your addition, please add a
> comment at the end of the line mentioning the adapter model.
> And use "git send-email" to send the patch to me and to 
> linux-ide@vger.kernel.org.
> Feel free to let me know if you have any problem.

Hi Damien,

I sent the patch as you requested.
Sorry for the duplicated patch, the first one probably went to the spam
folder.

Bye,
István


