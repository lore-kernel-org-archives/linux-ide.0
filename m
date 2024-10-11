Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987B218D80
	for <linux-ide@vger.kernel.org>; Fri, 11 Oct 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648478; cv=none; b=uaptHXKyrpuM6Kh9btxmBlpH9ny8XBcKD8wmajJ1FIn0XNfp6MvB4AGP1xncwMLSc2AH3ACOtp1RSfcAACQmzaRPXV9oHKgSTU5693E/I0yyos34XZ2cAznSgSKubAtq3o7HWiVvW9n8ASB7EZ3tuFrS2m9lDgL+6AnDErbON78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648478; c=relaxed/simple;
	bh=MwKBr4MW13REKEdZEAqTL7D+rRGFsGjM7n9xGoHUCEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VZwAwHCv4lYG/Mt5QBxiHTeewl5SNHdaI6mnyxXo3Q70DRgPKaNvNyR70DXp/uyzLK6a0Vy5m7lKw1RbJo1urVuAwJKlxt72aadelEJtedBK/RAPNbvYfM+47HfW7eJ5smBOWx15I4fFr68ciI+fQlL7nJPHZ2XDndVfRRf7ABU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LyAC5Pmw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyAC5Pmw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728648475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwKBr4MW13REKEdZEAqTL7D+rRGFsGjM7n9xGoHUCEw=;
	b=LyAC5Pmw3syzJenHzvdqCObXZtgZ/Fp6azkWcy0NIy5N36U+PNgK8BDipIwSfeBrRBgzlT
	4UTbnZJrWHTtPsvqO9hubsFwWp9uTcwOw2GBes5dhB4oeJRqYRF49UShG2ufKBHU/fzp4t
	DmouwrSVJiL36FnVsxmAD2fLhuCjefQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-RjZ5hC31OsqUAdZTerzDXQ-1; Fri, 11 Oct 2024 08:07:53 -0400
X-MC-Unique: RjZ5hC31OsqUAdZTerzDXQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4311c681dfcso6080005e9.2
        for <linux-ide@vger.kernel.org>; Fri, 11 Oct 2024 05:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728648472; x=1729253272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MwKBr4MW13REKEdZEAqTL7D+rRGFsGjM7n9xGoHUCEw=;
        b=f2jymU1RY1GUH5Hfr7po8jmgdtT0tXfPGF0XqreAb6bFNPS64vQwdTIzQ++WebkYUd
         KAH3gnreJ7YjJ7nk5CCLyF6cpiWSv0hoY9qhvaylDof0zXItqy6vGl7+bHT67GQgHICd
         M7LRwvbr7nkVTUFsQpSPcN7bWCzNLDcfss2sZoiuU0hrhpU+SgizhgBISEZvrPzRJgl0
         H7Z+TNhRcs7/JwnEO2jxnITVHBwf90/MIry9RBjiqmeP4RwxZq5E8TNllpOhJx51WG5p
         svFWbRs5704bG+r4XV5Hq+cMoxtgoxnG7tmBdwmujarsP1UbZpqFmk9UJi4moraJIrVq
         a1NA==
X-Forwarded-Encrypted: i=1; AJvYcCWGiK24B5tai3HIFmgUByVODTLtGVebEhq1pdesgkOUgKkpIc65OQJlVgBHQ9+20Cus7N00KVAx37A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQr/+5z6rni4X92ewC06w37sZW3hKKwq/RWP4dqaxwwLfjXCJ
	eGMwUWS6jEtb/KeRNlToriigOOYv6Bthjz/zi8VFTUbd1mvote52iqA2adINAROjo2er2vUHtjU
	rpYwfFzSifcuHaloNY9ssZyRrD90YgMNIryEyNK8QtsJcxdBGAlQsvdTxNg==
X-Received: by 2002:a05:600c:1d26:b0:42f:75cd:2566 with SMTP id 5b1f17b1804b1-4311deaea05mr17632085e9.2.1728648472021;
        Fri, 11 Oct 2024 05:07:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfafWJbYY7XgafIoUBODjA0mqAG0Im27BYfV9oETn5/NEqgGUi/qx3b+BLDWe06kqudkM50g==
X-Received: by 2002:a05:600c:1d26:b0:42f:75cd:2566 with SMTP id 5b1f17b1804b1-4311deaea05mr17631395e9.2.1728648471511;
        Fri, 11 Oct 2024 05:07:51 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d05:4700:3e59:7d70:cabd:144b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d7929sm40692135e9.4.2024.10.11.05.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 05:07:50 -0700 (PDT)
