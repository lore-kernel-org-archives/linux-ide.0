Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB8314A94
	for <linux-ide@vger.kernel.org>; Fri, 20 Feb 2026 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579041; cv=pass; b=H6fC4bTxHPcXPTeXtGjieT1EsZw7c3DXmN3FPaB/M4QVdg8q460IeH3Ktz8aEjbW+XnZR7TF7kVuu+zwVAbl8gWuzrfFN8ebbzNS1j4NBrGjAL+4jrHEaVsJrz4ktTawzr92mXyEZEWcxWP/VnqpA3fFi9Go9nI/UxviHVRQAxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579041; c=relaxed/simple;
	bh=Ar5/VYJKTrEu+AjEBuQ0na/zG9rp9R8NbHE/7dcIZtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kanr/PstLuUEc18QKy1/ST9fFvik9IZ1A8q8ISkNkebM5owPcQkboa/bGZIuMcTF859duVecPh9gFaFpvqw6t0zQcf8CuI0m0SZ0UQnWsfdkkPk+Bgbi9+9MFA+5OvxAKiDsnCTWt8agyXBJEp7V/0XdXxdP7ny6+Y7YEgdVAAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQZYwCz6; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQZYwCz6"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38706f96202so11794031fa.3
        for <linux-ide@vger.kernel.org>; Fri, 20 Feb 2026 01:17:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771579038; cv=none;
        d=google.com; s=arc-20240605;
        b=XfDKlZb1KyOrE2lcDlSGKtXW7WWf1TUB5GePLGI/IGK6VL8fm+SgnTbkzrmr75Xf4Q
         bxCQCDVZvnZd/CxBXQLoi8R4IZ1NbOl3Pn+6fqzXzdEQp/Gcn4kRoHQeO+vJTv7fzwms
         aWOadddi4nEfHr87wDgm3Lugis4n6DXUlCc4G4997nlYo+1oAz7rBT/lIkdBh11N9F2p
         Dx1VshHtF68qOsqe4H212fzf5EZVidI2v7bz58LjvVe/6QBZt5/ba24q1GS01BpPOKyP
         p7xD9qGl74hQyUPWFwPvFXSjzC1Zhv/6VrneGvFERxn6a649wFfydpxIQUgQAFF8mb91
         Bx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=07jstGBqzyundluj2Sk2sFCQdFSf5UXsFw+IQp+pzTo=;
        fh=rk4b+EglNwcnSD41yjOm8cM9TGG5R0E/Vs6P+V6NJGI=;
        b=kC+sYrY5688vdrfs/ktWhn/QaKMG1+7Nzrb4d2ALjxtvPGa2NtkMOpae4B0IBYYOLi
         ybQe/L/2dMSRX50O0D63xKYD4G0uP2SLenN5fNhy2FcWTaK+hY/RBXkhYNTpIvACKfWI
         /9HVB2jJdNYJVS048EUfAvZN81vdkm/mEvKsPnQwfUVAxhUz/Qe46m+fn+xRsNhoHdbt
         +5bKdCEwPqKh3KLzqu7jHNfgl/EkFejMN/bpGR7AdkEMtTlsilsP9knx0hO6S7lY+CLR
         DBGHRXKOqO/fRRlVAyhJRSRYNRNN3VCDzcmVdodmVLFjBe7zS1btDhhBvEg2oUlX2ufw
         5t+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771579038; x=1772183838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=07jstGBqzyundluj2Sk2sFCQdFSf5UXsFw+IQp+pzTo=;
        b=pQZYwCz6yWAAkbw0skTzfC26nSsTcXeLniU/M4CuPBGIcH4RqlApD5rNHNBYYCJz1K
         ua59We1k1OL1QEhpTdT73i/krW/pXOGVZzy9mxig+jCscNo+e/XNm/ifHrJE2F6dRh2d
         YJLLSuo8oHMIooHrLyb/5/ZxOIFuc45OOTIlatTvV/ySZJknX185JWU4pV2BkMDtPqoI
         7MMSOoZxYDQQWNdTqtncEmc+ZF0wG/jNYyV8n9yRlgewfyjJ3TMOi5o0Vr+h8aS1boLG
         1feNJlD47vEtipnccFsHKTa//1cOa9ZE2IKqk2J11mA4qw4HpYPehLBOrj07s3QAhlp1
         dSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771579038; x=1772183838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07jstGBqzyundluj2Sk2sFCQdFSf5UXsFw+IQp+pzTo=;
        b=OrTNlc1a+oB6+zfO/IoulBKHEUFvQ3AAYe9mJw5SWWIri9pYHASCTyrWodNGgwxn05
         Du3Qqywm1liEIPQ891PcGHxV+PNM8jCqYd/hMDa/C71bd0bvNs3AblSVoqJ+QOsZ2fFg
         gKPpyj2jTcNCKfo6/exQjRQ8/aWDe3zN4vw8TjKwCkLvuBynDDN7SB3NKZlP/g2IbJUa
         1bBGHKbV1DW5XcMEgC6qbfeILPXadeE7wUwK7mZ50NVt9c9i/lKHQVafaofVaL5G6rn6
         uqgOkhNpy8sP+TVroP6d3MUfiPFAmGweCaVOj/T6xyP1Qd/6+CGcaNZjJdH9esxmCRDJ
         Hayg==
