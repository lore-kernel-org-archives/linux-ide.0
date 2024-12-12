Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C021576F
	for <linux-ide@vger.kernel.org>; Thu, 12 Dec 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015402; cv=none; b=bHuymvaJSP43ynvxKJWIWcZ0NWUl3fOjfRYzKLLyG8RqIkOPDFa3M2tClKFWn5ejALkglCSeFgUbxpuvcJbh4uPag/+C9GM5onb/TeqZJgZDdWJKJE18dYoqHIOSigDhQdZ3dszbdr9RxAZNZo+cbGfWS0x5Ze+HdegoYO9tF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015402; c=relaxed/simple;
	bh=AjQOAHstwlMlrDDeDDeSx0eAGZcKzvIvjK1+noRizkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6mY66Qwt3+NR1VUGkAonofE3E4eoKJpJEip6sAEYFCQXG2U8cyRmePu6EDG7Wmj1pHV07dcko0wnlO11+K4qycmi9Yx/qkY3tVyVuOqkXFYrB+uHmKs2bb3zRYejNjmu1kn28MgbFABSUzX5uBev5ugAFNNicNnNe0RzpDp65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8VES4Pj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8VES4Pj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734015400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oL7oDzf/iu+owBEyFgADY3KtJbecvvlrXRMt6TBS380=;
	b=Z8VES4Pj+BPL3rTWozqlBCnrxxAPRj/mVomiH5hVtP0GPAsYLNeKVMB+e2k2bVladsC6Li
	pQfKGJ7TVbdYsicCzPRBf2PCww0sWqv3DMGsQj4KSzU46zOt9u8GlZs3Akw9yPqhMO25M4
	BEYemcGBMxud0H1YdeMsvXpC4R8eLDw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-Z96xl5ygPSmQHpt6j6ygZw-1; Thu, 12 Dec 2024 09:56:38 -0500
X-MC-Unique: Z96xl5ygPSmQHpt6j6ygZw-1
X-Mimecast-MFC-AGG-ID: Z96xl5ygPSmQHpt6j6ygZw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-436289a570eso1504625e9.0
        for <linux-ide@vger.kernel.org>; Thu, 12 Dec 2024 06:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734015397; x=1734620197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oL7oDzf/iu+owBEyFgADY3KtJbecvvlrXRMt6TBS380=;
        b=I27MMs2RUk0Ls52v2xLPrJ8nq/v31nFjEcRLr3AjKcfemi9SZ6ztvz465e0O0XzNre
         lcqIuMXjA8obeF3IZ1tAPuszyYlPSr/U79pAYm2REClvmHSoX+959UmNcR6X1USB1kFZ
         h3bapOZyvUfGLFIWDhxn/Sreg5YA3MUJyxlV6j09DWaj2U5w37Fcqo1a7nVQUo2vh/+h
         q59XvY5ZseA5AKJE1SKQnaj+ZQNRQ5kLsixiPw1jXCvWI14fPo87L7hBm7rFXeG4tgTz
         w2jxQTWw6TKSXfj+gNOdqD4tXsU5YSugzt+d3t/JLzu/Ab/vFisObj6lzvNmkW6RYIwf
         LAsA==
X-Gm-Message-State: AOJu0YwBjei1H/p3fd2HhZa6aTiIMgiXRvDdNMAgu4P+EelPHvmDThu1
	Msw0eqlIumilCoOcu0efUbmD2klNMEnG4rflGT+u3RjTn/p7P6NdLcYD0uZ2RZJC371qUpswZGC
	q0wLsZ96nTZdHgYzWqln9DAvQYZw3zm7DhDwzS66rjmfiO6xcR6aXFE3xeg==
X-Gm-Gg: ASbGncsQEp4wf7yT1E/meYNNQsjymjlkAxzL7coKGb66eyNErllhTUXM0KFGCHIWMR6
	Jmwk0WnTiJUGFnJZgyC86AoAkBmi58JZWbsHlHyJLg4u06/YN52qCi7kNq1L3SxCtVX10Tt21AG
	wr5AqCNfXTgpl4uhU9PVCRY0OCJC07dTtj+xh8NX4iNXZEkr1yn8XGk2lef5f8ykQlr6fclG/kY
	c40A6KjF5oY3aUzi/1A4BPeBEg+yVKgi+OsmQ2jPp240eB11XSkvs+sfT6Jk7CVqO9PURGmlLUG
	wtw0r+s=
X-Received: by 2002:a05:600c:34cc:b0:434:fbe2:4f with SMTP id 5b1f17b1804b1-4361c430b5cmr63302955e9.23.1734015397031;
        Thu, 12 Dec 2024 06:56:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6jT4MvcNP0dxPJ6BKwDHdX4PrfqhYHXR4TAbgRNM6khL6oXpHiVnh7UfEpSYX/vLofOsSxA==
X-Received: by 2002:a05:600c:34cc:b0:434:fbe2:4f with SMTP id 5b1f17b1804b1-4361c430b5cmr63302405e9.23.1734015396688;
        Thu, 12 Dec 2024 06:56:36 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c457sm19247805e9.15.2024.12.12.06.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 06:56:36 -0800 (PST)
Message-ID: <8ee0cf91-c215-4015-90fc-32be6f22b7db@redhat.com>
Date: Thu, 12 Dec 2024 15:56:32 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] net/ethernet: Use never-managed version of
 pci_intx()
To: Philipp Stanner <pstanner@redhat.com>, amien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Dubov
 <oakad@yahoo.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rasesh Mody <rmody@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Sanjay R Mehta <sanju.mehta@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Alex Williamson <alex.williamson@redhat.com>, Juergen Gross
 <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Chen Ni <nichen@iscas.ac.cn>,
 Ricky Wu <ricky_wu@realtek.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Breno Leitao <leitao@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
 Kevin Tian <kevin.tian@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yi Liu <yi.l.liu@intel.com>, Kunwu Chan <chentao@kylinos.cn>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20241209130632.132074-2-pstanner@redhat.com>
 <20241209130632.132074-5-pstanner@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241209130632.132074-5-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 14:06, Philipp Stanner wrote:
> pci_intx() is a hybrid function which can sometimes be managed through
> devres. To remove this hybrid nature from pci_intx(), it is necessary to
> port users to either an always-managed or a never-managed version.
> 
> broadcom/bnx2x and brocade/bna enable their PCI-Device with
> pci_enable_device(). Thus, they need the never-managed version.
> 
> Replace pci_intx() with pci_intx_unmanaged().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>

