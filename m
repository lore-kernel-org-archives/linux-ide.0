From: "xerces8" <xerces8@butn.net>
Subject: Re: need advice: slow IO on eSATA WD MyBook compared with ext. ATA
	MyBook.
Date: Thu, 04 Sep 2008 10:50:17 +0200
Message-ID: <WorldClient-F200809041050.AA50170080@butn.net>
References: <48BEE9B2.6070100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ikar.perftech.si ([195.246.0.20]:48775 "EHLO ikar.perftech.si"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608AbYIDIuZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Sep 2008 04:50:25 -0400
Received: from dedal.perftech.si (unknown [10.12.0.44])
	by ikar.perftech.si (Spam Firewall) with ESMTP id D20541C60D1
	for <linux-ide@vger.kernel.org>; Thu,  4 Sep 2008 10:50:21 +0200 (CEST)
Received: from dedal.perftech.si ([10.12.0.44]) by ikar.perftech.si with ESMTP id 9RW6di7I3OVHp0ov for <linux-ide@vger.kernel.org>; Thu, 04 Sep 2008 10:50:21 +0200 (CEST)
Received: from WorldClient by butn.net (MDaemon PRO v9.6.4)
	with ESMTP id 17-md50000234400.msg
	for <linux-ide@vger.kernel.org>; Thu, 04 Sep 2008 10:50:21 +0200
In-Reply-To: <48BEE9B2.6070100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: andrew henry <adhenry.9@gmail.com>, linux-ide@vger.kernel.org

andrew henry wrote:

> I wonder if anyone has had experience with WD MyBook drives, where ol=
der
> ATA drives are faster than newer eSATA drives?

1.) The advice: get rid of WD MyBook Studio Edition
2.) they suck (I own one myself)
3.) they suck (google around... I can dig up some links if you want)
4.) You could use them over USB. I guess it is the only interface that
works reliably. I had sometimes below 10 MB/s transfers with Firewire.
5.) currently I use an exchanged drive. The first one never exceeded 40=
 MB/s
over eSATA.
6.) Just get rid of it ;-)

Some links:
 - "WD MyBook Studi doe snot work over eSATA with linux"
 http://bugzilla.kernel.org/show_bug.cgi?id=3D9913#c26

Regards,
David Bala=C5=BEic

PS: You get 38 MB/s write on WD 320GB over USB ? That is "rekordverd=C3=
=A4chtig"
as the Germans would say. (in english "recordsuspicious", I would empha=
size
the "suspicious" part myself.


