Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED61607A4
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753258; cv=none; b=qHqk02rJSfKOd0w9hcaEvvOb/zU/wuJ+9Ztd1v0hwenvOI6z9ZusBPSOFrYpQLhUYM0O3aYPaa8OZYKQlRvOQ+iozjI8RlWUjnmMB3mVb2J3Zo8qpn/lmHcRbEhkiyeq5r3en6KvFsQbg+qJtvnxszLwjShg/WqKm+gZM/XOXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753258; c=relaxed/simple;
	bh=OLwYtiIM3svTUxbtzQJfigop4Jk7waacerwP1JICezg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rhdBRBhuDERVA6Hf0Bqr7pIDEDoklZ8G+S5Qkx6llaZU5W/J3ZEOx6hDHr4/EEx67EBc0DDNik5i4SReK7zh4ntxn3KMCdgIUR+/z+bKK2M6sS/o1Qm2qYDh2VKfCLdDIucLu5Qso6AtYrLEXZHP5eNSJN+KZ9GtLsOtzmATi2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdXK350r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdXK350r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8316AC116C6;
	Thu,  5 Mar 2026 23:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753258;
	bh=OLwYtiIM3svTUxbtzQJfigop4Jk7waacerwP1JICezg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=NdXK350rVV075gPQz0VoSiwGXXVyeweUPbvHCHwK8XR2ihvLW+8UkEx4NEKw3mHXK
	 eF64CQCKzYaam7xosthg+OxtWu78avdc+CYNqn/7wRCMYr8VMmuLbeBj0mVN9ucaU1
	 ULn0/AL8naVPqK8vrSz4ljwu0oWxMhtybePAI/7VvXiBCNFQh5ZgelVAOjoEGp2ziM
	 VdA9e1y+N+ov/kP/6nUzo4fhvbq9BOVGEPnBYvRK2MuhmfKaTuvSa4/a1f7TS627uP
	 3Sj76Y4BWGgltWvtGr4KWe9GdQIbC5pGE+WVCLw23YUTXhzkDiOU8kHxnACPkfby3W
	 6omuY5Y6PuNDg==
Date: Fri, 06 Mar 2026 00:27:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, Damien Le Moal <dlemoal@kernel.org>
CC: linux-ide@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_ata=3A_libata-eh=3A_c?=
 =?US-ASCII?Q?orrectly_handle_deferred_qc_timeouts?=
