From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH RESEND] ata_piix: minor typo and a printk fix
Date: Fri, 27 Sep 2013 16:04:00 +0200
Message-ID: <52459050.5000001@linux.com>
References: <52458C14.8010308@linux.com> <20130927135348.GD3205@htj.dyndns.org>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:51013 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab3I0OEE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Sep 2013 10:04:04 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so1251611eaj.11
        for <linux-ide@vger.kernel.org>; Fri, 27 Sep 2013 07:04:02 -0700 (PDT)
In-Reply-To: <20130927135348.GD3205@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

2013-09-27 15:53 keltez=E9ssel, Tejun Heo =EDrta:
> char buf[32];
> 	char *p =3D buf, *end =3D buf + sizeof(buf);

Sorry, I am not that familiar with kernel API (yet),
I will resend in a minute.

--=20
Regards,
Levente Kurusa
