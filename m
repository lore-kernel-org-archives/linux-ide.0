Return-Path: <SRS0=uYUo=3G=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187D5C33C9E
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jan 2020 04:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53A72072E
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jan 2020 04:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BlS6NIK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgAQEpD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 16 Jan 2020 23:45:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45481 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbgAQEpD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jan 2020 23:45:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so11332175pfg.12
        for <linux-ide@vger.kernel.org>; Thu, 16 Jan 2020 20:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MokgjokDaau9PgXyah9t7meHx+Hp5LMTUHDw4uxid9Q=;
        b=BlS6NIK15PEm+eGSVYgfuya7QskELbcfjwOh1z3Jdu1JKvJY+x77K34YboZBqXLnpu
         ukSggBDcAIlckCCzX59yCIqp51vum22WZ5LHagb2zwzDAiqTqL9TtTP8rO4fZAOdTQvD
         rbuR4N2BQf6SeOtFecPN+cI7EorQsbcIB0tOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MokgjokDaau9PgXyah9t7meHx+Hp5LMTUHDw4uxid9Q=;
        b=UdHeyGYPGi0OqOMeUOl40ZzLBL6y85f9oqx5xx+36Jge41810d1zV0ECTxHNXpNcwd
         X7CrELm29mk2EIUG9zgVZfmL5fTXxoStef8Y65oOynu7MoMT9mJAD9ZjTATaLYoiNoEl
         aUH2ER65642/SXBPd8fdLw4gdzEGvWWa+7y+fArxa+XDDIV5y2ETcCrx5vCnc5vuZ8eH
         BTTIUcMSnwxQTA4s+Kd6sM6WWG8JfcEF7VIIe7PrWNGtRSZg95ip4/aERrprBI+3WVhu
         rd5kPlLcEO/rLeredgLJw+D2smzvuea9SQX/SPxroqBD6dxQXoqzasRVbuNmKoKGv2Ze
         KZMg==
X-Gm-Message-State: APjAAAWbC9lxJGz7ZkWMbyAGF1L+ofyGViAyleS1lX2YKBTu0M63wSbk
        CK4F9LondCoiWM4TDRyZ4DDwy7JIkb0=
X-Google-Smtp-Source: APXvYqwUdDO5bNxgzt6V8gz6Oa/ENBV9pGGLK7LI4eMh6x+tGOBXjL92+yPMhVTxDrc87pkEz8Fwyw==
X-Received: by 2002:a63:6c82:: with SMTP id h124mr43082388pgc.328.1579236301832;
        Thu, 16 Jan 2020 20:45:01 -0800 (PST)
