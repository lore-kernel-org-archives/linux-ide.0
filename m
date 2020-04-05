Return-Path: <SRS0=zDqJ=5V=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322FDC2BA15
	for <linux-ide@archiver.kernel.org>; Sun,  5 Apr 2020 17:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E692020678
	for <linux-ide@archiver.kernel.org>; Sun,  5 Apr 2020 17:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ2t6Svs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgDER3Q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:29:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46690 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgDER3Q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 5 Apr 2020 13:29:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id s23so4937253plq.13
        for <linux-ide@vger.kernel.org>; Sun, 05 Apr 2020 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jsWc1Tacq4s81sbllAGygyNYwbCXSMOr0wtt+mMDgpQ=;
        b=DJ2t6Svs+f9P73v5SattcmY5Ilt/aE+2GUrKs8VzWrDFwkJzFfkW7oL6UXRUWxOelH
         aOm2fqf1CweFj32U6GXurB7xagFaTgiKOFgPiKLoLxUCyqs2qP/Ywc68Iei60y6FHY/0
         0xzcdUrTKUJ3K2DLAPmqe0XrY1xbnpLSS1dfmlJEgLtRx8qEzL/NmGbwRBqOTUXjjUaW
         2qiqWL75P5DMXaCDrPNtB75zsBxKNEzGd3QO+D7PtnyueKSpOpiN+nJJ6J53yww6/FVm
         CYdNQSvaYKDSu3jI97RnE4E9RVeUJJYiF+E+fElPVtxofqNSVUGOUHMdye4THXQfa37j
         PrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jsWc1Tacq4s81sbllAGygyNYwbCXSMOr0wtt+mMDgpQ=;
        b=LGRc0CBSK0QdIfwINOypBSr87cdPR9SD8y+h6ZpgnXtZ2fo1EKUfGSHoZDbSavlijE
         dPPKNx8X03u8P7AC1UqEQ1E6nL37n+fpA83idXpmGI+QoT+sJKVMr9pD0LZk7zp/ZDFV
         tvMwxUIlUAjF22p7CBJZwNGAbp/+ybdMzTQ2S9ycWBdAZ0w4mWaNRGtgjLOXt6qatWNb
         W2YfhjEuSWn/okorlAQv/7zJTMclJWwF0GEwKmIjMrgE8jw8s92dSCkK4G8OeiSCPe6a
         bv+CtV20I31UaHMPbZUveslVF2xzHZu/F0PyonV8DPTNGDCCcx1rFv6nYKDlowcUQEU8
         mKKg==
X-Gm-Message-State: AGi0PuZw6ZnhoJ2m5dqQb8INBB3r5IQwCeHiO+tYHF4GfnN2NSvNpXBL
        9OJd9qL/lC+/oSW2wvS9hxM=
X-Google-Smtp-Source: APiQypJI9M1DVPw4RtWII/p3keg2tIzxI/VLaophBdakijTBc10EHbMkQ6w5pjXtS6ROCd8VHiwGzQ==
X-Received: by 2002:a17:90a:d101:: with SMTP id l1mr21705348pju.1.1586107755380;
        Sun, 05 Apr 2020 10:29:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m29sm9025508pgl.35.2020.04.05.10.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Apr 2020 10:29:14 -0700 (PDT)
Date:   Sun, 5 Apr 2020 10:29:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     qiwuchen55@gmail.com
Cc:     davem@davemloft.net, linux-ide@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] drivers/ide: convert to list_for_each_entry_safe()
Message-ID: <20200405172913.GA168671@roeck-us.net>
References: <1581671785-25125-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581671785-25125-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Feb 14, 2020 at 05:16:25PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use list_for_each_entry_safe() instead of list_for_each_safe()
> to simplify the code.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  drivers/ide/ide-scan-pci.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ide/ide-scan-pci.c b/drivers/ide/ide-scan-pci.c
> index acf8748..383f0d8 100644
> --- a/drivers/ide/ide-scan-pci.c
> +++ b/drivers/ide/ide-scan-pci.c
> @@ -89,8 +89,7 @@ static int __init ide_scan_pcidev(struct pci_dev *dev)
>  static int __init ide_scan_pcibus(void)
>  {
>  	struct pci_dev *dev = NULL;
> -	struct pci_driver *d;
> -	struct list_head *l, *n;
> +	struct pci_driver *d, *tmp;
>  
>  	pre_init = 0;
>  	for_each_pci_dev(dev)
> @@ -101,9 +100,8 @@ static int __init ide_scan_pcibus(void)
>  	 *	are post init.
>  	 */
>  
> -	list_for_each_safe(l, n, &ide_pci_drivers) {
> -		list_del(l);
> -		d = list_entry(l, struct pci_driver, node);
> +	list_for_each_entry_safe(d, tmp, &ide_pci_drivers, node) {
> +		list_del(d->node);

Just in case this wasn't reported yet.

drivers/ide/ide-scan-pci.c: In function 'ide_scan_pcibus':
drivers/ide/ide-scan-pci.c:104:13: error: incompatible type for argument 1 of 'list_del'
  104 |   list_del(d->node);
      |            ~^~~~~~
      |             |
      |             struct list_head
In file included from include/linux/module.h:12,
                 from drivers/ide/ide-scan-pci.c:12:
include/linux/list.h:144:47: note: expected 'struct list_head *' but argument is of type 'struct list_head'
  144 | static inline void list_del(struct list_head *entry)

Guenter