User-Agent: Thunderbird for Android
In-Reply-To: <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
References: <20260220221439.533771-1-dlemoal@kernel.org> <20260220221439.533771-2-dlemoal@kernel.org> <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
Message-ID: <CFD23A2E-145E-4901-9160-72A91A5C3A9E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5 March 2026 18:59:08 CET, Guenter Roeck <linux@roeck-us=2Enet> wrote:
>Hi,
>
>On Sat, Feb 21, 2026 at 07:14:38AM +0900, Damien Le Moal wrote:
>> A deferred qc may timeout while waiting for the device queue to drain
>> to be submitted=2E In such case, since the qc is not active,
>> ata_scsi_cmd_error_handler() ends up calling scsi_eh_finish_cmd(),
>> which frees the qc=2E But as the port deferred_qc field still reference=
s
>> this finished/freed qc, the deferred qc work may eventually attempt to
>> call ata_qc_issue() against this invalid qc, leading to errors such as
>> reported by UBSAN (syzbot run):
>>=20
>> UBSAN: shift-out-of-bounds in drivers/ata/libata-core=2Ec:5166:24
>> shift exponent 4210818301 is too large for 64-bit type 'long long unsig=
ned int'
>> =2E=2E=2E
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack=2Ec:94 [inline]
>>  dump_stack_lvl+0x100/0x190 lib/dump_stack=2Ec:120
>>  ubsan_epilogue+0xa/0x30 lib/ubsan=2Ec:233
>>  __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan=2Ec:494
>>  ata_qc_issue=2Ecold+0x38/0x9f drivers/ata/libata-core=2Ec:5166
>>  ata_scsi_deferred_qc_work+0x154/0x1f0 drivers/ata/libata-scsi=2Ec:1679
>>  process_one_work+0x9d7/0x1920 kernel/workqueue=2Ec:3275
>>  process_scheduled_works kernel/workqueue=2Ec:3358 [inline]
>>  worker_thread+0x5da/0xe40 kernel/workqueue=2Ec:3439
>>  kthread+0x370/0x450 kernel/kthread=2Ec:467
>>  ret_from_fork+0x754/0xd80 arch/x86/kernel/process=2Ec:158
>>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64=2ES:245
>>  </TASK>
>>=20
>> Fix this by checking if the qc of a timed out SCSI command is a deferre=
d
>> one, and in such case, clear the port deferred_qc field and finish the
>> SCSI command with DID_TIME_OUT=2E
>>=20
>> Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller=2Eappspotmail=2Ecom
>> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvatio=
n")
>> Signed-off-by: Damien Le Moal <dlemoal@kernel=2Eorg>
>> Reviewed-by: Hannes Reinecke <hare@suse=2Ede>
>> Reviewed-by: Igor Pylypiv <ipylypiv@google=2Ecom>
>> ---
>>  drivers/ata/libata-eh=2Ec | 22 +++++++++++++++++++---
>>  1 file changed, 19 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/ata/libata-eh=2Ec b/drivers/ata/libata-eh=2Ec
>> index 72a22b6c9682=2E=2Eb373cceb95d2 100644
>> --- a/drivers/ata/libata-eh=2Ec
>> +++ b/drivers/ata/libata-eh=2Ec
>> @@ -640,12 +640,28 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host =
*host, struct ata_port *ap,
>>  		set_host_byte(scmd, DID_OK);
>> =20
>>  		ata_qc_for_each_raw(ap, qc, i) {
>> -			if (qc->flags & ATA_QCFLAG_ACTIVE &&
>> -			    qc->scsicmd =3D=3D scmd)
>> +			if (qc->scsicmd !=3D scmd)
>> +				continue;
>> +			if ((qc->flags & ATA_QCFLAG_ACTIVE) ||
>> +			    qc =3D=3D ap->deferred_qc)
>>  				break;
>>  		}
>> =20
>> -		if (i < ATA_MAX_QUEUE) {
>> +		if (qc =3D=3D ap->deferred_qc) {
>
>An experimental AI code review agent tagged this patch with the following
>comment=2E
>
>  If the `ata_qc_for_each_raw()` loop finishes without finding a matching=
 `scmd`,
>  `qc` will hold a pointer to the last element examined (`i =3D=3D ATA_MA=
X_QUEUE`)=2E

I think the AI is wrong here=2E

That last element assigned to QC will be ATA_MAX_QUEUE - 1=2E


>  If this last element happens to be `ap->deferred_qc`, the condition
>  `qc =3D=3D ap->deferred_qc` evaluates to true despite the loop not brea=
king on a
>  match=2E
>
>  Could this mistakenly intercept a command that completed normally after=
 a SCSI
>  timeout, returning a timeout error instead of success? Would this also
>  incorrectly clear `ap->deferred_qc`, dropping the deferred command?

I think the AI is partially wrong here=2E

If you read the comment below it if (), we know that ap->deferred_qc is on=
ly set until that command has been issued=2E So if it is set, that qc has n=
ot been issued, so it can't have successfully completed=2E

But=2E=2E=2E Since we don't verify that i < ATA_MAX_QUEUE, we might end up=
 completing the deferred QC as a failed command, even though it did not tim=
e out=2E=2E=2E

On NCQ error, we complete the deferred QC as a failed command=2E

However, if there was a timeout of a command, which was not the deferred Q=
C, but the deferred QC did not timeout, I think it is wrong to complete the=
 deferred QC as a failed command=2E

So=2E=2E=2E I actually think that the change suggested by the AI is someth=
ing we want=2E
(Especially after Damien commit queued in for-next where we will not invok=
e error_handler() if there were no timed out commands=2E)


Kind regards,
Niklas
