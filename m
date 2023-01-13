Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61131C3DA78
	for <linux-ide@archiver.kernel.org>; Fri, 13 Jan 2023 22:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjAMWoz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Jan 2023 17:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjAMWou (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jan 2023 17:44:50 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE237F9D0
        for <linux-ide@vger.kernel.org>; Fri, 13 Jan 2023 14:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673649884; x=1705185884;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eBHvLdmdEqZp7wzKBhxjpIb9vAX0WonjjojON8von1o=;
  b=IW6bO7cldEZ5Fj/gG6nzTDWrjM15tJDBG4IozbCGTBqHggfk/wR2MqUV
   9kBKXOwQ4qmCmQJZ6B5Ca3n8JuPGN6o1QMSSkb0lLWSrt2a2LdRnuJlvF
   7b+/vNuLzWUeKqmurSJiz5Law/0agBTwfRgBhPfnNa0xT/J8pPsGxel5/
   bKVQ7qrD3GaNdNiP2ChqAfb+ISLlvSVbRBDWy/zyl4V0MCRT8dVQIrGY4
   gJgohGX0B9BNdgl8JPuySb1NCMBBkBnbDNh9vUfg4S0eCNl4uXVxfi1Ok
   Uq/930mHSzLt8SZCvBwO0Bp7xjn5S81MQ5K4XdcWp9HpZeDMuZhcYgEQn
   g==;
X-IronPort-AV: E=Sophos;i="5.97,215,1669046400"; 
   d="scan'208";a="332771927"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2023 06:44:43 +0800
IronPort-SDR: m1PP5rzwi3mv5LIxjIA7oHo2ZxpH4dg87Ts1e+p4IDD0rKU4i6K61k/eQDxx6/udwyYsMEUMpk
 8M0mCMZlHTAAS5FNRnzL1PoZuag33ZPeLiyasciEN7q0UNLyC2uPLt7Kzxq6b5KCiORs9+AAbv
 ejQX38+Pct8IK+WcDWk5hKXBHfnYyY+KzQM7zNHACQQypDowChi9bqpW2nOYqcuxZVA+AxmVfk
 WRogANNfBmSRqLy4cOzCJgDfDMHtUAEcTK/hKCOhkuBszm6h9wbT1lOvjmTVaQKYC9dk31e04I
 sUg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2023 14:02:28 -0800
IronPort-SDR: 1O2HZOw6bTrz4nkIvSccB7ZKQouOrra7NsTiXU/QlcOQtNLUwZ58hsBHvqhP8Nv5v1F4REThxy
 twkFZsNarRtjAUDS8JwXpVkwTcrsyASlW7+fFNlGRc2mEqwtuC9hrh7PONJbxzGInzCRZeW/8Z
 ZYRcifSUJpE9sQpx/cGT4y71KCnArLh/esJRSmwOe+QL7/37MHshMx6yMdQ96sOWfroj43lyf2
 42shweVWGf0U+xyvPHfI4dMpFzLbVvkJOSjxN/GM9QFRkH+AN8WyZJODw/bXF+ocTqgY9grh/6
 s8o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2023 14:44:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NtxLf69JLz1RwqL
        for <linux-ide@vger.kernel.org>; Fri, 13 Jan 2023 14:44:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673649882; x=1676241883; bh=eBHvLdmdEqZp7wzKBhxjpIb9vAX0Wonjjoj
        ON8von1o=; b=G5+1uxPSZXiJqDV6/5jXuM/M+u4VUC5IAL9ilNbq5Ubiyz2+Hnk
        GPFMlYXvDR4teG5oZvNuYLrCkyAisBAZof9niKpKIpGOkyScLxlRzuMYvU7xMC1r
        fCqonayPbhrBJUZI6/kSHrB59Toq6ZtbEpDG8ZK/F98J+dj51D48KfQAWIW38Rib
        AypzEjLhgu9JvXbeOUFVeDVzrui/emjjs7SaRvnDhgta3BTK1j/P5yVg9MsMIX1R
        9VuEUqoKeF3Tvq28LMZUDU/9KveqJYQuDPZp+ZT+PUn94epRrMp78B+KLW1tukY3
        XiKNA1vKFg8yp5RFE9FtCvuAoa7XftG2png==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y2Vi53wv0qMI for <linux-ide@vger.kernel.org>;
        Fri, 13 Jan 2023 14:44:42 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NtxLd6sGBz1RvLy;
        Fri, 13 Jan 2023 14:44:41 -0800 (PST)
Message-ID: <c2ad2551-e179-f0fc-28dc-8e3871b4d06b@opensource.wdc.com>
Date:   Sat, 14 Jan 2023 07:44:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ata: Don't build PATA_CS5535 on UML
To:     Peter Foley <pefoley2@pefoley.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230112-umide-v1-1-78742026a3f1@pefoley.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230112-umide-v1-1-78742026a3f1@pefoley.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/13/23 13:37, Peter Foley wrote:
> This driver uses MSR functions that aren't implemented under UML.
> Avoid building it to prevent tripping up allyesconfig.
> 
> e.g.
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x3a3): undefined reference to `__tracepoint_read_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x3d2): undefined reference to `__tracepoint_write_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x457): undefined reference to `__tracepoint_write_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x481): undefined reference to `do_trace_write_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x4d5): undefined reference to `do_trace_write_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x4f5): undefined reference to `do_trace_read_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x51c): undefined reference to `do_trace_write_msr'
> 
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>

Applied to for-6.2-fixes with a slightly tweaked commit title.
Thanks !

-- 
Damien Le Moal
Western Digital Research

