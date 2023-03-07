Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0B3C6FD1F
	for <linux-ide@archiver.kernel.org>; Tue,  7 Mar 2023 10:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjCGKnD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Mar 2023 05:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCGKnA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Mar 2023 05:43:00 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBE059D7
        for <linux-ide@vger.kernel.org>; Tue,  7 Mar 2023 02:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678185778; x=1709721778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+LVO3F5En6AqL41D+hH/tg3GKjgWE12xa9SmTfU53w4=;
  b=IbbRUjXreFmumgTsTvcYdW4ICjY+asglw0Yi0RkHx7aoSUNIw08W3Dtr
   qXZsXNheJB+eJp1vUI97MPEB/QYrwquEYCnEYmdfHK+ddcDUMq61c3i5J
   x/UAYwTuD5ZkvDVY5qqdWqw72d5jYSmGSEawhDP0ZUaTD1kDFJNYgMcc8
   mCRILMqdmClu2AqF7LJrskbFYa1r9z+ohb6NTow6xh3duimGcsCfbJ0Ox
   Ce+ZC+fihL2/FLa7E95AgRUcahOE5jUwmt9l+9T4gThhDpvb59A3Dv+Gr
   XwBMgCASbVnDzde47Q6QkHg85ddFlS9iI9Nida0RszNcQdUx7JSJBl/ax
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,240,1673884800"; 
   d="scan'208";a="224997658"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2023 18:42:56 +0800
IronPort-SDR: 5Yi37gH1+VGbJpbkRU3OtbwGSXOqjAe3jWmD5OAOXGpqihF1XLkNtAc2S26zhszQb9aeQobCqQ
 dxiP9SeEM4yHB3vH3dJPsBukcDCcZP45glAF7+qqygTPe/CTcSM7OsJFwfa4Aa6u4weJlU1Ta/
 OcXuQZYQQg5uZsJL2yW1f0SYMBX9I2N4MKcV5nzc/pE1uDMB3K4fl6pV8lydZtjOqhg8w4vlaK
 yFZ3I55l3rliSlDOXLepDoeZjeKqt3wzWs1SG3btHWX4o0tOIto/8ZAGdzcAqC7KpzEinkzl8N
 4v4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 01:53:54 -0800
IronPort-SDR: TWgjjWQ/P8KyVUZo3NWxRBPlxtQa9CiLn3AIVi9GdwUXhj4HBqRDI+SVmshw4zXi7H22dvRtpO
 WXs4KXKu/kGySv4uJuvM7Z/TNXRV3UqGW7dqt79zAT/IK36/DNupJoY4yOvlHO7Kr/9jhA5l9K
 5UMrSnhtwjFsXr0M6y21xx5nH5k2+v3UBRM/eMO5N3jT6uhgNZ8fFSWqgi8lrRCgGTJaWC79fC
 r1fhT4VUBIqAxTbkCdmquWQ0Z0jmw6yUvikfbLApKiAQkk5ycVDLU3tZchd89eGTfHJ2nW8XwL
 j1o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 02:42:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWBqM5HnBz1RwtC
        for <linux-ide@vger.kernel.org>; Tue,  7 Mar 2023 02:42:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678185775; x=1680777776; bh=+LVO3F5En6AqL41D+hH/tg3GKjgWE12xa9S
        mTfU53w4=; b=QnGK3Wk9GsSyj5KfqDrTjG++jMnDI2lAxJHYL0K4FLtLPUJmdwa
        TK+jMfwx7EJFzWvYcyNbTKHm5iIwQpu7bcgtjNQlONKObRr0mIGowkNfnpW4g+hN
        soQ2fWLjczlYucbDnE/cvkrguMu/H6itKptiiETR2QrMw50JABCJliVmhL+hJAkr
        PlATr9FExwRk3oAPNjd9koO25F9dVy0W783Ut69QwfXbzWjGLAUkyGueat7WE2a9
        exnoxwwmIKj7ixqBfM2WWKwlqwbISXFAG7aw7b4eG9DUXdkNWJfyWoJ9v2QtznXf
        rmvD8b5vydQb5nVqSsbh818Y1xkPELII46Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VMBtiZNlo1RB for <linux-ide@vger.kernel.org>;
        Tue,  7 Mar 2023 02:42:55 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWBqK3WwWz1RvLy;
        Tue,  7 Mar 2023 02:42:53 -0800 (PST)
Message-ID: <e5ed284a-77ac-df6d-1473-e4d96955f65b@opensource.wdc.com>
Date:   Tue, 7 Mar 2023 19:42:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] dt-bindings: ata: Add UniPhier controller binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222155906.19403-1-hayashi.kunihiko@socionext.com>
 <9d36818f-3ce3-0fb6-1a3e-85e3879af08c@opensource.wdc.com>
 <a6425bde-5b6d-2fb2-2396-a35677b19e8f@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a6425bde-5b6d-2fb2-2396-a35677b19e8f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/7/23 17:13, Krzysztof Kozlowski wrote:
> On 06/03/2023 02:22, Damien Le Moal wrote:
>> On 2/23/23 00:59, Kunihiko Hayashi wrote:
>>> Add UniPhier SATA controller compatible string to the platform binding.
>>> This controller needs three reset controls for Pro4 SoC, or two reset
>>> controls for PXs2 and PXs3 SoCs.
>>>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>
>> Rob,
>>
>> Are you OK with this patch ? I can take it for 6.4.
>>
> 
> You got Review (which includes also "Ack"), what are you missing here?

By the way, I am not seeing/have not received any Ack. Hence why I checked with Rob.

> 
> Best regards,
> Krzysztof
> 

-- 
Damien Le Moal
Western Digital Research