X-Forwarded-Encrypted: i=1; AJvYcCVJl1hMQq8+zMHbqvHn87jZyggbKf8Fg8Hx5ylU/kF2abcKiJuA5yUQTdT5xKliDm7/h2Zl8AJvZAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPrxiqiDD70FipZSzH3332+Q9Cm0l26GkfZp34RXsH3bWqimES
	hi1j/74o5IARWyfkFX0mhzLp5XKp8nLLyL7fddvPOfJ3ju9F9b9qltPpDj7iAlE292AGrTrt83v
	7FdAdZDXQzhtQX/sk20IqRff5pyb/plj6UKDfIckx
X-Gm-Gg: AZuq6aLA5eWkjrLFkK5lC9193iqWqPopeprgO/KVER3rdz20qbQzm00fGZdmFmX+dHr
	GsNixxZR09nViDXwjCcYsww9j719yCZbFEGbJFJV1GQX/wVMuyuPprtRXjiFuneJF4UbdJtX0F1
	Ug/fGB7hQELHosh/pUDfM4XRk8OnTPXYC6jY7M+lBHjToU7+bou7R/Kmr2L27iE56L0jgusdjBE
	85KRDvomhflXMyA0tHWp/PP771LeHRQzwTkkrtXxN8GdHGALYR9wwUGoGYr72jW0W3ulwVt6rKP
	UptcbADfnXltou9baoQR4tCPna32k0UEH7dEw9A=
X-Received: by 2002:a2e:b8c5:0:b0:386:fd3e:bfe8 with SMTP id
 38308e7fff4ca-38846599d15mr25059881fa.7.1771579037255; Fri, 20 Feb 2026
 01:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6994d5c7.a70a0220.2c38d7.010b.GAE@google.com> <aZWKRkTVIJuLS_Y7@ryzen>
 <1e4e903b-143f-4f95-a41d-2a87cdcaf2c4@kernel.org> <aZeubyGHf1GX0HPA@ryzen> <d49ebdba-9925-414f-8889-877adbad6052@kernel.org>
In-Reply-To: <d49ebdba-9925-414f-8889-877adbad6052@kernel.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 20 Feb 2026 10:17:05 +0100
X-Gm-Features: AaiRm52UElhR-Qyj4G9JcFAq95yyRsjDENxwqu7fb3DEQQAK4ymfz3NeOsKqOzY
Message-ID: <CACT4Y+bASk262w_axUwpYdS=sNgnaXfhDEJ0S3JFCBVdwJidOA@mail.gmail.com>
Subject: Re: [syzbot] [ide?] UBSAN: shift-out-of-bounds in ata_qc_issue
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, 
	syzbot <syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Feb 2026 at 02:06, 'Damien Le Moal' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On 2/20/26 09:55, Niklas Cassel wrote:
