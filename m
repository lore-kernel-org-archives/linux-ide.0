From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH] ata: ahci: Enable enclosure management via LED (resend)
Date: Thu, 25 Oct 2007 09:35:14 +0200 (CEST)
Message-ID: <29046.145.64.134.222.1193297714.squirrel@www.hardeman.nu>
References: <20071024155845.5129d6a4.kristen.c.accardi@intel.com>
    <47203073.7090809@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761934AbXJYHff@vger.kernel.org>
In-Reply-To: <47203073.7090809@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, October 25, 2007 07:58, Jeff Garzik wrote:
> Kristen Carlson Accardi wrote:
>> Enable enclosure management via LED
>>
>> As described in the AHCI spec, some AHCI controllers may support
>> Enclosure management via a variety of protocols.  This patch
>> adds support for the LED message type that is specified in
>> AHCI 1.1 and higher.
>
> Comments:
=2E..
> 8) when is this actually used?  do you have a sample user in userspac=
e?
>   does a userspace daemon watch disk activity and manage LEDs somehow=
?
> I'm a bit cloudy on the usage need of this.

I think the idea is that if mdadm (for example) kicks out a faulty disk
from an array, it could also activate a LED (usually a different LED th=
an
the "disk activity" LED) on the corresponding enclosure so that the adm=
in
knows when standing in front of the storage server which disk to pull o=
ut
and replace.

--=20
David H=E4rdeman