Received: from [10.230.24.186] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id c17sm26857376pfi.104.2020.01.16.20.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 20:45:00 -0800 (PST)
Subject: Re: [PATCH v3 0/3] ata: ahci_brcm: Follow-up changes for BCM7216
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20200107183022.26224-1-f.fainelli@gmail.com>
 <d32d1c1e6f32eeed811fa00e1b5d8ca121eea70f.camel@pengutronix.de>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 mQENBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAG0MEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPokB
 xAQQAQgArgUCXJvPrRcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFrZXktdXNh
 Z2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2RpbmdAcGdw
 LmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29tLmNvbQUb
 AwAAAAMWAgEFHgEAAAAEFQgJCgAKCRCBMbXEKbxmoE4DB/9JySDRt/ArjeOHOwGA2sLR1DV6
 Mv6RuStiefNvJ14BRfMkt9EV/dBp9CsI+slwj9/ZlBotQXlAoGr4uivZvcnQ9dWDjTExXsRJ
 WcBwUlSUPYJc/kPWFnTxF8JFBNMIQSZSR2dBrDqRP0UWYJ5XaiTbVRpd8nka9BQu4QB8d/Bx
 VcEJEth3JF42LSF9DPZlyKUTHOj4l1iZ/Gy3AiP9jxN50qol9OT37adOJXGEbix8zxoCAn2W
 +grt1ickvUo95hYDxE6TSj4b8+b0N/XT5j3ds1wDd/B5ZzL9fgBjNCRzp8McBLM5tXIeTYu9
 mJ1F5OW89WvDTwUXtT19P1r+qRqKuQENBFPAG8EBCACsa+9aKnvtPjGAnO1mn1hHKUBxVML2
 C3HQaDp5iT8Q8A0ab1OS4akj75P8iXYfZOMVA0Lt65taiFtiPT7pOZ/yc/5WbKhsPE9dwysr
 vHjHL2gP4q5vZV/RJduwzx8v9KrMZsVZlKbvcvUvgZmjG9gjPSLssTFhJfa7lhUtowFof0fA
 q3Zy+vsy5OtEe1xs5kiahdPb2DZSegXW7DFg15GFlj+VG9WSRjSUOKk+4PCDdKl8cy0LJs+r
 W4CzBB2ARsfNGwRfAJHU4Xeki4a3gje1ISEf+TVxqqLQGWqNsZQ6SS7jjELaB/VlTbrsUEGR
 1XfIn/sqeskSeQwJiFLeQgj3ABEBAAGJAkEEGAECASsFAlPAG8IFGwwAAADAXSAEGQEIAAYF
 AlPAG8EACgkQk2AGqJgvD1UNFQgAlpN5/qGxQARKeUYOkL7KYvZFl3MAnH2VeNTiGFoVzKHO
 e7LIwmp3eZ6GYvGyoNG8cOKrIPvXDYGdzzfwxVnDSnAE92dv+H05yanSUv/2HBIZa/LhrPmV
 hXKgD27XhQjOHRg0a7qOvSKx38skBsderAnBZazfLw9OukSnrxXqW/5pe3mBHTeUkQC8hHUD
 Cngkn95nnLXaBAhKnRfzFqX1iGENYRH3Zgtis7ZvodzZLfWUC6nN8LDyWZmw/U9HPUaYX8qY
 MP0n039vwh6GFZCqsFCMyOfYrZeS83vkecAwcoVh8dlHdke0rnZk/VytXtMe1u2uc9dUOr68
 7hA+Z0L5IQAKCRCBMbXEKbxmoLoHCACXeRGHuijOmOkbyOk7x6fkIG1OXcb46kokr2ptDLN0
 Ky4nQrWp7XBk9ls/9j5W2apKCcTEHONK2312uMUEryWI9BlqWnawyVL1LtyxLLpwwsXVq5m5
 sBkSqma2ldqBu2BHXZg6jntF5vzcXkqG3DCJZ2hOldFPH+czRwe2OOsiY42E/w7NUyaN6b8H
 rw1j77+q3QXldOw/bON361EusWHdbhcRwu3WWFiY2ZslH+Xr69VtYAoMC1xtDxIvZ96ps9ZX
 pUPJUqHJr8QSrTG1/zioQH7j/4iMJ07MMPeQNkmj4kGQOdTcsFfDhYLDdCE5dj5WeE6fYRxE
 Q3up0ArDSP1L
Message-ID: <33d3589b-accf-04c2-5527-5a0f9c632d0b@broadcom.com>
Date:   Thu, 16 Jan 2020 20:44:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d32d1c1e6f32eeed811fa00e1b5d8ca121eea70f.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 1/8/2020 1:25 AM, Philipp Zabel wrote:
> Hi Florian,
> 
> On Tue, 2020-01-07 at 10:30 -0800, Florian Fainelli wrote:
>> Hi Jens, Philipp,
>>
>> These three patches are a follow-up to my previous series titled: ata:
>> ahci_brcm: Fixes and new device support.
>>
>> After submitting the BCM7216 RESCAL reset driver, Philipp the reset
>> controller maintained indicated that the reset line should be self
>> de-asserting and so reset_control_reset() should be used instead.
>>
>> These three patches update the driver in that regard. It would be great if
>> you could apply those and get them queued up for 5.6 since they are
>> directly related to the previous series.
>>
>> Changes in v3:
>> - introduced a preliminary patch making use of the proper reset control
>>   API in order to manage the optional reset controller line
>> - updated patches after introducing that preliminary patch
> 
> The third patch could be simplified by storing the rescal reset control
> in a separate struct member and relying on the optional reset control
> API more. This is just a suggestion though, the series looks fine as-is.
> 
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks! Jens is that good for you?
-- 
Florian