> > On Thu, Feb 19, 2026 at 10:33:22AM +0900, Damien Le Moal wrote:
> >>>> UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
> >>>> shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'
> >>>
> >>> 4210818301 is 0xfafbfcfd
> >>>
> >>> 0xfafbfcfd is ATA_TAG_POISON.
> >>>
> >>> ATA_TAG_POISON is set by ata_qc_free(), so it appears that
> >>> ata_scsi_deferred_qc_work() is trying to issue a QC that has
> >>> already been freed.
> >>
> >> I checked the code but I fail to see any path that can lead to this happening.
> >> I did more tests using qemu q35 machine as used by syzbot, and everything looks
> >> fine. So not sure what is happening here. I will dig further.
> >
> > Hello Damien,
> >
> >
> > My best guess:
> > since qc->tag is ATA_TAG_POISON, ata_qc_free() must have been called
> > on ap->deferred_qc.
> >
> > If it was an NCQ abort, ata_eh_set_pending() would have been called to
> > clear ap->deferred_qc. Since ap->deferred_qc is apparently set, it
> > appears that we did not get an error IRQ.
> >
> > To me, that leaves a timeout as the most likely scenario.
>
> Good point. I think the timeout case was completely overlooked...
> That should be fairly easy to debug: I just need to add have the deferred work
> do nothing to see the deferred qc timeout.
>
> Let me hack something and come up with a fix.
>
> >
> > I.e. SCSI EH is called without ata_eh_set_pending() having been called.
> > (Currently ata_eh_set_pending() is the function that clears
> > ap->deferred_qc)
> >
> >
> >
> > If I look at ata_scsi_cmd_error_handler() it will only break if:
> >
> > if (qc->flags & ATA_QCFLAG_ACTIVE && qc->scsicmd == scmd)
> >
> > If the deferred QC times out, flag ATA_QCFLAG_ACTIVE will not be set
> > (because ATA_QCFLAG_ACTIVE is only set by qc_issue()).
> >
> > Since ATA_QCFLAG_ACTIVE is not set i == ATA_MAX_QUEUE, so we will enter the
> > else clause which calls:
> > scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
> >
> >
> > That might potentially free the tag to the block layer to reuse,
> > while ap->deferred_qc is still set (with the same tag).
> >
> > Possibly, next time ata_scsi_qc_issue() is called, ap->deferred_qc is still set,
> > so it calls ata_qc_free(qc), which, since it wasn't cleared, might have the same
> > tag? because block layer has now reused the tag (since SCSI completed the
> > command).
> >
> > I would possibly have expected some kind of print from SCSI in this case.
> > (But since the else clause finishes the command normally, perhaps not?)
> >
> > But perhaps it is wise to add some code to ata_scsi_cmd_error_handler()
> > which clears ap->deferred_qc.
> >
> >
> >
> > Another possibility... again, timed out commands will not have called
> > ata_eh_set_pending(). scsi_timeout() will call scsi_abort_command()
> > which will queue delayed work, and the worker function scmd_eh_abort_handler()
> > will call scsi_eh_scmd_add(), which calls
> > scsi_host_set_state(shost, SHOST_RECOVERY).
> >
> > We did add a guard in libata in commit e20e81a24a4d ("ata: libata-core: do not
> > issue non-internal commands once EH is pending"), so that we will defer commands
> > even when EH is pending. But in the case of timeout, there will be no error IRQ,
> > so we will not do an early return in __ata_scsi_queuecmd(), so we could set
> > qc->deferred_qc up until the worker function scmd_eh_abort_handler() has called
> > scsi_host_set_state(shost, SHOST_RECOVERY).
> >
> > Again, adding some code to ata_scsi_cmd_error_handler() to clear ap->deferred_qc
> > should handle this case.
> >
> >
> > I would probably hack some QEMU to not send a reply, so that we will get block
> > layer timeouts, because right now, ata_scsi_cmd_error_handler() seems like the
> > most likely problematic code to me.

Hi,

Some info I can infer from these 4 crashes.

There is some kind of race, or very rare timing is likely to be
involved. Only 4 crashes is not much. Usually the fuzzer triggers them
more often.

The crash happens in kworker, this makes it impossible to infer when
test programs may be involved.

In all 4 cases there is a preceding USB disconnect message:
[  644.391966][ T5992] usb 11-1: USB disconnect, device number 24
It may be related. These devices can be connected via USB, right?

Unfortunately, I cannot infer much more.
These USB device numbers may theoretically allow to infer the test
program, but I think it's currently not possible.

It may be possible to reply these logs for longer to see if they
trigger the crash.
