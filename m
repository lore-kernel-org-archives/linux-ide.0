Received: from srv.wefi.net (srv.wefi.net [80.66.63.20])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A138640BEB
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.66.63.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880136; cv=none; b=QIALp/aLHpZqXxn+1Is8dpa2S2P6V1jgcOliSI0lTIuuSefGv3KdgJLhJ2HjxYGcIBQLTxCM+U95xFBk8+PISsnMzuXPqhXL2UtvcMONSSdcUpnxON8RxvBXXZez7XMOdMMWWlNMW8CqB+wiAJ8UEGlYpG/v6h+FX3+R9ouz3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880136; c=relaxed/simple;
	bh=e710RowVKMEpnTO81zmK18vRuyDqmIF/ag8e6xYvhTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CyRq09+tXlBNH4PjqKK0cSRMhOrN9GuleKiV1xUgk8/Nr55zNt+F0cRSxb6oeyg4HCY443QtnmMReeq1uXuhV/hgn79VUruyGkpv6w7P158RGHIpEMFU3EhKnxuEVUimtFT1XmTLg3qPHqflJeAlSrXLlQyvVe5HbIMJVvLhcEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wefi.net; spf=pass smtp.mailfrom=wefi.net; arc=none smtp.client-ip=80.66.63.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wefi.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wefi.net
Received: from [172.16.0.112] (unknown [91.223.201.37])
	by srv.wefi.net (Postfix) with ESMTPSA id 95E205A2B57;
	Fri,  2 Feb 2024 14:13:41 +0100 (CET)
Message-ID: <72f2bfb74b196267283fcee5233834146995595d.camel@wefi.net>
Subject: Re: [PATCH 0/5] drop low power policy board type
From: Werner Fischer <devlists@wefi.net>
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Daniel Drake <drake@endlessos.org>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Jian-Hong Pan <jhp@endlessos.org>,
 Dieter Mummenschanz <dmummenschanz@web.de>, linux-ide@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>
Date: Fri, 02 Feb 2024 14:13:35 +0100
In-Reply-To: <20240201161507.1147521-1-cassel@kernel.org>
References: <20240201161507.1147521-1-cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

(adding Mario Limonciello in CC)

On Thu, 2024-02-01 at 17:14 +0100, Niklas Cassel wrote:

> This revives a patch sent out almost two years ago from Mario
> Limonciello:
> https://lore.kernel.org/linux-ide/20220524170508.563-1-mario.limonciello@=
amd.com/T/#u
>=20
> The reason why we did not merge it back then, is because LPM and
> hotplug events are mutually exclusive.
>
> I've added a patch that checks if the port is external, i.e. either
> hotplug capable or eSATA. For external ports, we never enable LPM, as
> that will break hotplug.
>=20
> For ports that do not advertise themselves as external (typically
> laptops), we set the LPM policy as requested.
>
> This matches how Microsoft Windows does things.
> Thanks to Werner Fischer for suggesting something like this at last
> year's ALPSS conference.
Thank you for the discussions last year at the ALPSS and thanks a lot
for implementing this now.

> There might of course be some platform firmware that e.g. incorrectly
> marks its port as internal, even though it is external, but if we
> find any such platforms we will need to deal with them using quirks.
I plan some testing within the upcoming two weeks.
I'll do testing with the Elkhart-Lake based system (0x4b63 SATA
controller) to verify whether LPM is activated.
And I'll reach out to colleagues to test with hot-pluggable servers.
Especially I'll try for them to get a system with an AMD 0x7901 SATA
controller like Supermicro H12SSL-NT, as the default
"board_ahci_mobile" for this SATA controller - see commit 1527f69204fe
("ata: ahci: Add Green Sardine vendor ID as board_ahci_mobile") - lead
to Hot-Plug not working with default Ubuntu or Proxmox Kernels [1].

As especially for AMD systems identical SATA controllers (like 0x7901
in this case) can be used in both mobile systems and servers, Niklas'
new patch series could could bring lasting improvement here.

[1] https://www.thomas-krenn.com/en/wiki/AMD_EPYC_Server_with_Ubuntu_-_Enab=
le_SATA_Hot-Swap

--
Best regards,
Werner Fischer
