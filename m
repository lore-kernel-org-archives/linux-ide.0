Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCF1B85DA
	for <linux-ide@vger.kernel.org>; Fri,  6 Sep 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654697; cv=none; b=OR6g3w5huiy7g0Qhad5Zxj3L18JFZAzowN6VtzWLiteQXc7yhqecf52LmJCIIEKrBRMumPkbj67r4C7nQFTupR16aiPioLXyVchHpPl4aotUNa4xTcuLUjB5qZBJyTQx++XWujqg4vZlJ6IIw+lXtAVe9bZB21C0u8Sb7ro0/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654697; c=relaxed/simple;
	bh=rIpqLog38KokdxKY1NS1un6TJIeB2spEjZBYmUjzDyQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=L5+EPX2D46nRnsSD31XozLkfYpzyntKdg50zc8K4Ifs4c1CdQyh88TFX7egY/Bwq+cfdbSXNMEx5BUeox6mEzyuI0hULGEGTiDrmTgw7/R3W2m+YFz2VaPcYIpJfrsRKyEXvdOJJlwGCBPMKKHEjHD3TIBBQ0KBB/MpUaklgmwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRzGUmKN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRzGUmKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F06DC4CEC4;
	Fri,  6 Sep 2024 20:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725654697;
	bh=rIpqLog38KokdxKY1NS1un6TJIeB2spEjZBYmUjzDyQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=nRzGUmKN6WN5D1MRjqwgrPq+50fc9g+nivfoousC6Z3znGNOdE271ZIYuewgh3MeL
	 ArOansDS4XKaQJPmhkEdGFRg3mDf9p8AuroZqYHR5RUZVfVy/YuV6zxwPAGBxKxONK
	 QnhO97p7AhXSOg4HIwL4p1rJJNX6Gon+Va3QNkX0nWHt2AKbJGNm7XlMChd4itjK1c
	 SP/TZzJjziZnjFEvJEcOpmxUGKdWaQpdNdAeg9cosZgx65PfdqnFRzIdqlC5jL/6Ny
	 kXFO2ZzIehg5tr93X6chh+vBXvkXSBjf8HMWl4/zo1IUplRb4MvKtAKD2Ax8ujHXRo
	 B74kzYYnIUsmw==
Date: Fri, 06 Sep 2024 22:31:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
CC: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_ata=3A_libata=3A_Clear_DID=5FTIME=5FOU?=
 =?US-ASCII?Q?T_at_the_start_of_EH_instead_of_at_the_end?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZttMR5JjF71eQI1C@google.com>
References: <20240906142720.1977225-2-cassel@kernel.org> <ZttMR5JjF71eQI1C@google.com>
Message-ID: <76C02452-087C-452F-A567-EF23E93E0A18@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 6 September 2024 20:39:03 CEST, Igor Pylypiv <ipylypiv@google=2Ecom> wr=
ote:
>On Fri, Sep 06, 2024 at 04:27:21PM +0200, Niklas Cassel wrote:
>> When ata_qc_complete() schedules a command for EH using
>> ata_qc_schedule_eh(), blk_abort_request() will be called, which leads t=
o
>> req->q->mq_ops->timeout() / scsi_timeout() being called=2E
>>=20
>> scsi_timeout(), if the LLDD has no abort handler (libata has no abort
>> handler), will set host byte to DID_TIME_OUT, and then call
>> scsi_eh_scmd_add() to add the command to EH=2E
>>=20
>> Thus, when commands first enter libata's EH strategy_handler, all the
>> commands that have been added to EH will have DID_TIME_OUT set=2E
>>=20
>> libata has its own flag (AC_ERR_TIMEOUT), that it sets for commands tha=
t
>> have not received a completion at the time of entering EH=2E
>>=20
>> Thus, we don't really care about DID_TIME_OUT at all, and currently cle=
ar
>> the host byte at the end of EH, in ata_scsi_qc_complete(), before
>> scsi_eh_finish_cmd() is called=2E
>>=20
>> ata_scsi_qc_complete() will be called both for commands that are comple=
ted
>> normally (without going via EH), and for commands that went via EH=2E
>>=20
>> It seems more appropriate to clear DID_TIME_OUT at the start of EH inst=
ead
>> of at the end of EH=2E That way, someone dumping the host byte at the m=
iddle
>> of EH will not see DID_TIME_OUT as being set=2E No functional change
>> intended=2E
>>=20
>> This has the additional advantage that we will not needlessly clear the
>> host byte for commands that did not go via EH=2E
>>=20
>> Signed-off-by: Niklas Cassel <cassel@kernel=2Eorg>
>
>Thank you for coming up with this generic solution, Niklas!
>
>I tested the patch with sg_sat_read_gplog=2E Without the fix we can see t=
hat
>DID_TIME_OUT is being reported to user space=2E The issue is gone with th=
e fix
>applied=2E
>
>Without the fix:                                                         =
   =20
