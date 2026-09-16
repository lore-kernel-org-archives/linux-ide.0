Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E00499F11
	for <linux-ide@vger.kernel.org>; Wed, 16 Sep 2026 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572584; cv=none; b=thl3kSW/5MsKhjHt420aU1PoSpwm6keFcfp0TLHNd8cPzEd3JaZgpNmp++hdskXTOpqrIFuTcHRTRXhfQmmGykkUoxsMm1adGTrl/0HiTZ9jZnud9yRu+lOb1Ah/ymtouIfjQT62kKqavtxEnNrsMa3yPiUJcrCYMWg/jjNeL2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572584; c=relaxed/simple;
	bh=IAuAq7AfEMYN6bZoSj5fh4iCiJsktZHQdvOkf8LfBug=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KOT7+eP76zZG6GT9gAkvhesRpxyELhBDP/KHycL9EFu88hY7nkSPoO9H4WmwdRNmBULQHNjLsdJqRdbPwTbBmo+6K8/H62VXLUeToVteRRYCAPtN98Gj6a5wrtnDg2Ls0PKUR78EmGr0q4lbX1aev3a+iQEtcsJb3ITGSf4TGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqVW4Il0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsHnEq+A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqVW4Il0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsHnEq+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789572578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16Klj/8b45VwOWfkXP9CkYxD9spB2q1cvTb2rAE2bR0=;
	b=aqVW4Il0OS3a+GnFf3SMVxn10ZSH9ynIcpzXoOSwylz1GYVXuflLQFkzbBFXWfwVid+Ro4
	QqXkV2+PgyJOF2bpFgUrBBCw2N4g/eLYYYj0LCMDUnA9e37bEa9MwtA2/0+MuVzaJqhXwk
	JKgAAW9oIs80QX5ymqTd0aw1tH+NakU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-MX7dhuhEN-O7-1vE46fkYA-1; Wed, 16 Sep 2026 11:29:37 -0400
X-MC-Unique: MX7dhuhEN-O7-1vE46fkYA-1
X-Mimecast-MFC-AGG-ID: MX7dhuhEN-O7-1vE46fkYA_1789572577
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939c30aa9a0so529765585a.0
        for <linux-ide@vger.kernel.org>; Wed, 16 Sep 2026 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789572577; x=1790177377; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=16Klj/8b45VwOWfkXP9CkYxD9spB2q1cvTb2rAE2bR0=;
        b=QsHnEq+Ax44HwcjORznCQk2/j4yBgDfKdxctShXeE6AQ4zc30FaclieFKqSbON1B6q
         8tItP4wSzENeHZcUAkdj6/v9gBqjWf9jBU3CtQpwaQJZSMJeJpZyRFQHpanatRNoHiCh
         0zT5gdzbAAoNz7GASrAhYzbEQZDaAEDNjeVHmIvD/xSRlPch4YJrzAsbIDOp2vRiVBIl
         h0EStmu/qEBEcmUuxh56uv5fGYsQ5BjeavfPeBL6VUdBmADX95T59bt2bnLVl5/uNT9K
         VQ6lRj4JxKp9nS1/NIgqx4h1h/39mhcgX5To8QLPN7RZyYyVul+aX64kQoqPF8pmSgY0
         aS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572577; x=1790177377;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=16Klj/8b45VwOWfkXP9CkYxD9spB2q1cvTb2rAE2bR0=;
        b=ZUzhTlKD71FlUGEAmfnis+rbl0ScW8ooRbVu9cg6yxoiHdDR+7j6GKQ2C73S5NLEPs
         HCZw0E1zWEkZ6vc2r8J9rLAT5wPhXUe/FwJs5BywH5DDOGQY7Oe8ayT8/7/PnQEq8/TU
         IM88373wixW5xAcOEKdvh+813jtm4Uvah9MwoZZnyHRywf39gyejzZOg2Q1wJKduLxQ9
         8Y4ld+Uijm7EK8iE2/M2pf+dHI0F49CptNy4og5zZ/Hd415FFwQkhUWChiv3k+7k97bN
         OBaanM1fOK+AMp8jpW+rsjqlWeQvabQCcskDony3SJA7BUF2nDObw2kpjrNhqd2/2jWk
         L6Xg==
X-Gm-Message-State: AFuF++nwE5b4NsZLZd8sDCweTkMZZbovah9ImFKgcu9z/tekcTpcwNIs
	ATaFD+kSJH4HbiCzNvqWwV352Q7oAs9mZ+LpkW8Hqt7okEc6KkIzvmkwuTkujfDhlwC30sk0C/4
	DU6miHk37GDkMDZo1oz77SL6WOoyZ+RzXiNM9vX7EXacx6VAdozRV8zovh4IVbQ==
