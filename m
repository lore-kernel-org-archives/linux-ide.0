From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Subject: Re: [patch] libata: add ioctls to support SMART
Date: Tue, 31 Aug 2004 10:47:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <41343B2A.80909@gmx.de>
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com> <41336824.1040206@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267528AbUHaIr5@vger.kernel.org>
In-Reply-To: <41336824.1040206@gmx.de>
Cc: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Prakash K. Cheemplavam wrote:
| John W. Linville wrote:
| | Support for HDIO_DRIVE_CMD and HDIO_DRIVE_TASK in libata.  Useful for
| | supporting SMART w/ unmodified smartctl and smartd userland binaries.
~ > I just tried to give it a go with libata from 2.6.9-rc1. I had to fix
| one rejects but the patching seemed to go fine beside that. Nevertheless
| after a boot with patched libata I get:
|
| smartctl -a /dev/sda
[snip]

| Device does not support SMART

Just wanted

Just wanted to say that smartctl -a -d ata /dev/sda works, as John
Linville and now Bruce aLlen suggested to try.

Cheers,

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBNDsqxU2n/+9+t5gRAinMAJ0W6sfKD4LV7uv6X9XUxWeng2dWjQCfVolo
CXg7ylDp8eb6SI+C4GZz/Bk=
=N/WZ
-----END PGP SIGNATURE-----
