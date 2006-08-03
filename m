From: Roger Oberholtzer <roger@opq.se>
Subject: Re: libata question
Date: Thu, 03 Aug 2006 10:49:57 +0200
Message-ID: <1154594997.25611.111.camel@acme>
References: <1154445491.18593.111.camel@acme>  <44CF7447.300@gmail.com>
	 <1154457583.4665.5.camel@shark.pacific>  <44CFA15C.8080109@gmail.com>
	 <1154458981.4665.9.camel@shark.pacific>  <44CFA618.2090204@gmail.com>
	 <1154502301.5691.23.camel@acme>  <44D0522E.6030905@gmail.com>
	 <1154529340.25611.75.camel@acme>  <44D0BE99.8010809@gmail.com>
	 <1154589962.25611.102.camel@acme>  <44D1ACA1.2040809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [62.209.160.46] ([62.209.160.46]:33979 "EHLO stockholm.opq.se")
	by vger.kernel.org with ESMTP id S932402AbWHCIuC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Aug 2006 04:50:02 -0400
In-Reply-To: <44D1ACA1.2040809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Thu, 2006-08-03 at 16:58 +0900, Tejun Heo wrote:

> I don't know your usage model but my recommendation is...
>=20
> * If you're gonna do a lot of hotplugging, just get a sil3114 or 3124=
,=20
> they're cheap and hotplug works well on those controllers.

I am considering this. Now to find who sells these in Sweden...

>=20
> * If you're gonna stick with ata_piix, find a way to exactly find whi=
ch=20
> device is removed or issue scan after attaching new device.
>=20
--=20
Roger Oberholtzer

OPQ Systems AB
Ramb=C3=B6ll Sverige AB
Kapellgr=C3=A4nd 7
P.O. Box 4205
SE-102 65 Stockholm, Sweden

Tel: Int +46 8-615 60 20
=46ax: Int +46 8-31 42 23