X-Gm-Gg: AYBFou3PiQw7Mz47DRAk1eOwy99y8VHXDyP0EJr4iVkLVLB4BDFbNv+7ZY1Q2sy8jnO
	kDEQXoD1FvTDjTi10HS9HR2sWAvMGgI9sEZGOqWURZ7uuaB01+fjrXB8EdIifXYlTVu0bQfWXHW
	dXjgGV+OwZ3nMpHQzyHc3YOBjkkxOlCnX04Yu/wYHeATbQAklBr/QW7JtkRt+jELOBqi01edxPE
	aNXM7kraRyFvIKjIFgdZqyVpcP/G/x37WVuOcv8LM80aRlpRHz33r50+9bRuCkx4W8FzyI4ODQp
	5X77YHdZqDCYX9UsDiA+aBjTEg8/abJiI22clkzgTmXz5JRVFK4S5M/UnV66QLu8U23Nv8DqfMO
	kOG9k/u1781y1mQcWHq1oUU3mAuJkKPgqGH3c
X-Received: by 2002:a05:620a:2548:b0:93a:273:6a41 with SMTP id af79cd13be357-93bb791b543mr474137585a.29.1789572576627;
        Wed, 16 Sep 2026 08:29:36 -0700 (PDT)
X-Received: by 2002:a05:620a:2548:b0:93a:273:6a41 with SMTP id af79cd13be357-93bb791b543mr474129085a.29.1789572576026;
        Wed, 16 Sep 2026 08:29:36 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:dbb1:97f1:a6e6:766b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81d18e5asm246235785a.44.2026.09.16.08.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:29:35 -0700 (PDT)
Message-ID: <2ff511fa29b801ab74ce9ee60e1257c47918c1db.camel@redhat.com>
Subject: Re: [PATCH 12/37] scsi: st: use 16-bits defined sense codes
From: Laurence Oberman <loberman@redhat.com>
To: sashiko-reviews@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, cassel@kernel.org
Date: Wed, 16 Sep 2026 11:29:34 -0400
In-Reply-To: <20260831021927.90FD21F00A3D@smtp.kernel.org>
References: <20260831020451.585944-1-dlemoal@kernel.org>
	 <20260831020451.585944-13-dlemoal@kernel.org>
	 <20260831021927.90FD21F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-31 at 02:19 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Medium] Incorrectly assigning ASC value to ASCQ in SCSI
> tracepoint.
> --
>=20
> commit c1f7c0aa9501c3562bd45de8a85431d940fa338b
> Author: Damien Le Moal <dlemoal@kernel.org>
> Subject: scsi: st: use 16-bits defined sense codes
>=20
> This commit refactors the SCSI tape driver to use the 16-bit
> sense_code
> field of struct scsi_sense_hdr. It replaces hard-coded additional
> sense
> codes and qualifiers with enum values defined in
> include/scsi/scsi_sense.h
> to improve code clarity.
>=20
> While reviewing this patch series, I noticed an issue introduced in
> the
> related change to include/trace/events/scsi.h:
>=20
> > diff --git a/include/trace/events/scsi.h
> > b/include/trace/events/scsi.h
> > --- a/include/trace/events/scsi.h
> > +++ b/include/trace/events/scsi.h
> > @@ -303,8 +303,8 @@
> > DECLARE_EVENT_CLASS(scsi_cmd_done_timeout_template,
> > =C2=A0		if (cmd->sense_buffer && SCSI_SENSE_VALID(cmd) &&
> > =C2=A0		=C2=A0=C2=A0=C2=A0 scsi_command_normalize_sense(cmd, &sshdr)) {
> > =C2=A0			__entry->sense_key =3D sshdr.sense_key;
> > -			__entry->asc =3D sshdr.asc;
> > -			__entry->ascq =3D sshdr.ascq;
> > +			__entry->asc =3D scsi_sense_asc(&sshdr);
> > +			__entry->ascq =3D scsi_sense_asc(&sshdr); <-
> > --- here
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^^^^^^^^^^^^^^
>=20
> [Severity: Medium]
> Is there a typo in this assignment?
>=20
> In the scsi_cmd_done_timeout_template tracepoint, __entry->ascq is
> being
> assigned scsi_sense_asc(&sshdr) instead of the ASCQ value. This
> appears to
> log the Additional Sense Code for both the asc and ascq fields, which
> will
> result in lost diagnostic data when userspace tools analyze SCSI
> errors via
> tracepoints.
>=20
> Should this use scsi_sense_ascq(&sshdr) for the ascq field instead?

Hello Damien
This seems to be real issue here that sashiko found

We assign the same for=C2=A0__entry->ascq  as we do for __entry->asc i.e.
scsi_sense_asc(&sshdr)

We need to have it as

+			__entry->asc =3D scsi_sense_asc(&sshdr);
+			__entry->ascq =3D scsi_sense_ascq(&sshdr); <--

Otherwise we will miss the ASCQ

Thanks
Laurence



