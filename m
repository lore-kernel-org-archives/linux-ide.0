From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Subject: Re: [patch] libata: add ioctls to support SMART
Date: Tue, 31 Aug 2004 10:59:00 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41343DD4.8000302@gmx.de>
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com> <41336824.1040206@gmx.de> <41343B2A.80909@gmx.de> <41343C66.3080804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:44956 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267540AbUHaI7C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Aug 2004 04:59:02 -0400
In-Reply-To: <41343C66.3080804@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik wrote:
| Prakash K. Cheemplavam wrote:
|> Just wanted to say that smartctl -a -d ata /dev/sda works, as John
|> Linville and now Bruce aLlen suggested to try.
|
| As I noted in another email, be careful...  that patch bypasses the SCSI
| command synchronization, so you could potentially send a SMART command
| to the hardware while another command is still in progress.

Yup, I read your warning, so I won't run a background monitor. In fact
jusr gave it a quick try and saw all is fine and then I am not going to
touch it for now. ;-)

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBND3UxU2n/+9+t5gRAl9qAKDzA+TNzFDAwpV+JSSHbrLf8EVZFQCg85Ad
b8mJa7ZBgt13V/sT2MRVeiI=
=haAQ
-----END PGP SIGNATURE-----
