Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0963BB21
	for <linux-ide@vger.kernel.org>; Tue,  5 Nov 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820157; cv=none; b=UzxYyjOEkDC/lHzLQr3Us0CXfgd/hC5MJZUGwub0NnPbax3Co0DwhEVmvTV7frjdJ/TyEvg4AEhxpi0JJ//u67V1kqH3BhdlS8tj7lBs/tBhv5nB/xUXD0t4MRKMMMS0LgRZYPnfQFcB5wZftyCzllkrnp2FC8Yo6W3VwDfK0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820157; c=relaxed/simple;
	bh=J/Cn+gQJjs8O0udBl12rjA2zyfXqMWTlT/bnowID+gI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UsJpkJF173iB8ETNhsGHxMb5+BOeZwZxowFeQBWkBK7hzHIWSlkz7Wb/Caw2ScHuOvRv2laoLr1pkb9Qr5CT+8AsoA4YtZDIUHuHmvDqvhzEQW6S0Q2oHpGtQTAY2pHokLN3GA1kGz46nrzsWgIE4aWH4kWnWH4xu5iMPq/ogLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTVWkpuq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTVWkpuq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730820154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/Cn+gQJjs8O0udBl12rjA2zyfXqMWTlT/bnowID+gI=;
	b=LTVWkpuqIc+51qVixguPygZ+BIeUmsYxQBh7IgZ7h7WfCQei/a38ncGSsPt+KBIj9Bruli
	4PNevtZW2yazz7opaJY5Uy2UVF7i1WNI5a0W5BbbwBhZyAw9qTklXlISsHOabqwOlsoFdS
	qQaLARfObdTnONbvn63As3nIv+idyR4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-px3Iz5xANXuR-yjfUhcL9Q-1; Tue, 05 Nov 2024 10:22:33 -0500
X-MC-Unique: px3Iz5xANXuR-yjfUhcL9Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4316ac69e6dso38645785e9.0
        for <linux-ide@vger.kernel.org>; Tue, 05 Nov 2024 07:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730820152; x=1731424952;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/Cn+gQJjs8O0udBl12rjA2zyfXqMWTlT/bnowID+gI=;
        b=bsxv//rv5yEXITZMpu7QjIS+nReLLI0/Kq/VUbDGVYY2TUJ0KE0nFzdUmuaYat9882
         uA0sQQbzzWx6y98t63yzyf8CijkQ3xXsfj0dCk8pjPMNCqaT+8gJfcCI24S7/7L3BtlH
         TwtMk7VA2dzvE9tQOelJeNSwLd+apQZQcvhLsIIJd+4btOfLTr5h56owWIALMxD4qu1K
         qdhWuNt/V0VkfLaScEL5YDs3HkJnWeTWMRd+UMJlN4PONjkJquO12ni1fCCo6AskcfOE
         uEJzo1epcbO3ED3/J/bEUlxxTL7B/dBjyPwtW0WLgaPlHeptbFu8s0y872zw4m10qHtz
         fUTA==
X-Forwarded-Encrypted: i=1; AJvYcCVVX5oFasL/gBU4jT2bUQlg5D0Stc7UCCw7tqWVFn6xnXwtcgR4BXf1Zs2CC5Nz/tHXShZlvHoDWIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6RMcgrEl7/qSZ8iwinwUO58srBFougqqvSe8yX2AwMSEaEUTe
	naipW1hKUmcTGzyg6ADDqbyeZ8EinKP0TZqnKBPgnQzP4JHnY0RP4anwIAIHVVfgPj8pk/UZ73z
	dvjo4C7RfHvtreGX1YhcXnEQbUHl3P+zXha1dDcsK0HN8IVptImlaUzR1Z+HD3R4w7g==
X-Received: by 2002:a05:600c:46c8:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-4319acb17a9mr336934215e9.16.1730820152205;
        Tue, 05 Nov 2024 07:22:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESQ7aNdNMQ+yS9mWi/GMzoK5+gV12kGb+PXB2HlOt3GR7/1Mrt4xjaoBjofBs5I6bu5on/CA==
X-Received: by 2002:a05:600c:46c8:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-4319acb17a9mr336933935e9.16.1730820151632;
        Tue, 05 Nov 2024 07:22:31 -0800 (PST)
Received: from [10.32.64.16] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c38sm16466726f8f.24.2024.11.05.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:22:31 -0800 (PST)
Message-ID: <5e56bf9bd7b65ecbf1bdb0af8569c4548c335220.camel@redhat.com>
Subject: Re: [PATCH] ata: ahci: Don't call pci_intx() directly
From: Philipp Stanner <pstanner@redhat.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
 "linux-pci@vger.kernel.org"
	 <linux-pci@vger.kernel.org>
Date: Tue, 05 Nov 2024 16:22:30 +0100
In-Reply-To: <8acdd01c-1744-4545-9cc7-0a60e83a5d4d@gmail.com>
References: <c604a8ac-8025-4078-ab90-834d95872e31@gmail.com>
	 <ZyiGNtLMSY1vTQH7@ryzen> <8acdd01c-1744-4545-9cc7-0a60e83a5d4d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-04 at 14:23 +0100, Heiner Kallweit wrote:
> On 04.11.2024 09:30, Niklas Cassel wrote:
> > On Fri, Nov 01, 2024 at 11:38:53PM +0100, Heiner Kallweit wrote:
> > > pci_intx() should be called by PCI core and some virtualization
> > > code
> > > only. In PCI device drivers use the appropriate
> > > pci_alloc_irq_vectors()
> > > call.
> >=20
> > Hello Heiner,
> >=20
> > as you might or might not know, this patch conflicts with a
> > Philipp's
> > already acked patch:
> > https://lore.kernel.org/linux-ide/20241015185124.64726-10-pstanner@redh=
at.com/
> >=20
> I know, therefore he's on cc. Fully migrating PCI device drivers to
> the
> pci_alloc_irq_vectors() should be done anyway and is the cleaner
> alternative to changing pci_intx(). However for some drivers this is
> a rather
> complex task, therefore I understand Philipp's approach to adjust
> pci_intx()
> first. He's incorporating other review feedback in his series, so
> with the
> next re-spin he could remove the ahci patch from his series.

As I have stated before, this is not just about cleaning up pci_intx().

Again:
pci_alloc_irq_vectors() USES pci_intx(), and my series does address
that in its MSI patch.

If you want to help, a careful review of the MSI bits would be helpful.
Your patch here uses pci_intx(), you just don't see it anymore.

That said, in principle it's of course possible for me to drop patches
while we're still in review, but I tend to think that it's causing both
you and me more work if the pci_intx() vs. pci_alloc_irq_vectors() is
worked on out of all times right now.

It also causes more work load for the reviewers, since they'd have
reviewed my patch for nothing and would have to review yours then.

Also be aware that I am not yet sure whether the devres aspect should
also be removed or made more explicit in MSI. Take a look at
pcim_setup_msi_release().

In the worst case you might just replace one problem with another
before we figured it all out.

Regards,
P.

> >=20
> > Kind regards,
> > Niklas
>=20
> Heiner
>=20