>----------------                                                         =
       =20
>$ sg_sat_read_gplog -a 30 -p 9 --dma -vv /dev/sda                        =
      =20
>open /dev/sda with flags=3D0x802                                         =
        =20
>Building ATA READ LOG DMA EXT command; la=3D0x1e, pn=3D0x9, this_count=3D=
1           =20
>    ATA pass-through(16) cdb: [85 0d 0e 00 00 00 01 00 1e 00 09 00 00 00 =
47 00]=20
>ATA pass-through(16): transport error: Host_status=3D0x03 [DID_TIME_OUT] =
        =20
>Driver_status=3D0x08 [DRIVER_SENSE]                        ^^^^^^^^^^^^  =
        =20
>                                                                         =
      =20
>ATA pass-through(16):                                                    =
      =20
>    Fixed format, current; Sense key: Illegal Request                    =
      =20
>    ASC=3D24, ASCQ=3D00 (hex)                                            =
          =20
>      Info fld=3D0x4530001 [72548353]                                    =
        =20
>     Raw sense data (in hex), sb_len=3D64                                =
        =20
>            f0 00 05 04 53 00 01 0a  80 1e 09 00 24 00 00 00             =
      =20
>            00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00             =
      =20
>            00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00             =
      =20
>            00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00             =
      =20
>                                                                         =
      =20
>ATA PASS-THROUGH (16) failed                                             =
      =20
>                                                                         =
      =20
>$ echo $?                                                                =
      =20
>99                                                                       =
      =20
>                                                                         =
      =20
>With the fix:                                                            =
     =20
>-------------                                                            =
     =20
>$ sg_sat_read_gplog -a 30 -p 9 --dma -vv /dev/sda                        =
      =20
>open /dev/sda with flags=3D0x802                                         =
        =20
>Building ATA READ LOG DMA EXT command; la=3D0x1e, pn=3D0x9, this_count=3D=
1           =20
>    ATA pass-through(16) cdb: [85 0d 0e 00 00 00 01 00 1e 00 09 00 00 00 =
47 00]=20
>ATA pass through:                                                        =
      =20
>Fixed format, current; Sense key: Illegal Request                        =
      =20
>ASC=3D24, ASCQ=3D00 (hex)                                                =
          =20
>  Info fld=3D0x4530001 [72548353]                                        =
        =20
>                                                                         =
      =20
>$ echo $?                                                                =
      =20
>5  =20
>
>
>Tested-by: Igor Pylypiv <ipylypiv@google=2Ecom>

Thank you for testing!

Since you point out that this is actually solving a real issue (for ATA PT=
 commands), we should add a Fixes-tag, and improve the commit message to me=
ntion that it fixes ATA PT commands=2E

Will send a V2 on Monday, with your Reported-by tag=2E

Have a nice weekend!

Kind regards,
Niklas
