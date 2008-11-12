From: Tejun Heo <tj@kernel.org>
Subject: Re: [Frequent Head Unloads] ASUS A6B00U Notebook affected
Date: Wed, 12 Nov 2008 14:29:51 +0900
Message-ID: <491A69CF.3050308@kernel.org>
References: <490E7E44.2030206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56291 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbYKLF35 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Nov 2008 00:29:57 -0500
In-Reply-To: <490E7E44.2030206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBHb8WCxJliaW93c2tp?= <mgol86@gmail.com>
Cc: linux-ide@vger.kernel.org

Micha=C5=82 Go=C5=82=C4=99biowski wrote:
> Hello,
>=20
> My ASUS A6B00U notebook (in A6U series) is also affected by frequent
> head unloads, mentioned here:
> http://ata.wiki.kernel.org/index.php/Known_issues#Drives_which_perfor=
m_frequent_head_unloads_under_Linux
>=20
>=20
> I've applied the fix by adding to /etc/rc.local a line:
> hdparm -B 254 /dev/sda
> so if these affect attached logs, I can change it for a while and sen=
d
> them once more.

When idle, how much does the unload count increase per hour?

Thanks.

--=20
tejun
