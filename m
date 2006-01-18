From: =?ISO-8859-1?Q?Mathieu_B=E9rard?= <Mathieu.Berard@crans.org>
Subject: Re: [PATCH 1/3] libata-acpi:more debugging
Date: Wed, 18 Jan 2006 17:54:40 +0100
Message-ID: <43CE72D0.4070000@crans.org>
References: <43C948D1.9010007@crans.org> <20060117121348.2f40e672.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx-a.polytechnique.fr ([129.104.30.14]:40644 "EHLO
	mx-a.polytechnique.fr") by vger.kernel.org with ESMTP
	id S1751332AbWARQz0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jan 2006 11:55:26 -0500
In-Reply-To: <20060117121348.2f40e672.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm <akpm@osdl.org>

Randy Dunlap a =E9crit :

>On Sat, 14 Jan 2006 19:54:09 +0100
>Mathieu B=E9rard <Mathieu.Berard@crans.org> wrote:
>
> =20
>
>>Hi,
>>2.6.15-mm4 crash on boot when loading the ata_piix or the ahci module=
=2E
>>Reverting the libata ACPI support patches workaround this bug.
>>
>>(Please CC me)
>>   =20
>>
>
>Hi,
>This series of 3 patches to 2.6.15-mm4 fixes it for me.
>Thanks,
>
> =20
>
Hi,
I've just tested 2.6.16-rc1-mm1 which includes these three patches.
The oops is actually fixed, furthermore, both suspend-to-disk and
suspend-to-ram are now basically working on my Toshiba M70.
(this laptop was previously locking on resume due to its SATA disk)
Many thanks.

