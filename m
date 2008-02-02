From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI driver preferring nr_ports over port map
Date: Sat, 02 Feb 2008 17:16:59 +0900
Message-ID: <47A426FB.4090105@gmail.com>
References: <47A344DF.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:45863 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756872AbYBBIRH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 03:17:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so992914rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 02 Feb 2008 00:17:06 -0800 (PST)
In-Reply-To: <47A344DF.76E4.0078.0@novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Jan Beulich wrote:
> Jeff,
>=20
> while I realize that Intel's documentation may not be consistent with
> anything more generic (which I don't know where to look for), this
> current behavior seems to contradict what Intel documents for ESB2:
>=20
> "23.3.1.4 PI =E2=80=93 Ports Implemented Register (D31:F2)
> Address Offset: ABAR + 0Ch=E2=80=930Fh Attribute: R/WO, RO
> Default Value: 00000000h Size: 32 bits
>=20
> This register indicates which ports are exposed to the Intel=C2=AE
> 631xESB/632xESB I/O Controller Hub. It is loaded by platform BIOS. It
> indicates which ports that the device supports are available for
> software to use. For ports that are not available, software must not
> read or write to registers within that port."

nr_ports is preferred over port_map when they disagree which shouldn't
happen in the first place.  On some earlier ahcis, PI was cleared to
zero and lower nr_port number of ports should be used.  The reason why
nr_ports is preferred over PI comes from similar place.  Hardware/BIOSe=
n
are more likely to get PI wrong than nr_ports, so...

Do you have any real case where the above behavior causes problem?

--=20
tejun
