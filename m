From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: SATA disks disabled on boot
Date: Thu, 04 Dec 2014 18:59:07 -0500
Message-ID: <5480F54B.9070306@ubuntu.com>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com> <20140714163641.GF31610@htj.dyndns.org> <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com> <20140817133942.GD7679@mtj.dyndns.org> <CADqA9ubrD1+Ri9d080X4xjrr7wsjqGGz5fjTC45QHjr4Fb1QJg@mail.gmail.com> <CADqA9uaj0MrpffnzE8xnhU57Hx9pv7O1sAhB+xS_4hi8z_dkMA@mail.gmail.com> <20141202195653.GQ10918@htj.dyndns.org> <547E4817.8000603@eu.ipp.pt> <20141204174819.GC2995@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:44852 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754811AbaLDX7L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2014 18:59:11 -0500
In-Reply-To: <20141204174819.GC2995@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, =?windows-1252?Q?Nuno_Magalh=E3es?= <nunomagalhaes@eu.ipp.pt>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Looks a lot like a drive that has Power Up In Standby enabled; on
power up they don't know what to report for many of the fields until
the media has been read.

On 12/04/2014 12:48 PM, Tejun Heo wrote:
> But the drive sometimes reports the following.
> 
> 00000000: 427a 3fff c837 0010 0000 0000 003f 0000
> zB.?7.......?... 00000010: 0000 0000 2020 2020 2057 442d 5743 4334
> ....    W -DCW4C 00000020: 4a32 3030 3136 3731 0000 0000 0000 3031
> 2J006117......10 00000030: 2e30 3141 3031 5744 4320 5744 3130 4546
> 0.A110DW CDW01FE 00000040: 5258 2d36 3850 4a43 4e30 2020 2020 2020
> XR6-P8CJ0N 00000050: 2020 2020 2020 2020 2020 2020 2020 8010
> .. 00000060: 4000 2f00 4001 0000 0000 0007 3fff 0010
> .@./.@.......?.. 00000070: 003f fc10 00fb 0101 ffff 0fff 0000 0007
> ?............... 00000080: 0003 0078 0078 0078 0078 0000 0000 0000
> ..x.x.x.x....... 00000090: 0000 0000 0000 001f 9f0e 0004 004c 0040
> ............L.@. 000000a0: 03fe 0000 746b 7d61 6733 7469 bc41 6723
> ....kta}3gitA.#g 000000b0: 407f 0048 0048 0000 fffe 0000 0000 0008
> .@H.H........... 000000c0: 0000 0000 86a0 0001 6db0 7470 0000 0000
> .........mpt.... 000000d0: 0000 0000 6003 0000 5001 4ee2 5f03 f57d
> .....`...P.N._}. 000000e0: 0000 0000 0000 0000 0000 0000 0000 401c
> ...............@ 000000f0: 401c 0000 0000 0000 0000 0000 0000 0000
> .@.............. 00000100: 0021 0400 0001 0000 0000 0000 0000 0000
> !............... 00000110: 0000 0000 0000 0000 0000 0000 0004 0000
> ................ 00000120: 0000 0000 0000 0000 0000 0000 0000 0000
> ................ 00000130: 0000 0000 0000 0000 0000 0000 0000 0000
> ................ 00000140: 0000 0000 0000 0000 0000 0000 0000 0000
> ................ 00000150: 0000 0000 0000 0000 0000 0000 0000 0000
> ................ 00000160: 0000 0000 0000 0000 0000 0000 0000 0000
> ................ 00000170: 0000 0000 0000 0000 0000 0000 0000 0000
> ................ 00000180: 0000 0000 0000 0000 0000 0000 0000 0000
> ................ 00000190: 0000 0000 0000 0000 0000 0000 0000 0000
> ................ 000001a0: 0000 0000 0000 0000 0000 0000 0000 0000
> ................ 000001b0: 0000 0000 0000 0000 0000 0000 0000 0000
> ................ 000001c0: 0000 0000 0000 0000 0000 0000 0000 0000
> ................ 000001d0: 0000 0000 0000 0000 0000 0000 0000 0000
> ................ 000001e0: 0000 0000 0000 0000 0000 0000 0000 0000
> ................ 000001f0: 0000 0000 0000 0000 0000 0000 0000 0000
> ................
> 
> I have no idea why it's doing that yet.  Weird... I'll ask around.
> 
> Thanks.
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJUgPVLAAoJENRVrw2cjl5RPQkH/j0Yx2wJXUxVOaPHQPjcY/0D
UEaO0ebswzT+ytjxS7D5TBh18kG42HcRtLHrDLnPKGrTYfbHE2+e9Z7h+u4/nuNG
YkvmCANzQ0coHHC5IQNbhaeyUrRQ7KHHp6IwB+1IKW4Vfdbjf1GxGC9HPCmd4Ixb
Fb+d3/ev3AFN9tusiEv6wFiyq2knbYbnbh1rP7qXsXE7oxspeysOL3TKhH/trfMX
Xo0pBzCFOtt0rQjSj9v/3eYdDNsVx+4LlU45YQVTxXP8padbeCZDWE5D16Xd1KPt
3okRm8FvhWpqAu994I6Vgttt1ydYd9MiOCkX5VcTVe+9qr/RPH7SjhXecOdGEUw=
=CKYh
-----END PGP SIGNATURE-----
