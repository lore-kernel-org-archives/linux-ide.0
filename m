From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: AHCI driver preferring nr_ports over port map
Date: Mon, 04 Feb 2008 13:10:01 +0000
Message-ID: <47A70EA90200007800045D32@public.id2-vpn.continvity.gns.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:36703
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752083AbYBDNKJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 08:10:09 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

>>> Tejun Heo <htejun@gmail.com> 02/02/08 9:16 AM >>>
>Jan Beulich wrote:
>> Jeff,
>>=20
>> while I realize that Intel's documentation may not be consistent wit=
h
>> anything more generic (which I don't know where to look for), this
>> current behavior seems to contradict what Intel documents for ESB2:
>>=20
>> "23.3.1.4 PI =E2=80=93 Ports Implemented Register (D31:F2)
>> Address Offset: ABAR + 0Ch=E2=80=930Fh Attribute: R/WO, RO
>> Default Value: 00000000h Size: 32 bits
>>=20
>> This register indicates which ports are exposed to the Intel=C2=AE
>> 631xESB/632xESB I/O Controller Hub. It is loaded by platform BIOS. I=
t
>> indicates which ports that the device supports are available for
>> software to use. For ports that are not available, software must not
>> read or write to registers within that port."
>
>nr_ports is preferred over port_map when they disagree which shouldn't
>happen in the first place.  On some earlier ahcis, PI was cleared to
>zero and lower nr_port number of ports should be used.  The reason why
>nr_ports is preferred over PI comes from similar place.  Hardware/BIOS=
en
>are more likely to get PI wrong than nr_ports, so...
>
>Do you have any real case where the above behavior causes problem?

It's not strictly a problem (i.e. nothing really mis-behaves), but it m=
ade
me wonder why the box I saw this on gets 6 ahci device instances set
up when spec as well as port map say there ought to be only 5. After
looking at the ESB2 spec it seemed that behavior was clearly violating
the spec: "For ports that are not available, software must not read or
write to registers within that port.", which contradicts status being
displayed for (and therefore status being read) from the 6th (not
present) port.

Jan
