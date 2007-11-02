From: Krzysztof Oledzki <olel@ans.pl>
Subject: Re: pata_serverworks hangs
Date: Fri, 2 Nov 2007 15:50:28 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711021546000.1316@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0711021415300.1316@bizon.gios.gov.pl>
 <472B2E58.6080508@garzik.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1855013654-1194015028=:1316"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bizon.gios.gov.pl ([212.244.124.8]:35622 "EHLO
	bizon.gios.gov.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbXKBOuk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 10:50:40 -0400
In-Reply-To: <472B2E58.6080508@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1855013654-1194015028=:1316
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Fri, 2 Nov 2007, Jeff Garzik wrote:

> Krzysztof Oledzki wrote:
>> Hello,
>>=20
>> I just tried to switch from old IDE to libata but unfortunately kernel=
=20
>> (2.6.22.10) hangs during boot:
>
> does 2.6.23.1 or 2.6.24-rc1 work?

Ah, I was afraid of this question. ;) This is a quite important server and=
=20
I am not ready to put there 2.6.23.1 and especially 2.6.24-rc1. However,=20
since you asked, I have no other solution than to boot it with=20
2.6.23.1/2.6.24-rc1, but with init=3D/bin/sh and see what happen.

Thanks.

Best regards,

 =09=09=09=09=09Krzysztof Ol=EAdzki
---187430788-1855013654-1194015028=:1316--
