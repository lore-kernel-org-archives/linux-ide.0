Return-Path: <SRS0=iM+a=WI=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913E6C31E40
	for <linux-ide@archiver.kernel.org>; Mon, 12 Aug 2019 16:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE342064A
	for <linux-ide@archiver.kernel.org>; Mon, 12 Aug 2019 16:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vVStjjFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfHLQ3X (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:29:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39468 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfHLQ3W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Aug 2019 12:29:22 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so155128242otq.6
        for <linux-ide@vger.kernel.org>; Mon, 12 Aug 2019 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d4lYXmDHOGmwF8fFK172ERlHZWimaZARGHG48NSs+BE=;
        b=vVStjjFZzKHHoR5If3HPxFCjL9tzGRaRogaaSgPV4MNVY11rVkyQoSjizAh27jTjfZ
         1pyD7NmZWKenzz6UK8p3FF9OlFxdnPO1JD+77jsLBMLCqerKK+85TfznCSKZDfhQvjFg
         XfyAZPQLcm9b+GaA4BFgTShZp7+MSkuOLbaHm+WgZmCoFT9dLnBe7RFG4iKAjOECXaYy
         K8cy+SfiKa9WtcYeTMhRDKfwH3xodLoS4Ne5uyo+mjhpGBcMkJJBMxklD3FpSrXpXof8
         USAMRY+4lPAJVnPlbtJOpmQzGA9TcVuB7vE6eh2pFLDExyxbPlEwO3UpUwTJ0+mrVh8y
         VA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d4lYXmDHOGmwF8fFK172ERlHZWimaZARGHG48NSs+BE=;
        b=N+KVsxje9yGyZUzAfA9xXPy498BI0GqKYMVqI1f3T0X+0PDpjodn4B4J0M4ofz1WcZ
         zZ2hqIGzbwITI1nydPBhBhkbukqw2IthKjJqBVcTTmw4hbTGlSSoSNFkBTeWsy89NU06
         gWxk0NpucqEBzh9oNHphVywnTKFeeq6qLzondetfnqr3AZpOyva20xmr3Z8tu7NvK5TN
         82II83izpDksrLtPvodzRisq3o+GlFMKrl/SPSv3DpDvJOMfzUfoBRmKMTQmnCr7x33j
         AcSw2kzq8z9boI4VpvPXhyd7tuqjxgkSkppbpu7CIzqrdrRENZaJbdpzbphb/YeYkfVr
         9fBg==
X-Gm-Message-State: APjAAAX6owZ9oEflw8m4JnrrHiQdsPDBL5tlb9DD7+jHZtrWhXeKNS8w
        tYocmcaQCj9/nZz0C9y7SN1Pe2IJRk6Qqi2t5ncKhg==
X-Google-Smtp-Source: APXvYqzI4V3ncmY3z4r3B6bzu3j//xLeAjIzTzcGr9iwuASwGzNrJCVnKW/WeJcDNkN250CGp547ak5KHoqkBd4ZQN4=
X-Received: by 2002:a9d:5f13:: with SMTP id f19mr22428216oti.207.1565627361973;
 Mon, 12 Aug 2019 09:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20190810074317.GA18582@infradead.org> <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
In-Reply-To: <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 12 Aug 2019 09:29:11 -0700
Message-ID: <CAPcyv4g+PdbisZd8=FpB5QiR_FCA2OQ9EqEF9yMAN=XWTYXY1Q@mail.gmail.com>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device ID
To:     Stephen Douthit <stephend@silicom-usa.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Aug 12, 2019 at 6:03 AM Stephen Douthit
<stephend@silicom-usa.com> wrote:
>
> On 8/10/19 3:43 AM, Christoph Hellwig wrote:
> > On Thu, Aug 08, 2019 at 08:24:31PM +0000, Stephen Douthit wrote:
> >> Intel moved the PCS register from 0x92 to 0x94 on Denverton for some
> >> reason, so now we get to check the device ID before poking it on reset.
> >
> > And now you just match on the new IDs, which means we'll perpetually
> > catch up on any new device.  Dan, can you reach out inside Intel to
> > figure out if there is a way to find out the PCS register location
> > without the PCI ID check?
> >
> >
> >>   static int ahci_pci_reset_controller(struct ata_host *host)
> >>   {
> >>      struct pci_dev *pdev = to_pci_dev(host->dev);
> >> @@ -634,13 +669,14 @@ static int ahci_pci_reset_controller(struct ata_host *host)
> >>
> >>      if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> >>              struct ahci_host_priv *hpriv = host->private_data;
> >> +            int pcs = ahci_pcs_offset(host);
> >>              u16 tmp16;
> >>
> >>              /* configure PCS */
> >> -            pci_read_config_word(pdev, 0x92, &tmp16);
> >> +            pci_read_config_word(pdev, pcs, &tmp16);
> >>              if ((tmp16 & hpriv->port_map) != hpriv->port_map) {
> >> -                    tmp16 |= hpriv->port_map;
> >> -                    pci_write_config_word(pdev, 0x92, tmp16);
> >> +                    tmp16 |= hpriv->port_map & 0xff;
> >> +                    pci_write_config_word(pdev, pcs, tmp16);
> >>              }
> >>      }
> >
> > And Stephen, while you are at it, can you split this Intel-specific
> > quirk into a separate helper?
>
> I can do that.  I'll wait until we hear back from Dan if there's a
> better scheme than a device ID lookup.

Do you see any behavior change in practice with this patch? It's
purportedly to re-enable the ports after a reset, but that would only
be needed if the entire pci device reset. In this path the reset is
being performed via the host control register. That is only meant to
touch mmio registers, not config registers. So, as far as I can see
this register bit twiddling after reset has never been necessary.
