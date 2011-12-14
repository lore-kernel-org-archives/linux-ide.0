From: =?ISO-8859-1?Q?Sebastian_Mu=F1iz?= <sjmuniz@gmail.com>
Subject: Re: PCIe SiI 3132 2xeSATA vs JMB393 6 PM
Date: Wed, 14 Dec 2011 08:34:17 -0300
Message-ID: <CAMBB+ZyOh-bHaxRff1nMDAezb1+uh_=HuPpCSnLjC+Qr061NKw@mail.gmail.com>
References: <CAMBB+Zxb3CHrv3JMJBvpq4nE5ZyrJbH0SviE2JPM=ADENaaifQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36185 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462Ab1LNLem convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Dec 2011 06:34:42 -0500
Received: by eekc4 with SMTP id c4so658854eek.19
        for <linux-ide@vger.kernel.org>; Wed, 14 Dec 2011 03:34:40 -0800 (PST)
In-Reply-To: <CAMBB+Zxb3CHrv3JMJBvpq4nE5ZyrJbH0SviE2JPM=ADENaaifQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello.
I have followed this up with Addonics. They sell the CPR5SA,
essentially the same as Lian Li EX-503 but with Addonics nice support.
(not sure about firmware differences though).
Addonics confirms NCQ should be available when configured as JBOD or
pass through, but no NCQ for RAID5

Regards,
Sebastian.


On Wed, Dec 7, 2011 at 6:47 PM, Sebastian Mu=F1iz <sjmuniz@gmail.com> w=
rote:
> Hello
> I am have connected a 5 disk box ultracheap Lian Li EX-503B to a
> server running XenServer 5.5.
> The box is configured as raid0 with two disks and the server has a
> PCIe Sil 3132.
> In this circumstances the server is unable to use NCQ.
>
> Is this expected, like a known issue between JMB393 against sil3132 ?
> I was hoping to put 5 x 2Tbytes disks on this box, configure raid5 an=
d
> be happy for once.



--=20

I've decided that the stuff falling through the cracks
is confetti and I'm having a party!=94