Message-ID: <a688a4109e292d7510ebd7206bd3296e23ca1e3b.camel@redhat.com>
Subject: Re: [RFC PATCH 13/13] Remove devres from pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Sergey Shtylyov
 <s.shtylyov@omp.ru>, Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Dubov <oakad@yahoo.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasesh Mody
 <rmody@marvell.com>,  GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko
 <imitsyanko@quantenna.com>,  Sergey Matyukevich <geomatsi@gmail.com>, Kalle
 Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar
 S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, Chen
 Ni <nichen@iscas.ac.cn>, Ricky Wu <ricky_wu@realtek.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, Kevin Tian
 <kevin.tian@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Mostafa Saleh
 <smostafa@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Soumya Negi <soumya.negi97@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yi
 Liu <yi.l.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Christian Brauner <brauner@kernel.org>, Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>, Marek
 =?ISO-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>,  Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>, Rui Salvaterra <rsalvaterra@gmail.com>,
 Marc Zyngier <maz@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-input@vger.kernel.org,
 netdev@vger.kernel.org,  linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-staging@lists.linux.dev, kvm@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Date: Fri, 11 Oct 2024 14:07:48 +0200
In-Reply-To: <20241010114314.296db535.alex.williamson@redhat.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
	 <20241009083519.10088-14-pstanner@redhat.com>
	 <7f624c83-115b-4045-b068-0813a18c8200@stanley.mountain>
	 <f42bb5de4c9aca307a3431dd15ace4c9cade1cb9.camel@redhat.com>
	 <20241010114314.296db535.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-10 at 11:43 -0600, Alex Williamson wrote:
> On Thu, 10 Oct 2024 11:11:36 +0200
> Philipp Stanner <pstanner@redhat.com> wrote:
>=20
> > On Thu, 2024-10-10 at 11:50 +0300, Dan Carpenter wrote:
> > > On Wed, Oct 09, 2024 at 10:35:19AM +0200, Philipp Stanner wrote:=C2=
=A0
> > > > pci_intx() is a hybrid function which can sometimes be managed
> > > > through
> > > > devres. This hybrid nature is undesirable.
> > > >=20
> > > > Since all users of pci_intx() have by now been ported either to
> > > > always-managed pcim_intx() or never-managed
> > > > pci_intx_unmanaged(),
> > > > the
> > > > devres functionality can be removed from pci_intx().
> > > >=20
> > > > Consequently, pci_intx_unmanaged() is now redundant, because
> > > > pci_intx()
> > > > itself is now unmanaged.
> > > >=20
> > > > Remove the devres functionality from pci_intx(). Remove
> > > > pci_intx_unmanaged().
> > > > Have all users of pci_intx_unmanaged() call pci_intx().
> > > >=20
> > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>=C2=A0=20
> > >=20
> > > I don't like when we change a function like this but it still
> > > compiles fine.
> > > If someone is working on a driver and hasn't pushed it yet, then
> > > it's
> > > probably
> > > supposed to be using the new pcim_intx() but they won't discover
> > > that
> > > until they
> > > detect the leaks at runtime.=C2=A0=20
> >=20
> > There wouldn't be any *leaks*, it's just that the INTx state would
> > not
> > automatically be restored. BTW the official documentation in its
> > current state does not hint at pci_intx() doing anything
> > automatically,
> > but rather actively marks it as deprecated.
> >=20
> > But you are right that a hypothetical new driver and OOT drivers
> > could
> > experience bugs through this change.
> >=20
> > >=20
> > > Why not leave the pci_intx_unmanaged() name.=C2=A0 It's ugly and that
> > > will
> > > discorage
> > > people from introducing new uses.=C2=A0=20
> >=20
> > I'd be OK with that. Then we'd have to remove pci_intx() as it has
> > new
> > users anymore.
> >=20
> > Either way should be fine and keep the behavior for existing
> > drivers
> > identical.
> >=20
> > I think Bjorn should express a preference
>=20
> FWIW, I think pcim_intx() and pci_intx() align better to our naming
> convention for devres interfaces.

Yup, also my personal preference. But we can mark those functions as
deprecated via docstring-comment. That should fullfill Damien's goal.

> =C2=A0 Would it be sufficient if pci_intx()
> triggered a WARN_ON if called for a pci_is_managed() device?

No, I don't think that's a good idea; reason being that
pci_is_managed() just checks that global boolean which we inherited
from the old implementation and which should not be necessary with
proper devres.
The boolean is used for making functions such as pci_intx() and
__pci_request_region() hybrid. So with our non-hybrid version we never
need it.

P.

> =C2=A0 Thanks,
>=20
> Alex
>=20

